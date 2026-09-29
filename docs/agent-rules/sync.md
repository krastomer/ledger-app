# Offline-first and sync

The app has two modes:

1. **Offline** — the current focus. No account, no server, no network.
   Every feature works on the device alone.
2. **Sync** — planned, not built yet. The user connects one sync target.
   The first target is our own server.

In offline mode the local database is the source of truth. In sync mode
the server journal is, and the app works from a local mirror plus an
outbox, so it still runs without a network. Sync is an optional adapter,
never a dependency of any feature.

## Rules for now (offline work)

Don't build sync code yet, but don't make it harder to add later:

- **IDs are generated on the device** as time-ordered UUIDs (v7). Never
  use SQLite autoincrement IDs as a domain identity, and never wait for a
  server to assign an ID.
- **Deletes are soft.** Set `deleted_at` (a tombstone) instead of
  removing the row. Queries filter tombstones out.
- **Every write goes through a repository**, and the repository appends a
  change-log entry in the same DB transaction as the write:
  `id, entity, entity_id, op (create | update | delete), payload,
  device_id, created_at`. The change log is kept in offline mode too, so
  turning sync on later can push the full history.
- **A transaction is the unit of change.** Its postings are written,
  logged and (later) synced together, never one posting at a time, so the
  postings always sum to zero.
- **Balances and reports are derived.** Compute them from postings; any
  stored totals are a rebuildable cache, not data.
- No network packages, login, or account screens for this work.

## Planned: server sync

Not in scope yet. Recorded so the offline design stays compatible. The
backend side is also tracked in `~/workspaces/hledger-project/planning/2026-09-slip-app-plan.md`.

### Storage

- **On the device**: SQLite in both modes. Never `.journal` files.
- **On the server**: the existing hledger journal in git
  (`pi@hermes.local:hledger.git`) stays the single source of truth. Other
  writers (month-end statement imports, hand edits) keep working on the
  journal text, so the server never moves it into a database.
- **The app never writes journal text or touches git.** The server is a
  thin API over hledger + git and does all rendering.

### Push (add an entry)

The app sends a transaction as JSON. The server:

1. renders it as hledger text, with an `; id:<uuid>` tag;
2. appends it to `journal/<year>.journal` (the file for not-yet-reviewed
   entries) as a pending `!` transaction;
3. runs `hledger check`;
4. commits if the check passes, otherwise rejects with the error for the
   app to show.

A push that repeats an `id` already in the journal is a no-op, so retries
are safe.

### Pull

- The cursor is the journal's git commit hash. Same hash: nothing to do.
- New hash: the server returns the whole journal as `hledger print -O
  json`, and the app replaces its local mirror. At a few thousand
  transactions this is a few hundred KB gzipped, so no diffing.
- The Pi runs an older hledger; check its JSON output before relying on a
  field.

### Local data in sync mode: mirror + outbox

```
         pull (replace all)
Server ───────────────────▶ Mirror  (read-only)
  ▲                           │
  │ push                      ▼
Outbox ──── overlay ──────▶ View  (what the UI and balances use)
  ▲
  └── user saves / edits / deletes
```

**Mirror**: the server journal as of the last pulled commit.

- Same transaction / posting / tag / status tables as offline mode, plus
  `sync_state` (last commit hash, last pull time).
- A pull parses the JSON and replaces the whole mirror in **one DB
  transaction**, so the UI never sees half old, half new data.
- The app never writes to the mirror; every change goes through the
  outbox.
- Entries with an `id:` tag use that id. Entries without one (statement
  imports) get a derived key for display only; they aren't editable.
- Each mirrored transaction keeps a `version`: a hash of that
  transaction as pulled. Edits use it for conflict checks.

**Outbox**: local ops the server hasn't accepted yet. In offline mode this
is the change log; turning sync on starts pushing it.

| Field | Meaning |
|---|---|
| `op_id` | UUID of the op; the idempotency key |
| `txn_id` | transaction the op acts on |
| `op` | create / update / delete |
| `payload` | the whole transaction, not a diff |
| `base_version` | mirror `version` the edit was based on (update/delete) |
| `state` | pending / rejected |
| `error` | server message when rejected |

- Ops for the same transaction collapse before push: several updates keep
  only the latest; create then delete drops both.
- Ops are independent: a rejected op never blocks the others.

**View**: the mirror with the outbox overlaid, built in the repository
(the UI doesn't know there are two layers):

- `create` adds a row, marked "not synced";
- `update` replaces the mirror row with the same id;
- `delete` hides the mirror row;
- `rejected` shows the row with the server's error.

Balances and reports are computed from the view.

**Lifecycle of one entry**

1. Save → outbox `create` (pending); the row appears at once, "not
   synced".
2. Online → push; the server appends, checks, commits and returns the new
   commit hash.
3. Pull straight away. In one DB transaction: replace the mirror, then
   delete the ops whose transaction is now in the mirror. Never delete an
   op on the push ack alone, or the row flickers out of the list between
   ack and pull.
4. Month end: the desktop flips `!` → `*`; the next pull shows it
   cleared.

### Edits, conflicts and scope

- **Phase 1**: the app may edit or delete only the pending `!` entries it
  created (found by `id` tag). Entries from statement imports are
  read-only in the app; flipping `!` → `*` and reconciliation stay on the
  desktop workflow, which must keep the `id:` tag when it flips.
- An update/delete carries `base_version`. The server compares it with
  the current version of **that transaction**, not the whole journal, so
  unrelated commits (e.g. a statement import) never cause a conflict.
- Rejections and what the app does:
  - `hledger check` fails (unknown account, broken balance assertion):
    op becomes `rejected`; the user fixes and resends, or discards it.
  - transaction was already flipped to `*`: tell the user it's
    reconciled and drop the op.
  - transaction is gone from the journal (e.g. removed as a duplicate):
    tell the user and drop the op.
- Offline for a long time is fine; show "last synced …" because the
  mirror may be stale.
- Transactions carry a status (unmarked, `!` pending, `*` cleared) to
  match the journal.
- Account names must match the journal's English hierarchy
  (`Assets:Bank:KBank`, `Expenses:Food`), or go through an explicit
  mapping.

### Mode changes

- offline → sync: push the offline entries through the same push path;
  each one must pass `hledger check`.
- sync → offline: stop syncing; the local mirror and outbox become plain
  local data.
- Other targets (cloud drives, WebDAV) may come later; keep the push
  payload transport-agnostic.

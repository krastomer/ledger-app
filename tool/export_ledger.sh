#!/bin/sh
# Exports a ledger as `hledger print -O json`, the format the app pulls.
#
#   tool/export_ledger.sh
#     demo data: tool/sample_ledger.journal -> assets/ledger/sample.json
#   tool/export_ledger.sh <main.journal> [YYYY-MM]
#     opening balances + one month (default: this month) of a real journal
#     -> assets/ledger/local.json (gitignored; personal data, never commit)
#
# Run the app on local data with
#   flutter run --dart-define=LEDGER_ASSET=assets/ledger/local.json
set -eu

cd "$(dirname "$0")/.."

if [ $# -eq 0 ]; then
  hledger -f tool/sample_ledger.journal print -O json > assets/ledger/sample.json
  echo "wrote assets/ledger/sample.json"
  exit 0
fi

journal=$1
month=${2:-$(date +%Y-%m)}
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
{
  hledger -f "$journal" close --open -e "$month-01"
  echo
  hledger -f "$journal" print -p "$month"
} > "$tmp"
hledger -f "$tmp" print -O json > assets/ledger/local.json
echo "wrote assets/ledger/local.json ($month)"

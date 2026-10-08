import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/domain/models/money.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_draft.dart';
import 'package:ledger_app/domain/models/slip_order.dart';
import 'package:ledger_app/domain/models/slip_party.dart';

void main() {
  group('SlipParty', () {
    test('is equal by name and account', () {
      const party = SlipParty(name: 'A', account: 'xxx-1');

      expect(party, const SlipParty(name: 'A', account: 'xxx-1'));
      expect(
        party.hashCode,
        const SlipParty(name: 'A', account: 'xxx-1').hashCode,
      );
      expect(party, isNot(const SlipParty(name: 'A')));
      expect(party, isNot(const SlipParty(name: 'B', account: 'xxx-1')));
    });

    test('prints the name and masked account', () {
      expect(
        const SlipParty(name: 'A', account: 'xxx-1').toString(),
        'SlipParty(A, xxx-1)',
      );
    });
  });

  group('SlipOrder', () {
    const order = SlipOrder(
      symbol: 'NVDA',
      quantity: '0.5',
      unit: 'shares',
      price: Money(20947, currency: 'USD'),
      foreignAmount: Money(10473, currency: 'USD'),
      exchangeRate: '32.72',
    );

    test('is equal when every field is', () {
      expect(order, equals(_copyOf(order)));
      expect(order.hashCode, _copyOf(order).hashCode);
    });

    test('differs when any field does', () {
      expect(order, isNot(_copyOf(order, symbol: 'TSM')));
      expect(order, isNot(_copyOf(order, quantity: '0.6')));
      expect(order, isNot(_copyOf(order, unit: 'oz')));
      expect(order, isNot(_copyOf(order, price: const Money(1))));
      expect(order, isNot(_copyOf(order, foreignAmount: const Money(1))));
      expect(order, isNot(_copyOf(order, exchangeRate: '33')));
    });

    test('describes the order for debugging', () {
      expect(order.toString(), contains('NVDA'));
      expect(order.toString(), contains('rate 32.72'));
    });
  });

  group('Slip', () {
    final slip = Slip(
      source: SlipSource.kbank,
      kind: SlipKind.transfer,
      timestamp: DateTime.utc(2026, 9, 29, 2, 15),
      reference: 'REF',
      amount: const Money(1000),
      fee: const Money(0),
      from: const SlipParty(name: 'A'),
      to: const SlipParty(name: 'B'),
    );

    test('is equal when every field is', () {
      expect(slip, equals(_slipLike(slip)));
      expect(slip.hashCode, _slipLike(slip).hashCode);
    });

    test('differs when any field does', () {
      expect(slip, isNot(_slipLike(slip, source: SlipSource.scb)));
      expect(slip, isNot(_slipLike(slip, kind: SlipKind.payment)));
      expect(slip, isNot(_slipLike(slip, reference: 'OTHER')));
      expect(slip, isNot(_slipLike(slip, amount: const Money(1))));
      expect(slip, isNot(_slipLike(slip, fee: const Money(5))));
      expect(slip, isNot(_slipLike(slip, to: const SlipParty(name: 'C'))));
      expect(slip, isNot(_slipLike(slip, order: const SlipOrder(symbol: 'X'))));
      expect(
        slip,
        isNot(_slipLike(slip, timestamp: DateTime.utc(2026, 9, 29))),
      );
    });

    test('describes the slip for debugging', () {
      expect(slip.toString(), startsWith('Slip(kbank transfer'));
      expect(slip.toString(), contains('ref REF'));
    });
  });

  group('ParsedSlip', () {
    test('lists the required fields a transfer is missing', () {
      final parsed = ParsedSlip(
        const Slip(source: SlipSource.kbank, kind: SlipKind.transfer),
      );

      expect(parsed.isComplete, isFalse);
      expect(
        parsed.missing,
        containsAll([
          SlipField.timestamp,
          SlipField.reference,
          SlipField.amount,
          SlipField.from,
          SlipField.to,
        ]),
      );
      expect(parsed.toString(), startsWith('ParsedSlip('));
    });

    test('asks an order for its quantity and price instead of parties', () {
      final parsed = ParsedSlip(
        Slip(
          source: SlipSource.dime,
          kind: SlipKind.buy,
          timestamp: DateTime.utc(2026),
          reference: 'ORD',
          amount: const Money(100),
          order: const SlipOrder(symbol: 'NVDA'),
        ),
      );

      expect(parsed.missing, {SlipField.quantity, SlipField.price});
    });

    test('is complete when everything required is present', () {
      final parsed = ParsedSlip(
        Slip(
          source: SlipSource.kbank,
          kind: SlipKind.payment,
          timestamp: DateTime.utc(2026),
          reference: 'REF',
          amount: const Money(100),
          from: const SlipParty(name: 'A'),
          to: const SlipParty(name: 'B'),
        ),
      );

      expect(parsed.isComplete, isTrue);
    });
  });

  group('SlipDraft.checkOf', () {
    SlipDraft draftOf(
      Slip slip, [
      Map<SlipField, double> confidence = const {},
    ]) => SlipDraft(
      imagePath: 'slip.jpg',
      parsed: ParsedSlip(slip, confidence: confidence),
      sourceAccount: 'Assets:Bank:KBank',
      categoryFromHistory: false,
      accounts: const [],
    );

    final order = SlipOrder(
      symbol: 'NVDA',
      quantity: '1',
      price: const Money(100, currency: 'USD'),
      foreignAmount: const Money(100, currency: 'USD'),
      exchangeRate: '32',
    );
    final full = Slip(
      source: SlipSource.dime,
      kind: SlipKind.buy,
      timestamp: DateTime.utc(2026),
      reference: 'REF',
      amount: const Money(100),
      fee: const Money(1),
      from: const SlipParty(name: 'A'),
      to: const SlipParty(name: 'B'),
      order: order,
    );

    test('is ok for every field present with no doubt', () {
      final draft = draftOf(full);

      for (final field in SlipField.values) {
        expect(draft.checkOf(field), SlipFieldCheck.ok, reason: '$field');
      }
    });

    test('is absent for fields this slip does not show', () {
      final draft = draftOf(
        Slip(
          source: SlipSource.kbank,
          kind: SlipKind.transfer,
          timestamp: DateTime.utc(2026),
          reference: 'REF',
          amount: const Money(100),
          from: const SlipParty(name: 'A'),
          to: const SlipParty(name: 'B'),
        ),
      );

      for (final field in [
        SlipField.fee,
        SlipField.quantity,
        SlipField.price,
        SlipField.foreignAmount,
        SlipField.exchangeRate,
      ]) {
        expect(draft.checkOf(field), SlipFieldCheck.absent, reason: '$field');
      }
    });

    test('asks to check a required field that could not be read', () {
      final draft = draftOf(
        const Slip(source: SlipSource.kbank, kind: SlipKind.transfer),
      );

      expect(draft.checkOf(SlipField.amount), SlipFieldCheck.check);
      expect(draft.checkOf(SlipField.to), SlipFieldCheck.check);
    });

    test('asks to check a field read below the confidence bar', () {
      final draft = draftOf(full, {
        SlipField.amount: 0.74,
        SlipField.reference: 0.75,
      });

      expect(draft.checkOf(SlipField.amount), SlipFieldCheck.check);
      expect(draft.checkOf(SlipField.reference), SlipFieldCheck.ok);
    });
  });
}

SlipOrder _copyOf(
  SlipOrder order, {
  String? symbol,
  String? quantity,
  String? unit,
  Money? price,
  Money? foreignAmount,
  String? exchangeRate,
}) => SlipOrder(
  symbol: symbol ?? order.symbol,
  quantity: quantity ?? order.quantity,
  unit: unit ?? order.unit,
  price: price ?? order.price,
  foreignAmount: foreignAmount ?? order.foreignAmount,
  exchangeRate: exchangeRate ?? order.exchangeRate,
);

Slip _slipLike(
  Slip slip, {
  SlipSource? source,
  SlipKind? kind,
  DateTime? timestamp,
  String? reference,
  Money? amount,
  Money? fee,
  SlipParty? from,
  SlipParty? to,
  SlipOrder? order,
}) => Slip(
  source: source ?? slip.source,
  kind: kind ?? slip.kind,
  timestamp: timestamp ?? slip.timestamp,
  reference: reference ?? slip.reference,
  amount: amount ?? slip.amount,
  fee: fee ?? slip.fee,
  from: from ?? slip.from,
  to: to ?? slip.to,
  order: order ?? slip.order,
);

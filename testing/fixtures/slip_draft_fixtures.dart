import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/domain/models/money.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_party.dart';

/// A K PLUS transfer slip as the parser would return it.
ParsedSlip transferSlip({
  String? reference = 'REF-NEW',
  int? satang = 850000,
  int? feeSatang,
  String payee = 'Sample Property Co., Ltd.',
  DateTime? timestamp,
  Map<SlipField, double> confidence = const {},
}) => ParsedSlip(
  Slip(
    source: SlipSource.kbank,
    kind: SlipKind.transfer,
    timestamp: timestamp ?? DateTime.utc(2026, 9, 29, 2, 15),
    reference: reference,
    amount: satang == null ? null : Money(satang),
    fee: feeSatang == null ? null : Money(feeSatang),
    from: const SlipParty(name: 'Mr. A. Sample', account: 'xxx-x-x1234-x'),
    to: SlipParty(name: payee),
  ),
  confidence: confidence,
);

import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/data/repositories/slip/slip_repository.dart';
import 'package:ledger_app/utils/result.dart';

class FakeSlipRepository implements SlipRepository {
  FakeSlipRepository(this.slips, {this.picked = const []});

  /// What each image path reads as; missing paths fail.
  final Map<String, ParsedSlip> slips;

  /// What [pickImages] returns.
  final List<String> picked;

  @override
  Future<Result<List<String>>> pickImages() async => Result.ok(picked);

  @override
  Future<Result<ParsedSlip>> read(String imagePath) async =>
      switch (slips[imagePath]) {
        final slip? => Result.ok(slip),
        null => Result.error(Exception('unreadable $imagePath')),
      };
}

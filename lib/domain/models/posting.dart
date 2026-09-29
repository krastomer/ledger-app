import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

part 'posting.freezed.dart';

const accountSeparator = ':';

/// One leg of a transaction. Positive amounts debit [account], negative
/// amounts credit it; a transaction's postings sum to zero.
@freezed
abstract class Posting with _$Posting {
  const factory Posting({required String account, required Money amount}) =
      _Posting;

  const Posting._();

  String get rootAccount => account.split(accountSeparator).first;

  String get leafName => account.split(accountSeparator).last;
}

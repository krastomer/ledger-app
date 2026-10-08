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

  String get rootAccount {
    final end = account.indexOf(accountSeparator);
    return end < 0 ? account : account.substring(0, end);
  }

  /// The account's first two levels, e.g. `Expenses:Food`.
  String get category {
    final first = account.indexOf(accountSeparator);
    if (first < 0) return account;
    final second = account.indexOf(accountSeparator, first + 1);
    return second < 0 ? account : account.substring(0, second);
  }

  String get leafName =>
      account.substring(account.lastIndexOf(accountSeparator) + 1);
}

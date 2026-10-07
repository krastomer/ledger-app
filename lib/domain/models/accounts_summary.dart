import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

import 'account_node.dart';
import 'account_type.dart';

part 'accounts_summary.freezed.dart';

@freezed
abstract class AccountSection with _$AccountSection {
  const factory AccountSection({
    required AccountType type,

    /// Root accounts with their balances; income and expenses are this
    /// month's totals.
    required List<AccountNode> balance,

    /// Root accounts with this month's movement.
    required List<AccountNode> monthChange,
  }) = _AccountSection;

  const AccountSection._();

  bool get isEmpty => balance.isEmpty && monthChange.isEmpty;
}

@freezed
abstract class AccountsSummary with _$AccountsSummary {
  const factory AccountsSummary({
    required DateTime asOf,
    required Money netWorth,
    required Money assets,
    required Money liabilities,
    required List<AccountSection> sections,
  }) = _AccountsSummary;

  const AccountsSummary._();

  bool get isEmpty => sections.every((section) => section.isEmpty);
}

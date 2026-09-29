import 'package:freezed_annotation/freezed_annotation.dart';

import 'account_type.dart';

part 'account.freezed.dart';

/// A top-level account declaration. Account names can be in any language,
/// so the type is declared here instead of guessed from the name.
@freezed
abstract class Account with _$Account {
  const factory Account({required String name, required AccountType type}) =
      _Account;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slip_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SlipDraft {

 String get imagePath; ParsedSlip get parsed;/// Null when the slip shows no amount, so there is nothing to book.
 LedgerTransaction? get transaction;/// The saved entry that already has this slip's reference.
 LedgerTransaction? get duplicate;/// The bank or broker account the slip moves money in.
 String get sourceAccount;/// Whether the category came from an earlier entry for the same payee.
 bool get categoryFromHistory;/// Accounts already in use, to pick from.
 List<String> get accounts;
/// Create a copy of SlipDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlipDraftCopyWith<SlipDraft> get copyWith => _$SlipDraftCopyWithImpl<SlipDraft>(this as SlipDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SlipDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlipDraft&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath)&&(identical(other.parsed, _this.parsed) || other.parsed == _this.parsed)&&(identical(other.transaction, _this.transaction) || other.transaction == _this.transaction)&&(identical(other.duplicate, _this.duplicate) || other.duplicate == _this.duplicate)&&(identical(other.sourceAccount, _this.sourceAccount) || other.sourceAccount == _this.sourceAccount)&&(identical(other.categoryFromHistory, _this.categoryFromHistory) || other.categoryFromHistory == _this.categoryFromHistory)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts));
}


@override
int get hashCode {
  final _this = this as SlipDraft;
  return Object.hash(runtimeType,_this.imagePath,_this.parsed,_this.transaction,_this.duplicate,_this.sourceAccount,_this.categoryFromHistory,const DeepCollectionEquality().hash(_this.accounts));
}

@override
String toString() {
  final _this = this as SlipDraft;
  return 'SlipDraft(imagePath: ${_this.imagePath}, parsed: ${_this.parsed}, transaction: ${_this.transaction}, duplicate: ${_this.duplicate}, sourceAccount: ${_this.sourceAccount}, categoryFromHistory: ${_this.categoryFromHistory}, accounts: ${_this.accounts})';
}


}

/// @nodoc
abstract mixin class $SlipDraftCopyWith<$Res>  {
  factory $SlipDraftCopyWith(SlipDraft value, $Res Function(SlipDraft) _then) = _$SlipDraftCopyWithImpl;
@useResult
$Res call({
 String imagePath, ParsedSlip parsed, LedgerTransaction? transaction, LedgerTransaction? duplicate, String sourceAccount, bool categoryFromHistory, List<String> accounts
});


$LedgerTransactionCopyWith<$Res>? get transaction;$LedgerTransactionCopyWith<$Res>? get duplicate;

}
/// @nodoc
class _$SlipDraftCopyWithImpl<$Res>
    implements $SlipDraftCopyWith<$Res> {
  _$SlipDraftCopyWithImpl(this._self, this._then);

  final SlipDraft _self;
  final $Res Function(SlipDraft) _then;

/// Create a copy of SlipDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imagePath = null,Object? parsed = null,Object? transaction = freezed,Object? duplicate = freezed,Object? sourceAccount = null,Object? categoryFromHistory = null,Object? accounts = null,}) {
  return _then(SlipDraft(
imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,parsed: null == parsed ? _self.parsed : parsed // ignore: cast_nullable_to_non_nullable
as ParsedSlip,transaction: freezed == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as LedgerTransaction?,duplicate: freezed == duplicate ? _self.duplicate : duplicate // ignore: cast_nullable_to_non_nullable
as LedgerTransaction?,sourceAccount: null == sourceAccount ? _self.sourceAccount : sourceAccount // ignore: cast_nullable_to_non_nullable
as String,categoryFromHistory: null == categoryFromHistory ? _self.categoryFromHistory : categoryFromHistory // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SlipDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerTransactionCopyWith<$Res>? get transaction {
    if (_self.transaction == null) {
    return null;
  }

  return $LedgerTransactionCopyWith<$Res>(_self.transaction!, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}/// Create a copy of SlipDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerTransactionCopyWith<$Res>? get duplicate {
    if (_self.duplicate == null) {
    return null;
  }

  return $LedgerTransactionCopyWith<$Res>(_self.duplicate!, (value) {
    return _then(_self.copyWith(duplicate: value));
  });
}
}


/// Adds pattern-matching-related methods to [SlipDraft].
extension SlipDraftPatterns on SlipDraft {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlipDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlipDraft() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlipDraft value)  $default,){
final _that = this;
switch (_that) {
case _SlipDraft():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlipDraft value)?  $default,){
final _that = this;
switch (_that) {
case _SlipDraft() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String imagePath,  ParsedSlip parsed,  LedgerTransaction? transaction,  LedgerTransaction? duplicate,  String sourceAccount,  bool categoryFromHistory,  List<String> accounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlipDraft() when $default != null:
return $default(_that.imagePath,_that.parsed,_that.transaction,_that.duplicate,_that.sourceAccount,_that.categoryFromHistory,_that.accounts);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String imagePath,  ParsedSlip parsed,  LedgerTransaction? transaction,  LedgerTransaction? duplicate,  String sourceAccount,  bool categoryFromHistory,  List<String> accounts)  $default,) {final _that = this;
switch (_that) {
case _SlipDraft():
return $default(_that.imagePath,_that.parsed,_that.transaction,_that.duplicate,_that.sourceAccount,_that.categoryFromHistory,_that.accounts);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String imagePath,  ParsedSlip parsed,  LedgerTransaction? transaction,  LedgerTransaction? duplicate,  String sourceAccount,  bool categoryFromHistory,  List<String> accounts)?  $default,) {final _that = this;
switch (_that) {
case _SlipDraft() when $default != null:
return $default(_that.imagePath,_that.parsed,_that.transaction,_that.duplicate,_that.sourceAccount,_that.categoryFromHistory,_that.accounts);case _:
  return null;

}
}

}

/// @nodoc


class _SlipDraft extends SlipDraft {
  const _SlipDraft({required this.imagePath, required this.parsed, this.transaction, this.duplicate, required this.sourceAccount, required this.categoryFromHistory, required  List<String> accounts}): _accounts = accounts,super._();
  

@override final  String imagePath;
@override final  ParsedSlip parsed;
/// Null when the slip shows no amount, so there is nothing to book.
@override final  LedgerTransaction? transaction;
/// The saved entry that already has this slip's reference.
@override final  LedgerTransaction? duplicate;
/// The bank or broker account the slip moves money in.
@override final  String sourceAccount;
/// Whether the category came from an earlier entry for the same payee.
@override final  bool categoryFromHistory;
/// Accounts already in use, to pick from.
 final  List<String> _accounts;
/// Accounts already in use, to pick from.
@override List<String> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}


/// Create a copy of SlipDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlipDraftCopyWith<_SlipDraft> get copyWith => __$SlipDraftCopyWithImpl<_SlipDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlipDraft&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.parsed, parsed) || other.parsed == parsed)&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.duplicate, duplicate) || other.duplicate == duplicate)&&(identical(other.sourceAccount, sourceAccount) || other.sourceAccount == sourceAccount)&&(identical(other.categoryFromHistory, categoryFromHistory) || other.categoryFromHistory == categoryFromHistory)&&const DeepCollectionEquality().equals(other.accounts, _accounts));
}


@override
int get hashCode {
    return Object.hash(runtimeType,imagePath,parsed,transaction,duplicate,sourceAccount,categoryFromHistory,const DeepCollectionEquality().hash(_accounts));
}

@override
String toString() {
    return 'SlipDraft(imagePath: $imagePath, parsed: $parsed, transaction: $transaction, duplicate: $duplicate, sourceAccount: $sourceAccount, categoryFromHistory: $categoryFromHistory, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class _$SlipDraftCopyWith<$Res> implements $SlipDraftCopyWith<$Res> {
  factory _$SlipDraftCopyWith(_SlipDraft value, $Res Function(_SlipDraft) _then) = __$SlipDraftCopyWithImpl;
@override @useResult
$Res call({
 String imagePath, ParsedSlip parsed, LedgerTransaction? transaction, LedgerTransaction? duplicate, String sourceAccount, bool categoryFromHistory, List<String> accounts
});


@override $LedgerTransactionCopyWith<$Res>? get transaction;@override $LedgerTransactionCopyWith<$Res>? get duplicate;

}
/// @nodoc
class __$SlipDraftCopyWithImpl<$Res>
    implements _$SlipDraftCopyWith<$Res> {
  __$SlipDraftCopyWithImpl(this._self, this._then);

  final _SlipDraft _self;
  final $Res Function(_SlipDraft) _then;

/// Create a copy of SlipDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imagePath = null,Object? parsed = null,Object? transaction = freezed,Object? duplicate = freezed,Object? sourceAccount = null,Object? categoryFromHistory = null,Object? accounts = null,}) {
  return _then(_SlipDraft(
imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,parsed: null == parsed ? _self.parsed : parsed // ignore: cast_nullable_to_non_nullable
as ParsedSlip,transaction: freezed == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as LedgerTransaction?,duplicate: freezed == duplicate ? _self.duplicate : duplicate // ignore: cast_nullable_to_non_nullable
as LedgerTransaction?,sourceAccount: null == sourceAccount ? _self.sourceAccount : sourceAccount // ignore: cast_nullable_to_non_nullable
as String,categoryFromHistory: null == categoryFromHistory ? _self.categoryFromHistory : categoryFromHistory // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SlipDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerTransactionCopyWith<$Res>? get transaction {
    if (_self.transaction == null) {
    return null;
  }

  return $LedgerTransactionCopyWith<$Res>(_self.transaction!, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}/// Create a copy of SlipDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerTransactionCopyWith<$Res>? get duplicate {
    if (_self.duplicate == null) {
    return null;
  }

  return $LedgerTransactionCopyWith<$Res>(_self.duplicate!, (value) {
    return _then(_self.copyWith(duplicate: value));
  });
}
}

// dart format on

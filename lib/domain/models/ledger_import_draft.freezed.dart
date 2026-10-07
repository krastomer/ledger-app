// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_import_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LedgerImportDraft {

 String get fileName; int get sizeBytes; List<Account> get accounts; List<LedgerTransaction> get transactions;
/// Create a copy of LedgerImportDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerImportDraftCopyWith<LedgerImportDraft> get copyWith => _$LedgerImportDraftCopyWithImpl<LedgerImportDraft>(this as LedgerImportDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LedgerImportDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerImportDraft&&(identical(other.fileName, _this.fileName) || other.fileName == _this.fileName)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.transactions, _this.transactions));
}


@override
int get hashCode {
  final _this = this as LedgerImportDraft;
  return Object.hash(runtimeType,_this.fileName,_this.sizeBytes,const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.transactions));
}

@override
String toString() {
  final _this = this as LedgerImportDraft;
  return 'LedgerImportDraft(fileName: ${_this.fileName}, sizeBytes: ${_this.sizeBytes}, accounts: ${_this.accounts}, transactions: ${_this.transactions})';
}


}

/// @nodoc
abstract mixin class $LedgerImportDraftCopyWith<$Res>  {
  factory $LedgerImportDraftCopyWith(LedgerImportDraft value, $Res Function(LedgerImportDraft) _then) = _$LedgerImportDraftCopyWithImpl;
@useResult
$Res call({
 String fileName, int sizeBytes, List<Account> accounts, List<LedgerTransaction> transactions
});




}
/// @nodoc
class _$LedgerImportDraftCopyWithImpl<$Res>
    implements $LedgerImportDraftCopyWith<$Res> {
  _$LedgerImportDraftCopyWithImpl(this._self, this._then);

  final LedgerImportDraft _self;
  final $Res Function(LedgerImportDraft) _then;

/// Create a copy of LedgerImportDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileName = null,Object? sizeBytes = null,Object? accounts = null,Object? transactions = null,}) {
  return _then(LedgerImportDraft(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<LedgerTransaction>,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerImportDraft].
extension LedgerImportDraftPatterns on LedgerImportDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerImportDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerImportDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerImportDraft value)  $default,){
final _that = this;
switch (_that) {
case _LedgerImportDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerImportDraft value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerImportDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileName,  int sizeBytes,  List<Account> accounts,  List<LedgerTransaction> transactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerImportDraft() when $default != null:
return $default(_that.fileName,_that.sizeBytes,_that.accounts,_that.transactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileName,  int sizeBytes,  List<Account> accounts,  List<LedgerTransaction> transactions)  $default,) {final _that = this;
switch (_that) {
case _LedgerImportDraft():
return $default(_that.fileName,_that.sizeBytes,_that.accounts,_that.transactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileName,  int sizeBytes,  List<Account> accounts,  List<LedgerTransaction> transactions)?  $default,) {final _that = this;
switch (_that) {
case _LedgerImportDraft() when $default != null:
return $default(_that.fileName,_that.sizeBytes,_that.accounts,_that.transactions);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerImportDraft extends LedgerImportDraft {
  const _LedgerImportDraft({required this.fileName, required this.sizeBytes, required  List<Account> accounts, required  List<LedgerTransaction> transactions}): _accounts = accounts,_transactions = transactions,super._();
  

@override final  String fileName;
@override final  int sizeBytes;
 final  List<Account> _accounts;
@override List<Account> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  List<LedgerTransaction> _transactions;
@override List<LedgerTransaction> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of LedgerImportDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerImportDraftCopyWith<_LedgerImportDraft> get copyWith => __$LedgerImportDraftCopyWithImpl<_LedgerImportDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerImportDraft&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.transactions, _transactions));
}


@override
int get hashCode {
    return Object.hash(runtimeType,fileName,sizeBytes,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_transactions));
}

@override
String toString() {
    return 'LedgerImportDraft(fileName: $fileName, sizeBytes: $sizeBytes, accounts: $accounts, transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$LedgerImportDraftCopyWith<$Res> implements $LedgerImportDraftCopyWith<$Res> {
  factory _$LedgerImportDraftCopyWith(_LedgerImportDraft value, $Res Function(_LedgerImportDraft) _then) = __$LedgerImportDraftCopyWithImpl;
@override @useResult
$Res call({
 String fileName, int sizeBytes, List<Account> accounts, List<LedgerTransaction> transactions
});




}
/// @nodoc
class __$LedgerImportDraftCopyWithImpl<$Res>
    implements _$LedgerImportDraftCopyWith<$Res> {
  __$LedgerImportDraftCopyWithImpl(this._self, this._then);

  final _LedgerImportDraft _self;
  final $Res Function(_LedgerImportDraft) _then;

/// Create a copy of LedgerImportDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileName = null,Object? sizeBytes = null,Object? accounts = null,Object? transactions = null,}) {
  return _then(_LedgerImportDraft(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<LedgerTransaction>,
  ));
}


}

// dart format on

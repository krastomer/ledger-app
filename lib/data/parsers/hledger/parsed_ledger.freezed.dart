// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_ledger.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParsedLedger {

 List<Account> get accounts; List<LedgerTransaction> get transactions; List<LedgerIssue> get issues;
/// Create a copy of ParsedLedger
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsedLedgerCopyWith<ParsedLedger> get copyWith => _$ParsedLedgerCopyWithImpl<ParsedLedger>(this as ParsedLedger, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ParsedLedger;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsedLedger&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&const DeepCollectionEquality().equals(other.transactions, _this.transactions)&&const DeepCollectionEquality().equals(other.issues, _this.issues));
}


@override
int get hashCode {
  final _this = this as ParsedLedger;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.accounts),const DeepCollectionEquality().hash(_this.transactions),const DeepCollectionEquality().hash(_this.issues));
}

@override
String toString() {
  final _this = this as ParsedLedger;
  return 'ParsedLedger(accounts: ${_this.accounts}, transactions: ${_this.transactions}, issues: ${_this.issues})';
}


}

/// @nodoc
abstract mixin class $ParsedLedgerCopyWith<$Res>  {
  factory $ParsedLedgerCopyWith(ParsedLedger value, $Res Function(ParsedLedger) _then) = _$ParsedLedgerCopyWithImpl;
@useResult
$Res call({
 List<Account> accounts, List<LedgerTransaction> transactions, List<LedgerIssue> issues
});




}
/// @nodoc
class _$ParsedLedgerCopyWithImpl<$Res>
    implements $ParsedLedgerCopyWith<$Res> {
  _$ParsedLedgerCopyWithImpl(this._self, this._then);

  final ParsedLedger _self;
  final $Res Function(ParsedLedger) _then;

/// Create a copy of ParsedLedger
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accounts = null,Object? transactions = null,Object? issues = null,}) {
  return _then(ParsedLedger(
accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<LedgerTransaction>,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<LedgerIssue>,
  ));
}

}


/// Adds pattern-matching-related methods to [ParsedLedger].
extension ParsedLedgerPatterns on ParsedLedger {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParsedLedger value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParsedLedger() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParsedLedger value)  $default,){
final _that = this;
switch (_that) {
case _ParsedLedger():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParsedLedger value)?  $default,){
final _that = this;
switch (_that) {
case _ParsedLedger() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Account> accounts,  List<LedgerTransaction> transactions,  List<LedgerIssue> issues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParsedLedger() when $default != null:
return $default(_that.accounts,_that.transactions,_that.issues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Account> accounts,  List<LedgerTransaction> transactions,  List<LedgerIssue> issues)  $default,) {final _that = this;
switch (_that) {
case _ParsedLedger():
return $default(_that.accounts,_that.transactions,_that.issues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Account> accounts,  List<LedgerTransaction> transactions,  List<LedgerIssue> issues)?  $default,) {final _that = this;
switch (_that) {
case _ParsedLedger() when $default != null:
return $default(_that.accounts,_that.transactions,_that.issues);case _:
  return null;

}
}

}

/// @nodoc


class _ParsedLedger implements ParsedLedger {
  const _ParsedLedger({required  List<Account> accounts, required  List<LedgerTransaction> transactions, required  List<LedgerIssue> issues}): _accounts = accounts,_transactions = transactions,_issues = issues;
  

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

 final  List<LedgerIssue> _issues;
@override List<LedgerIssue> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}


/// Create a copy of ParsedLedger
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParsedLedgerCopyWith<_ParsedLedger> get copyWith => __$ParsedLedgerCopyWithImpl<_ParsedLedger>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParsedLedger&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&const DeepCollectionEquality().equals(other.transactions, _transactions)&&const DeepCollectionEquality().equals(other.issues, _issues));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_issues));
}

@override
String toString() {
    return 'ParsedLedger(accounts: $accounts, transactions: $transactions, issues: $issues)';
}


}

/// @nodoc
abstract mixin class _$ParsedLedgerCopyWith<$Res> implements $ParsedLedgerCopyWith<$Res> {
  factory _$ParsedLedgerCopyWith(_ParsedLedger value, $Res Function(_ParsedLedger) _then) = __$ParsedLedgerCopyWithImpl;
@override @useResult
$Res call({
 List<Account> accounts, List<LedgerTransaction> transactions, List<LedgerIssue> issues
});




}
/// @nodoc
class __$ParsedLedgerCopyWithImpl<$Res>
    implements _$ParsedLedgerCopyWith<$Res> {
  __$ParsedLedgerCopyWithImpl(this._self, this._then);

  final _ParsedLedger _self;
  final $Res Function(_ParsedLedger) _then;

/// Create a copy of ParsedLedger
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accounts = null,Object? transactions = null,Object? issues = null,}) {
  return _then(_ParsedLedger(
accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<LedgerTransaction>,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<LedgerIssue>,
  ));
}


}

/// @nodoc
mixin _$LedgerIssue {

/// Position in the exported array; null when the whole export is bad.
 int? get entry; LedgerIssueKind get kind;
/// Create a copy of LedgerIssue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerIssueCopyWith<LedgerIssue> get copyWith => _$LedgerIssueCopyWithImpl<LedgerIssue>(this as LedgerIssue, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LedgerIssue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerIssue&&(identical(other.entry, _this.entry) || other.entry == _this.entry)&&(identical(other.kind, _this.kind) || other.kind == _this.kind));
}


@override
int get hashCode {
  final _this = this as LedgerIssue;
  return Object.hash(runtimeType,_this.entry,_this.kind);
}

@override
String toString() {
  final _this = this as LedgerIssue;
  return 'LedgerIssue(entry: ${_this.entry}, kind: ${_this.kind})';
}


}

/// @nodoc
abstract mixin class $LedgerIssueCopyWith<$Res>  {
  factory $LedgerIssueCopyWith(LedgerIssue value, $Res Function(LedgerIssue) _then) = _$LedgerIssueCopyWithImpl;
@useResult
$Res call({
 int? entry, LedgerIssueKind kind
});




}
/// @nodoc
class _$LedgerIssueCopyWithImpl<$Res>
    implements $LedgerIssueCopyWith<$Res> {
  _$LedgerIssueCopyWithImpl(this._self, this._then);

  final LedgerIssue _self;
  final $Res Function(LedgerIssue) _then;

/// Create a copy of LedgerIssue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entry = freezed,Object? kind = null,}) {
  return _then(LedgerIssue(
entry: freezed == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as int?,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LedgerIssueKind,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerIssue].
extension LedgerIssuePatterns on LedgerIssue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerIssue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerIssue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerIssue value)  $default,){
final _that = this;
switch (_that) {
case _LedgerIssue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerIssue value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerIssue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? entry,  LedgerIssueKind kind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerIssue() when $default != null:
return $default(_that.entry,_that.kind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? entry,  LedgerIssueKind kind)  $default,) {final _that = this;
switch (_that) {
case _LedgerIssue():
return $default(_that.entry,_that.kind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? entry,  LedgerIssueKind kind)?  $default,) {final _that = this;
switch (_that) {
case _LedgerIssue() when $default != null:
return $default(_that.entry,_that.kind);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerIssue implements LedgerIssue {
  const _LedgerIssue({this.entry, required this.kind});
  

/// Position in the exported array; null when the whole export is bad.
@override final  int? entry;
@override final  LedgerIssueKind kind;

/// Create a copy of LedgerIssue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerIssueCopyWith<_LedgerIssue> get copyWith => __$LedgerIssueCopyWithImpl<_LedgerIssue>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerIssue&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.kind, kind) || other.kind == kind));
}


@override
int get hashCode {
    return Object.hash(runtimeType,entry,kind);
}

@override
String toString() {
    return 'LedgerIssue(entry: $entry, kind: $kind)';
}


}

/// @nodoc
abstract mixin class _$LedgerIssueCopyWith<$Res> implements $LedgerIssueCopyWith<$Res> {
  factory _$LedgerIssueCopyWith(_LedgerIssue value, $Res Function(_LedgerIssue) _then) = __$LedgerIssueCopyWithImpl;
@override @useResult
$Res call({
 int? entry, LedgerIssueKind kind
});




}
/// @nodoc
class __$LedgerIssueCopyWithImpl<$Res>
    implements _$LedgerIssueCopyWith<$Res> {
  __$LedgerIssueCopyWithImpl(this._self, this._then);

  final _LedgerIssue _self;
  final $Res Function(_LedgerIssue) _then;

/// Create a copy of LedgerIssue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entry = freezed,Object? kind = null,}) {
  return _then(_LedgerIssue(
entry: freezed == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as int?,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LedgerIssueKind,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionDetail {

 LedgerTransaction get transaction; TransactionSummary get summary;
/// Create a copy of TransactionDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionDetailCopyWith<TransactionDetail> get copyWith => _$TransactionDetailCopyWithImpl<TransactionDetail>(this as TransactionDetail, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransactionDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionDetail&&(identical(other.transaction, _this.transaction) || other.transaction == _this.transaction)&&(identical(other.summary, _this.summary) || other.summary == _this.summary));
}


@override
int get hashCode {
  final _this = this as TransactionDetail;
  return Object.hash(runtimeType,_this.transaction,_this.summary);
}

@override
String toString() {
  final _this = this as TransactionDetail;
  return 'TransactionDetail(transaction: ${_this.transaction}, summary: ${_this.summary})';
}


}

/// @nodoc
abstract mixin class $TransactionDetailCopyWith<$Res>  {
  factory $TransactionDetailCopyWith(TransactionDetail value, $Res Function(TransactionDetail) _then) = _$TransactionDetailCopyWithImpl;
@useResult
$Res call({
 LedgerTransaction transaction, TransactionSummary summary
});


$LedgerTransactionCopyWith<$Res> get transaction;$TransactionSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$TransactionDetailCopyWithImpl<$Res>
    implements $TransactionDetailCopyWith<$Res> {
  _$TransactionDetailCopyWithImpl(this._self, this._then);

  final TransactionDetail _self;
  final $Res Function(TransactionDetail) _then;

/// Create a copy of TransactionDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transaction = null,Object? summary = null,}) {
  return _then(TransactionDetail(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as LedgerTransaction,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TransactionSummary,
  ));
}
/// Create a copy of TransactionDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerTransactionCopyWith<$Res> get transaction {
  
  return $LedgerTransactionCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}/// Create a copy of TransactionDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionSummaryCopyWith<$Res> get summary {
  
  return $TransactionSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransactionDetail].
extension TransactionDetailPatterns on TransactionDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionDetail value)  $default,){
final _that = this;
switch (_that) {
case _TransactionDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionDetail value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LedgerTransaction transaction,  TransactionSummary summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionDetail() when $default != null:
return $default(_that.transaction,_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LedgerTransaction transaction,  TransactionSummary summary)  $default,) {final _that = this;
switch (_that) {
case _TransactionDetail():
return $default(_that.transaction,_that.summary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LedgerTransaction transaction,  TransactionSummary summary)?  $default,) {final _that = this;
switch (_that) {
case _TransactionDetail() when $default != null:
return $default(_that.transaction,_that.summary);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionDetail implements TransactionDetail {
  const _TransactionDetail({required this.transaction, required this.summary});
  

@override final  LedgerTransaction transaction;
@override final  TransactionSummary summary;

/// Create a copy of TransactionDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionDetailCopyWith<_TransactionDetail> get copyWith => __$TransactionDetailCopyWithImpl<_TransactionDetail>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionDetail&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode {
    return Object.hash(runtimeType,transaction,summary);
}

@override
String toString() {
    return 'TransactionDetail(transaction: $transaction, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$TransactionDetailCopyWith<$Res> implements $TransactionDetailCopyWith<$Res> {
  factory _$TransactionDetailCopyWith(_TransactionDetail value, $Res Function(_TransactionDetail) _then) = __$TransactionDetailCopyWithImpl;
@override @useResult
$Res call({
 LedgerTransaction transaction, TransactionSummary summary
});


@override $LedgerTransactionCopyWith<$Res> get transaction;@override $TransactionSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$TransactionDetailCopyWithImpl<$Res>
    implements _$TransactionDetailCopyWith<$Res> {
  __$TransactionDetailCopyWithImpl(this._self, this._then);

  final _TransactionDetail _self;
  final $Res Function(_TransactionDetail) _then;

/// Create a copy of TransactionDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transaction = null,Object? summary = null,}) {
  return _then(_TransactionDetail(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as LedgerTransaction,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TransactionSummary,
  ));
}

/// Create a copy of TransactionDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerTransactionCopyWith<$Res> get transaction {
  
  return $LedgerTransactionCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}/// Create a copy of TransactionDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionSummaryCopyWith<$Res> get summary {
  
  return $TransactionSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on

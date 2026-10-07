// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_check.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LedgerCheck {

 int get transactionCount; DateTime? get firstMonth; DateTime? get lastMonth; int get unbalancedCount; int get reviewCount;
/// Create a copy of LedgerCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerCheckCopyWith<LedgerCheck> get copyWith => _$LedgerCheckCopyWithImpl<LedgerCheck>(this as LedgerCheck, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LedgerCheck;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerCheck&&(identical(other.transactionCount, _this.transactionCount) || other.transactionCount == _this.transactionCount)&&(identical(other.firstMonth, _this.firstMonth) || other.firstMonth == _this.firstMonth)&&(identical(other.lastMonth, _this.lastMonth) || other.lastMonth == _this.lastMonth)&&(identical(other.unbalancedCount, _this.unbalancedCount) || other.unbalancedCount == _this.unbalancedCount)&&(identical(other.reviewCount, _this.reviewCount) || other.reviewCount == _this.reviewCount));
}


@override
int get hashCode {
  final _this = this as LedgerCheck;
  return Object.hash(runtimeType,_this.transactionCount,_this.firstMonth,_this.lastMonth,_this.unbalancedCount,_this.reviewCount);
}

@override
String toString() {
  final _this = this as LedgerCheck;
  return 'LedgerCheck(transactionCount: ${_this.transactionCount}, firstMonth: ${_this.firstMonth}, lastMonth: ${_this.lastMonth}, unbalancedCount: ${_this.unbalancedCount}, reviewCount: ${_this.reviewCount})';
}


}

/// @nodoc
abstract mixin class $LedgerCheckCopyWith<$Res>  {
  factory $LedgerCheckCopyWith(LedgerCheck value, $Res Function(LedgerCheck) _then) = _$LedgerCheckCopyWithImpl;
@useResult
$Res call({
 int transactionCount, DateTime? firstMonth, DateTime? lastMonth, int unbalancedCount, int reviewCount
});




}
/// @nodoc
class _$LedgerCheckCopyWithImpl<$Res>
    implements $LedgerCheckCopyWith<$Res> {
  _$LedgerCheckCopyWithImpl(this._self, this._then);

  final LedgerCheck _self;
  final $Res Function(LedgerCheck) _then;

/// Create a copy of LedgerCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionCount = null,Object? firstMonth = freezed,Object? lastMonth = freezed,Object? unbalancedCount = null,Object? reviewCount = null,}) {
  return _then(LedgerCheck(
transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,firstMonth: freezed == firstMonth ? _self.firstMonth : firstMonth // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMonth: freezed == lastMonth ? _self.lastMonth : lastMonth // ignore: cast_nullable_to_non_nullable
as DateTime?,unbalancedCount: null == unbalancedCount ? _self.unbalancedCount : unbalancedCount // ignore: cast_nullable_to_non_nullable
as int,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerCheck].
extension LedgerCheckPatterns on LedgerCheck {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerCheck() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerCheck value)  $default,){
final _that = this;
switch (_that) {
case _LedgerCheck():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerCheck value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerCheck() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int transactionCount,  DateTime? firstMonth,  DateTime? lastMonth,  int unbalancedCount,  int reviewCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerCheck() when $default != null:
return $default(_that.transactionCount,_that.firstMonth,_that.lastMonth,_that.unbalancedCount,_that.reviewCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int transactionCount,  DateTime? firstMonth,  DateTime? lastMonth,  int unbalancedCount,  int reviewCount)  $default,) {final _that = this;
switch (_that) {
case _LedgerCheck():
return $default(_that.transactionCount,_that.firstMonth,_that.lastMonth,_that.unbalancedCount,_that.reviewCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int transactionCount,  DateTime? firstMonth,  DateTime? lastMonth,  int unbalancedCount,  int reviewCount)?  $default,) {final _that = this;
switch (_that) {
case _LedgerCheck() when $default != null:
return $default(_that.transactionCount,_that.firstMonth,_that.lastMonth,_that.unbalancedCount,_that.reviewCount);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerCheck implements LedgerCheck {
  const _LedgerCheck({required this.transactionCount, this.firstMonth, this.lastMonth, required this.unbalancedCount, required this.reviewCount});
  

@override final  int transactionCount;
@override final  DateTime? firstMonth;
@override final  DateTime? lastMonth;
@override final  int unbalancedCount;
@override final  int reviewCount;

/// Create a copy of LedgerCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerCheckCopyWith<_LedgerCheck> get copyWith => __$LedgerCheckCopyWithImpl<_LedgerCheck>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerCheck&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.firstMonth, firstMonth) || other.firstMonth == firstMonth)&&(identical(other.lastMonth, lastMonth) || other.lastMonth == lastMonth)&&(identical(other.unbalancedCount, unbalancedCount) || other.unbalancedCount == unbalancedCount)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,transactionCount,firstMonth,lastMonth,unbalancedCount,reviewCount);
}

@override
String toString() {
    return 'LedgerCheck(transactionCount: $transactionCount, firstMonth: $firstMonth, lastMonth: $lastMonth, unbalancedCount: $unbalancedCount, reviewCount: $reviewCount)';
}


}

/// @nodoc
abstract mixin class _$LedgerCheckCopyWith<$Res> implements $LedgerCheckCopyWith<$Res> {
  factory _$LedgerCheckCopyWith(_LedgerCheck value, $Res Function(_LedgerCheck) _then) = __$LedgerCheckCopyWithImpl;
@override @useResult
$Res call({
 int transactionCount, DateTime? firstMonth, DateTime? lastMonth, int unbalancedCount, int reviewCount
});




}
/// @nodoc
class __$LedgerCheckCopyWithImpl<$Res>
    implements _$LedgerCheckCopyWith<$Res> {
  __$LedgerCheckCopyWithImpl(this._self, this._then);

  final _LedgerCheck _self;
  final $Res Function(_LedgerCheck) _then;

/// Create a copy of LedgerCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionCount = null,Object? firstMonth = freezed,Object? lastMonth = freezed,Object? unbalancedCount = null,Object? reviewCount = null,}) {
  return _then(_LedgerCheck(
transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,firstMonth: freezed == firstMonth ? _self.firstMonth : firstMonth // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMonth: freezed == lastMonth ? _self.lastMonth : lastMonth // ignore: cast_nullable_to_non_nullable
as DateTime?,unbalancedCount: null == unbalancedCount ? _self.unbalancedCount : unbalancedCount // ignore: cast_nullable_to_non_nullable
as int,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

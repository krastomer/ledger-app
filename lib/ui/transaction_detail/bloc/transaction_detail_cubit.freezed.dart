// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionDetailState {

 TransactionDetailStatus get status; TransactionDetail? get detail; TransactionDetailError? get error;
/// Create a copy of TransactionDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionDetailStateCopyWith<TransactionDetailState> get copyWith => _$TransactionDetailStateCopyWithImpl<TransactionDetailState>(this as TransactionDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransactionDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionDetailState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.detail, _this.detail) || other.detail == _this.detail)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as TransactionDetailState;
  return Object.hash(runtimeType,_this.status,_this.detail,_this.error);
}

@override
String toString() {
  final _this = this as TransactionDetailState;
  return 'TransactionDetailState(status: ${_this.status}, detail: ${_this.detail}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $TransactionDetailStateCopyWith<$Res>  {
  factory $TransactionDetailStateCopyWith(TransactionDetailState value, $Res Function(TransactionDetailState) _then) = _$TransactionDetailStateCopyWithImpl;
@useResult
$Res call({
 TransactionDetailStatus status, TransactionDetail? detail, TransactionDetailError? error
});


$TransactionDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class _$TransactionDetailStateCopyWithImpl<$Res>
    implements $TransactionDetailStateCopyWith<$Res> {
  _$TransactionDetailStateCopyWithImpl(this._self, this._then);

  final TransactionDetailState _self;
  final $Res Function(TransactionDetailState) _then;

/// Create a copy of TransactionDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? detail = freezed,Object? error = freezed,}) {
  return _then(TransactionDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionDetailStatus,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as TransactionDetail?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as TransactionDetailError?,
  ));
}
/// Create a copy of TransactionDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionDetailCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $TransactionDetailCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransactionDetailState].
extension TransactionDetailStatePatterns on TransactionDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionDetailState value)  $default,){
final _that = this;
switch (_that) {
case _TransactionDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransactionDetailStatus status,  TransactionDetail? detail,  TransactionDetailError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionDetailState() when $default != null:
return $default(_that.status,_that.detail,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransactionDetailStatus status,  TransactionDetail? detail,  TransactionDetailError? error)  $default,) {final _that = this;
switch (_that) {
case _TransactionDetailState():
return $default(_that.status,_that.detail,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransactionDetailStatus status,  TransactionDetail? detail,  TransactionDetailError? error)?  $default,) {final _that = this;
switch (_that) {
case _TransactionDetailState() when $default != null:
return $default(_that.status,_that.detail,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionDetailState implements TransactionDetailState {
  const _TransactionDetailState({this.status = TransactionDetailStatus.loading, this.detail, this.error});
  

@override@JsonKey() final  TransactionDetailStatus status;
@override final  TransactionDetail? detail;
@override final  TransactionDetailError? error;

/// Create a copy of TransactionDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionDetailStateCopyWith<_TransactionDetailState> get copyWith => __$TransactionDetailStateCopyWithImpl<_TransactionDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,detail,error);
}

@override
String toString() {
    return 'TransactionDetailState(status: $status, detail: $detail, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TransactionDetailStateCopyWith<$Res> implements $TransactionDetailStateCopyWith<$Res> {
  factory _$TransactionDetailStateCopyWith(_TransactionDetailState value, $Res Function(_TransactionDetailState) _then) = __$TransactionDetailStateCopyWithImpl;
@override @useResult
$Res call({
 TransactionDetailStatus status, TransactionDetail? detail, TransactionDetailError? error
});


@override $TransactionDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class __$TransactionDetailStateCopyWithImpl<$Res>
    implements _$TransactionDetailStateCopyWith<$Res> {
  __$TransactionDetailStateCopyWithImpl(this._self, this._then);

  final _TransactionDetailState _self;
  final $Res Function(_TransactionDetailState) _then;

/// Create a copy of TransactionDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? detail = freezed,Object? error = freezed,}) {
  return _then(_TransactionDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionDetailStatus,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as TransactionDetail?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as TransactionDetailError?,
  ));
}

/// Create a copy of TransactionDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionDetailCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $TransactionDetailCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}

// dart format on

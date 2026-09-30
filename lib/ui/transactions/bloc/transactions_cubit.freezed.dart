// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionsState {

 TransactionsStatus get status; MonthTransactions? get data; TransactionFilter get filter; TransactionsError? get error;
/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionsStateCopyWith<TransactionsState> get copyWith => _$TransactionsStateCopyWithImpl<TransactionsState>(this as TransactionsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransactionsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionsState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.data, _this.data) || other.data == _this.data)&&(identical(other.filter, _this.filter) || other.filter == _this.filter)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as TransactionsState;
  return Object.hash(runtimeType,_this.status,_this.data,_this.filter,_this.error);
}

@override
String toString() {
  final _this = this as TransactionsState;
  return 'TransactionsState(status: ${_this.status}, data: ${_this.data}, filter: ${_this.filter}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $TransactionsStateCopyWith<$Res>  {
  factory $TransactionsStateCopyWith(TransactionsState value, $Res Function(TransactionsState) _then) = _$TransactionsStateCopyWithImpl;
@useResult
$Res call({
 TransactionsStatus status, MonthTransactions? data, TransactionFilter filter, TransactionsError? error
});


$MonthTransactionsCopyWith<$Res>? get data;$TransactionFilterCopyWith<$Res> get filter;

}
/// @nodoc
class _$TransactionsStateCopyWithImpl<$Res>
    implements $TransactionsStateCopyWith<$Res> {
  _$TransactionsStateCopyWithImpl(this._self, this._then);

  final TransactionsState _self;
  final $Res Function(TransactionsState) _then;

/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? data = freezed,Object? filter = null,Object? error = freezed,}) {
  return _then(TransactionsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionsStatus,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MonthTransactions?,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TransactionFilter,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as TransactionsError?,
  ));
}
/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthTransactionsCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $MonthTransactionsCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionFilterCopyWith<$Res> get filter {
  
  return $TransactionFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransactionsState].
extension TransactionsStatePatterns on TransactionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionsState value)  $default,){
final _that = this;
switch (_that) {
case _TransactionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionsState value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransactionsStatus status,  MonthTransactions? data,  TransactionFilter filter,  TransactionsError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
return $default(_that.status,_that.data,_that.filter,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransactionsStatus status,  MonthTransactions? data,  TransactionFilter filter,  TransactionsError? error)  $default,) {final _that = this;
switch (_that) {
case _TransactionsState():
return $default(_that.status,_that.data,_that.filter,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransactionsStatus status,  MonthTransactions? data,  TransactionFilter filter,  TransactionsError? error)?  $default,) {final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
return $default(_that.status,_that.data,_that.filter,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionsState implements TransactionsState {
  const _TransactionsState({this.status = TransactionsStatus.initial, this.data, this.filter = const TransactionFilter(), this.error});
  

@override@JsonKey() final  TransactionsStatus status;
@override final  MonthTransactions? data;
@override@JsonKey() final  TransactionFilter filter;
@override final  TransactionsError? error;

/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionsStateCopyWith<_TransactionsState> get copyWith => __$TransactionsStateCopyWithImpl<_TransactionsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionsState&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,data,filter,error);
}

@override
String toString() {
    return 'TransactionsState(status: $status, data: $data, filter: $filter, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TransactionsStateCopyWith<$Res> implements $TransactionsStateCopyWith<$Res> {
  factory _$TransactionsStateCopyWith(_TransactionsState value, $Res Function(_TransactionsState) _then) = __$TransactionsStateCopyWithImpl;
@override @useResult
$Res call({
 TransactionsStatus status, MonthTransactions? data, TransactionFilter filter, TransactionsError? error
});


@override $MonthTransactionsCopyWith<$Res>? get data;@override $TransactionFilterCopyWith<$Res> get filter;

}
/// @nodoc
class __$TransactionsStateCopyWithImpl<$Res>
    implements _$TransactionsStateCopyWith<$Res> {
  __$TransactionsStateCopyWithImpl(this._self, this._then);

  final _TransactionsState _self;
  final $Res Function(_TransactionsState) _then;

/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? data = freezed,Object? filter = null,Object? error = freezed,}) {
  return _then(_TransactionsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionsStatus,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MonthTransactions?,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TransactionFilter,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as TransactionsError?,
  ));
}

/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthTransactionsCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $MonthTransactionsCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionFilterCopyWith<$Res> get filter {
  
  return $TransactionFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}

// dart format on

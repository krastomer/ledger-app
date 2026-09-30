// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionDay {

 DateTime get date; bool get isToday; List<TransactionSummary> get transactions;
/// Create a copy of TransactionDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionDayCopyWith<TransactionDay> get copyWith => _$TransactionDayCopyWithImpl<TransactionDay>(this as TransactionDay, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransactionDay;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionDay&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.isToday, _this.isToday) || other.isToday == _this.isToday)&&const DeepCollectionEquality().equals(other.transactions, _this.transactions));
}


@override
int get hashCode {
  final _this = this as TransactionDay;
  return Object.hash(runtimeType,_this.date,_this.isToday,const DeepCollectionEquality().hash(_this.transactions));
}

@override
String toString() {
  final _this = this as TransactionDay;
  return 'TransactionDay(date: ${_this.date}, isToday: ${_this.isToday}, transactions: ${_this.transactions})';
}


}

/// @nodoc
abstract mixin class $TransactionDayCopyWith<$Res>  {
  factory $TransactionDayCopyWith(TransactionDay value, $Res Function(TransactionDay) _then) = _$TransactionDayCopyWithImpl;
@useResult
$Res call({
 DateTime date, bool isToday, List<TransactionSummary> transactions
});




}
/// @nodoc
class _$TransactionDayCopyWithImpl<$Res>
    implements $TransactionDayCopyWith<$Res> {
  _$TransactionDayCopyWithImpl(this._self, this._then);

  final TransactionDay _self;
  final $Res Function(TransactionDay) _then;

/// Create a copy of TransactionDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? isToday = null,Object? transactions = null,}) {
  return _then(TransactionDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionSummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionDay].
extension TransactionDayPatterns on TransactionDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionDay value)  $default,){
final _that = this;
switch (_that) {
case _TransactionDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionDay value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  bool isToday,  List<TransactionSummary> transactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionDay() when $default != null:
return $default(_that.date,_that.isToday,_that.transactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  bool isToday,  List<TransactionSummary> transactions)  $default,) {final _that = this;
switch (_that) {
case _TransactionDay():
return $default(_that.date,_that.isToday,_that.transactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  bool isToday,  List<TransactionSummary> transactions)?  $default,) {final _that = this;
switch (_that) {
case _TransactionDay() when $default != null:
return $default(_that.date,_that.isToday,_that.transactions);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionDay implements TransactionDay {
  const _TransactionDay({required this.date, required this.isToday, required  List<TransactionSummary> transactions}): _transactions = transactions;
  

@override final  DateTime date;
@override final  bool isToday;
 final  List<TransactionSummary> _transactions;
@override List<TransactionSummary> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of TransactionDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionDayCopyWith<_TransactionDay> get copyWith => __$TransactionDayCopyWithImpl<_TransactionDay>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionDay&&(identical(other.date, date) || other.date == date)&&(identical(other.isToday, isToday) || other.isToday == isToday)&&const DeepCollectionEquality().equals(other.transactions, _transactions));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date,isToday,const DeepCollectionEquality().hash(_transactions));
}

@override
String toString() {
    return 'TransactionDay(date: $date, isToday: $isToday, transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$TransactionDayCopyWith<$Res> implements $TransactionDayCopyWith<$Res> {
  factory _$TransactionDayCopyWith(_TransactionDay value, $Res Function(_TransactionDay) _then) = __$TransactionDayCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, bool isToday, List<TransactionSummary> transactions
});




}
/// @nodoc
class __$TransactionDayCopyWithImpl<$Res>
    implements _$TransactionDayCopyWith<$Res> {
  __$TransactionDayCopyWithImpl(this._self, this._then);

  final _TransactionDay _self;
  final $Res Function(_TransactionDay) _then;

/// Create a copy of TransactionDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? isToday = null,Object? transactions = null,}) {
  return _then(_TransactionDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionSummary>,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'month_transactions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MonthTransactions {

 DateTime get month; DateTime get earliestMonth; DateTime get latestMonth;/// Totals cover the whole month, whatever filters [days] went through.
 Money get income; Money get expenses; Money get net; List<TransactionDay> get days;
/// Create a copy of MonthTransactions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthTransactionsCopyWith<MonthTransactions> get copyWith => _$MonthTransactionsCopyWithImpl<MonthTransactions>(this as MonthTransactions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MonthTransactions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthTransactions&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.earliestMonth, _this.earliestMonth) || other.earliestMonth == _this.earliestMonth)&&(identical(other.latestMonth, _this.latestMonth) || other.latestMonth == _this.latestMonth)&&(identical(other.income, _this.income) || other.income == _this.income)&&(identical(other.expenses, _this.expenses) || other.expenses == _this.expenses)&&(identical(other.net, _this.net) || other.net == _this.net)&&const DeepCollectionEquality().equals(other.days, _this.days));
}


@override
int get hashCode {
  final _this = this as MonthTransactions;
  return Object.hash(runtimeType,_this.month,_this.earliestMonth,_this.latestMonth,_this.income,_this.expenses,_this.net,const DeepCollectionEquality().hash(_this.days));
}

@override
String toString() {
  final _this = this as MonthTransactions;
  return 'MonthTransactions(month: ${_this.month}, earliestMonth: ${_this.earliestMonth}, latestMonth: ${_this.latestMonth}, income: ${_this.income}, expenses: ${_this.expenses}, net: ${_this.net}, days: ${_this.days})';
}


}

/// @nodoc
abstract mixin class $MonthTransactionsCopyWith<$Res>  {
  factory $MonthTransactionsCopyWith(MonthTransactions value, $Res Function(MonthTransactions) _then) = _$MonthTransactionsCopyWithImpl;
@useResult
$Res call({
 DateTime month, DateTime earliestMonth, DateTime latestMonth, Money income, Money expenses, Money net, List<TransactionDay> days
});




}
/// @nodoc
class _$MonthTransactionsCopyWithImpl<$Res>
    implements $MonthTransactionsCopyWith<$Res> {
  _$MonthTransactionsCopyWithImpl(this._self, this._then);

  final MonthTransactions _self;
  final $Res Function(MonthTransactions) _then;

/// Create a copy of MonthTransactions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? earliestMonth = null,Object? latestMonth = null,Object? income = null,Object? expenses = null,Object? net = null,Object? days = null,}) {
  return _then(MonthTransactions(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,earliestMonth: null == earliestMonth ? _self.earliestMonth : earliestMonth // ignore: cast_nullable_to_non_nullable
as DateTime,latestMonth: null == latestMonth ? _self.latestMonth : latestMonth // ignore: cast_nullable_to_non_nullable
as DateTime,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as Money,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<TransactionDay>,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthTransactions].
extension MonthTransactionsPatterns on MonthTransactions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthTransactions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthTransactions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthTransactions value)  $default,){
final _that = this;
switch (_that) {
case _MonthTransactions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthTransactions value)?  $default,){
final _that = this;
switch (_that) {
case _MonthTransactions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime month,  DateTime earliestMonth,  DateTime latestMonth,  Money income,  Money expenses,  Money net,  List<TransactionDay> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthTransactions() when $default != null:
return $default(_that.month,_that.earliestMonth,_that.latestMonth,_that.income,_that.expenses,_that.net,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime month,  DateTime earliestMonth,  DateTime latestMonth,  Money income,  Money expenses,  Money net,  List<TransactionDay> days)  $default,) {final _that = this;
switch (_that) {
case _MonthTransactions():
return $default(_that.month,_that.earliestMonth,_that.latestMonth,_that.income,_that.expenses,_that.net,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime month,  DateTime earliestMonth,  DateTime latestMonth,  Money income,  Money expenses,  Money net,  List<TransactionDay> days)?  $default,) {final _that = this;
switch (_that) {
case _MonthTransactions() when $default != null:
return $default(_that.month,_that.earliestMonth,_that.latestMonth,_that.income,_that.expenses,_that.net,_that.days);case _:
  return null;

}
}

}

/// @nodoc


class _MonthTransactions extends MonthTransactions {
  const _MonthTransactions({required this.month, required this.earliestMonth, required this.latestMonth, required this.income, required this.expenses, required this.net, required  List<TransactionDay> days}): _days = days,super._();
  

@override final  DateTime month;
@override final  DateTime earliestMonth;
@override final  DateTime latestMonth;
/// Totals cover the whole month, whatever filters [days] went through.
@override final  Money income;
@override final  Money expenses;
@override final  Money net;
 final  List<TransactionDay> _days;
@override List<TransactionDay> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of MonthTransactions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthTransactionsCopyWith<_MonthTransactions> get copyWith => __$MonthTransactionsCopyWithImpl<_MonthTransactions>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthTransactions&&(identical(other.month, month) || other.month == month)&&(identical(other.earliestMonth, earliestMonth) || other.earliestMonth == earliestMonth)&&(identical(other.latestMonth, latestMonth) || other.latestMonth == latestMonth)&&(identical(other.income, income) || other.income == income)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&(identical(other.net, net) || other.net == net)&&const DeepCollectionEquality().equals(other.days, _days));
}


@override
int get hashCode {
    return Object.hash(runtimeType,month,earliestMonth,latestMonth,income,expenses,net,const DeepCollectionEquality().hash(_days));
}

@override
String toString() {
    return 'MonthTransactions(month: $month, earliestMonth: $earliestMonth, latestMonth: $latestMonth, income: $income, expenses: $expenses, net: $net, days: $days)';
}


}

/// @nodoc
abstract mixin class _$MonthTransactionsCopyWith<$Res> implements $MonthTransactionsCopyWith<$Res> {
  factory _$MonthTransactionsCopyWith(_MonthTransactions value, $Res Function(_MonthTransactions) _then) = __$MonthTransactionsCopyWithImpl;
@override @useResult
$Res call({
 DateTime month, DateTime earliestMonth, DateTime latestMonth, Money income, Money expenses, Money net, List<TransactionDay> days
});




}
/// @nodoc
class __$MonthTransactionsCopyWithImpl<$Res>
    implements _$MonthTransactionsCopyWith<$Res> {
  __$MonthTransactionsCopyWithImpl(this._self, this._then);

  final _MonthTransactions _self;
  final $Res Function(_MonthTransactions) _then;

/// Create a copy of MonthTransactions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? earliestMonth = null,Object? latestMonth = null,Object? income = null,Object? expenses = null,Object? net = null,Object? days = null,}) {
  return _then(_MonthTransactions(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,earliestMonth: null == earliestMonth ? _self.earliestMonth : earliestMonth // ignore: cast_nullable_to_non_nullable
as DateTime,latestMonth: null == latestMonth ? _self.latestMonth : latestMonth // ignore: cast_nullable_to_non_nullable
as DateTime,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as Money,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<TransactionDay>,
  ));
}


}

// dart format on

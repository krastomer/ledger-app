// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_statement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IncomeStatement {

 DateTime get month; DateTime get earliestMonth; DateTime get latestMonth; Money get income; Money get expenses; Money get net;/// Net as a share of income in tenths of a percent; null unless the
/// month has income and a surplus.
 int? get savingsPerMille;/// Expenses as a share of income; null unless the month has income.
 int? get expensesPerMille; AccountNode get expenseTree; AccountNode get incomeTree; DailySpend get dailySpend;
/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeStatementCopyWith<IncomeStatement> get copyWith => _$IncomeStatementCopyWithImpl<IncomeStatement>(this as IncomeStatement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as IncomeStatement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeStatement&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.earliestMonth, _this.earliestMonth) || other.earliestMonth == _this.earliestMonth)&&(identical(other.latestMonth, _this.latestMonth) || other.latestMonth == _this.latestMonth)&&(identical(other.income, _this.income) || other.income == _this.income)&&(identical(other.expenses, _this.expenses) || other.expenses == _this.expenses)&&(identical(other.net, _this.net) || other.net == _this.net)&&(identical(other.savingsPerMille, _this.savingsPerMille) || other.savingsPerMille == _this.savingsPerMille)&&(identical(other.expensesPerMille, _this.expensesPerMille) || other.expensesPerMille == _this.expensesPerMille)&&(identical(other.expenseTree, _this.expenseTree) || other.expenseTree == _this.expenseTree)&&(identical(other.incomeTree, _this.incomeTree) || other.incomeTree == _this.incomeTree)&&(identical(other.dailySpend, _this.dailySpend) || other.dailySpend == _this.dailySpend));
}


@override
int get hashCode {
  final _this = this as IncomeStatement;
  return Object.hash(runtimeType,_this.month,_this.earliestMonth,_this.latestMonth,_this.income,_this.expenses,_this.net,_this.savingsPerMille,_this.expensesPerMille,_this.expenseTree,_this.incomeTree,_this.dailySpend);
}

@override
String toString() {
  final _this = this as IncomeStatement;
  return 'IncomeStatement(month: ${_this.month}, earliestMonth: ${_this.earliestMonth}, latestMonth: ${_this.latestMonth}, income: ${_this.income}, expenses: ${_this.expenses}, net: ${_this.net}, savingsPerMille: ${_this.savingsPerMille}, expensesPerMille: ${_this.expensesPerMille}, expenseTree: ${_this.expenseTree}, incomeTree: ${_this.incomeTree}, dailySpend: ${_this.dailySpend})';
}


}

/// @nodoc
abstract mixin class $IncomeStatementCopyWith<$Res>  {
  factory $IncomeStatementCopyWith(IncomeStatement value, $Res Function(IncomeStatement) _then) = _$IncomeStatementCopyWithImpl;
@useResult
$Res call({
 DateTime month, DateTime earliestMonth, DateTime latestMonth, Money income, Money expenses, Money net, int? savingsPerMille, int? expensesPerMille, AccountNode expenseTree, AccountNode incomeTree, DailySpend dailySpend
});


$AccountNodeCopyWith<$Res> get expenseTree;$AccountNodeCopyWith<$Res> get incomeTree;$DailySpendCopyWith<$Res> get dailySpend;

}
/// @nodoc
class _$IncomeStatementCopyWithImpl<$Res>
    implements $IncomeStatementCopyWith<$Res> {
  _$IncomeStatementCopyWithImpl(this._self, this._then);

  final IncomeStatement _self;
  final $Res Function(IncomeStatement) _then;

/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? earliestMonth = null,Object? latestMonth = null,Object? income = null,Object? expenses = null,Object? net = null,Object? savingsPerMille = freezed,Object? expensesPerMille = freezed,Object? expenseTree = null,Object? incomeTree = null,Object? dailySpend = null,}) {
  return _then(IncomeStatement(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,earliestMonth: null == earliestMonth ? _self.earliestMonth : earliestMonth // ignore: cast_nullable_to_non_nullable
as DateTime,latestMonth: null == latestMonth ? _self.latestMonth : latestMonth // ignore: cast_nullable_to_non_nullable
as DateTime,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as Money,savingsPerMille: freezed == savingsPerMille ? _self.savingsPerMille : savingsPerMille // ignore: cast_nullable_to_non_nullable
as int?,expensesPerMille: freezed == expensesPerMille ? _self.expensesPerMille : expensesPerMille // ignore: cast_nullable_to_non_nullable
as int?,expenseTree: null == expenseTree ? _self.expenseTree : expenseTree // ignore: cast_nullable_to_non_nullable
as AccountNode,incomeTree: null == incomeTree ? _self.incomeTree : incomeTree // ignore: cast_nullable_to_non_nullable
as AccountNode,dailySpend: null == dailySpend ? _self.dailySpend : dailySpend // ignore: cast_nullable_to_non_nullable
as DailySpend,
  ));
}
/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountNodeCopyWith<$Res> get expenseTree {
  
  return $AccountNodeCopyWith<$Res>(_self.expenseTree, (value) {
    return _then(_self.copyWith(expenseTree: value));
  });
}/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountNodeCopyWith<$Res> get incomeTree {
  
  return $AccountNodeCopyWith<$Res>(_self.incomeTree, (value) {
    return _then(_self.copyWith(incomeTree: value));
  });
}/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DailySpendCopyWith<$Res> get dailySpend {
  
  return $DailySpendCopyWith<$Res>(_self.dailySpend, (value) {
    return _then(_self.copyWith(dailySpend: value));
  });
}
}


/// Adds pattern-matching-related methods to [IncomeStatement].
extension IncomeStatementPatterns on IncomeStatement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeStatement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeStatement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeStatement value)  $default,){
final _that = this;
switch (_that) {
case _IncomeStatement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeStatement value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeStatement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime month,  DateTime earliestMonth,  DateTime latestMonth,  Money income,  Money expenses,  Money net,  int? savingsPerMille,  int? expensesPerMille,  AccountNode expenseTree,  AccountNode incomeTree,  DailySpend dailySpend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeStatement() when $default != null:
return $default(_that.month,_that.earliestMonth,_that.latestMonth,_that.income,_that.expenses,_that.net,_that.savingsPerMille,_that.expensesPerMille,_that.expenseTree,_that.incomeTree,_that.dailySpend);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime month,  DateTime earliestMonth,  DateTime latestMonth,  Money income,  Money expenses,  Money net,  int? savingsPerMille,  int? expensesPerMille,  AccountNode expenseTree,  AccountNode incomeTree,  DailySpend dailySpend)  $default,) {final _that = this;
switch (_that) {
case _IncomeStatement():
return $default(_that.month,_that.earliestMonth,_that.latestMonth,_that.income,_that.expenses,_that.net,_that.savingsPerMille,_that.expensesPerMille,_that.expenseTree,_that.incomeTree,_that.dailySpend);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime month,  DateTime earliestMonth,  DateTime latestMonth,  Money income,  Money expenses,  Money net,  int? savingsPerMille,  int? expensesPerMille,  AccountNode expenseTree,  AccountNode incomeTree,  DailySpend dailySpend)?  $default,) {final _that = this;
switch (_that) {
case _IncomeStatement() when $default != null:
return $default(_that.month,_that.earliestMonth,_that.latestMonth,_that.income,_that.expenses,_that.net,_that.savingsPerMille,_that.expensesPerMille,_that.expenseTree,_that.incomeTree,_that.dailySpend);case _:
  return null;

}
}

}

/// @nodoc


class _IncomeStatement extends IncomeStatement {
  const _IncomeStatement({required this.month, required this.earliestMonth, required this.latestMonth, required this.income, required this.expenses, required this.net, this.savingsPerMille, this.expensesPerMille, required this.expenseTree, required this.incomeTree, required this.dailySpend}): super._();
  

@override final  DateTime month;
@override final  DateTime earliestMonth;
@override final  DateTime latestMonth;
@override final  Money income;
@override final  Money expenses;
@override final  Money net;
/// Net as a share of income in tenths of a percent; null unless the
/// month has income and a surplus.
@override final  int? savingsPerMille;
/// Expenses as a share of income; null unless the month has income.
@override final  int? expensesPerMille;
@override final  AccountNode expenseTree;
@override final  AccountNode incomeTree;
@override final  DailySpend dailySpend;

/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeStatementCopyWith<_IncomeStatement> get copyWith => __$IncomeStatementCopyWithImpl<_IncomeStatement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeStatement&&(identical(other.month, month) || other.month == month)&&(identical(other.earliestMonth, earliestMonth) || other.earliestMonth == earliestMonth)&&(identical(other.latestMonth, latestMonth) || other.latestMonth == latestMonth)&&(identical(other.income, income) || other.income == income)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&(identical(other.net, net) || other.net == net)&&(identical(other.savingsPerMille, savingsPerMille) || other.savingsPerMille == savingsPerMille)&&(identical(other.expensesPerMille, expensesPerMille) || other.expensesPerMille == expensesPerMille)&&(identical(other.expenseTree, expenseTree) || other.expenseTree == expenseTree)&&(identical(other.incomeTree, incomeTree) || other.incomeTree == incomeTree)&&(identical(other.dailySpend, dailySpend) || other.dailySpend == dailySpend));
}


@override
int get hashCode {
    return Object.hash(runtimeType,month,earliestMonth,latestMonth,income,expenses,net,savingsPerMille,expensesPerMille,expenseTree,incomeTree,dailySpend);
}

@override
String toString() {
    return 'IncomeStatement(month: $month, earliestMonth: $earliestMonth, latestMonth: $latestMonth, income: $income, expenses: $expenses, net: $net, savingsPerMille: $savingsPerMille, expensesPerMille: $expensesPerMille, expenseTree: $expenseTree, incomeTree: $incomeTree, dailySpend: $dailySpend)';
}


}

/// @nodoc
abstract mixin class _$IncomeStatementCopyWith<$Res> implements $IncomeStatementCopyWith<$Res> {
  factory _$IncomeStatementCopyWith(_IncomeStatement value, $Res Function(_IncomeStatement) _then) = __$IncomeStatementCopyWithImpl;
@override @useResult
$Res call({
 DateTime month, DateTime earliestMonth, DateTime latestMonth, Money income, Money expenses, Money net, int? savingsPerMille, int? expensesPerMille, AccountNode expenseTree, AccountNode incomeTree, DailySpend dailySpend
});


@override $AccountNodeCopyWith<$Res> get expenseTree;@override $AccountNodeCopyWith<$Res> get incomeTree;@override $DailySpendCopyWith<$Res> get dailySpend;

}
/// @nodoc
class __$IncomeStatementCopyWithImpl<$Res>
    implements _$IncomeStatementCopyWith<$Res> {
  __$IncomeStatementCopyWithImpl(this._self, this._then);

  final _IncomeStatement _self;
  final $Res Function(_IncomeStatement) _then;

/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? earliestMonth = null,Object? latestMonth = null,Object? income = null,Object? expenses = null,Object? net = null,Object? savingsPerMille = freezed,Object? expensesPerMille = freezed,Object? expenseTree = null,Object? incomeTree = null,Object? dailySpend = null,}) {
  return _then(_IncomeStatement(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,earliestMonth: null == earliestMonth ? _self.earliestMonth : earliestMonth // ignore: cast_nullable_to_non_nullable
as DateTime,latestMonth: null == latestMonth ? _self.latestMonth : latestMonth // ignore: cast_nullable_to_non_nullable
as DateTime,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as Money,net: null == net ? _self.net : net // ignore: cast_nullable_to_non_nullable
as Money,savingsPerMille: freezed == savingsPerMille ? _self.savingsPerMille : savingsPerMille // ignore: cast_nullable_to_non_nullable
as int?,expensesPerMille: freezed == expensesPerMille ? _self.expensesPerMille : expensesPerMille // ignore: cast_nullable_to_non_nullable
as int?,expenseTree: null == expenseTree ? _self.expenseTree : expenseTree // ignore: cast_nullable_to_non_nullable
as AccountNode,incomeTree: null == incomeTree ? _self.incomeTree : incomeTree // ignore: cast_nullable_to_non_nullable
as AccountNode,dailySpend: null == dailySpend ? _self.dailySpend : dailySpend // ignore: cast_nullable_to_non_nullable
as DailySpend,
  ));
}

/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountNodeCopyWith<$Res> get expenseTree {
  
  return $AccountNodeCopyWith<$Res>(_self.expenseTree, (value) {
    return _then(_self.copyWith(expenseTree: value));
  });
}/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountNodeCopyWith<$Res> get incomeTree {
  
  return $AccountNodeCopyWith<$Res>(_self.incomeTree, (value) {
    return _then(_self.copyWith(incomeTree: value));
  });
}/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DailySpendCopyWith<$Res> get dailySpend {
  
  return $DailySpendCopyWith<$Res>(_self.dailySpend, (value) {
    return _then(_self.copyWith(dailySpend: value));
  });
}
}

// dart format on

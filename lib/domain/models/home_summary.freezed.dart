// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeSummary {

 DateTime get asOf; Money get netWorth; Money get assets; Money get liabilities; Money get monthIncome; Money get monthExpenses; Money get monthNet; List<CategoryTotal> get topSpending; List<TransactionSummary> get recent; int get pendingCount;
/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSummaryCopyWith<HomeSummary> get copyWith => _$HomeSummaryCopyWithImpl<HomeSummary>(this as HomeSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSummary&&(identical(other.asOf, _this.asOf) || other.asOf == _this.asOf)&&(identical(other.netWorth, _this.netWorth) || other.netWorth == _this.netWorth)&&(identical(other.assets, _this.assets) || other.assets == _this.assets)&&(identical(other.liabilities, _this.liabilities) || other.liabilities == _this.liabilities)&&(identical(other.monthIncome, _this.monthIncome) || other.monthIncome == _this.monthIncome)&&(identical(other.monthExpenses, _this.monthExpenses) || other.monthExpenses == _this.monthExpenses)&&(identical(other.monthNet, _this.monthNet) || other.monthNet == _this.monthNet)&&const DeepCollectionEquality().equals(other.topSpending, _this.topSpending)&&const DeepCollectionEquality().equals(other.recent, _this.recent)&&(identical(other.pendingCount, _this.pendingCount) || other.pendingCount == _this.pendingCount));
}


@override
int get hashCode {
  final _this = this as HomeSummary;
  return Object.hash(runtimeType,_this.asOf,_this.netWorth,_this.assets,_this.liabilities,_this.monthIncome,_this.monthExpenses,_this.monthNet,const DeepCollectionEquality().hash(_this.topSpending),const DeepCollectionEquality().hash(_this.recent),_this.pendingCount);
}

@override
String toString() {
  final _this = this as HomeSummary;
  return 'HomeSummary(asOf: ${_this.asOf}, netWorth: ${_this.netWorth}, assets: ${_this.assets}, liabilities: ${_this.liabilities}, monthIncome: ${_this.monthIncome}, monthExpenses: ${_this.monthExpenses}, monthNet: ${_this.monthNet}, topSpending: ${_this.topSpending}, recent: ${_this.recent}, pendingCount: ${_this.pendingCount})';
}


}

/// @nodoc
abstract mixin class $HomeSummaryCopyWith<$Res>  {
  factory $HomeSummaryCopyWith(HomeSummary value, $Res Function(HomeSummary) _then) = _$HomeSummaryCopyWithImpl;
@useResult
$Res call({
 DateTime asOf, Money netWorth, Money assets, Money liabilities, Money monthIncome, Money monthExpenses, Money monthNet, List<CategoryTotal> topSpending, List<TransactionSummary> recent, int pendingCount
});




}
/// @nodoc
class _$HomeSummaryCopyWithImpl<$Res>
    implements $HomeSummaryCopyWith<$Res> {
  _$HomeSummaryCopyWithImpl(this._self, this._then);

  final HomeSummary _self;
  final $Res Function(HomeSummary) _then;

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? asOf = null,Object? netWorth = null,Object? assets = null,Object? liabilities = null,Object? monthIncome = null,Object? monthExpenses = null,Object? monthNet = null,Object? topSpending = null,Object? recent = null,Object? pendingCount = null,}) {
  return _then(HomeSummary(
asOf: null == asOf ? _self.asOf : asOf // ignore: cast_nullable_to_non_nullable
as DateTime,netWorth: null == netWorth ? _self.netWorth : netWorth // ignore: cast_nullable_to_non_nullable
as Money,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as Money,liabilities: null == liabilities ? _self.liabilities : liabilities // ignore: cast_nullable_to_non_nullable
as Money,monthIncome: null == monthIncome ? _self.monthIncome : monthIncome // ignore: cast_nullable_to_non_nullable
as Money,monthExpenses: null == monthExpenses ? _self.monthExpenses : monthExpenses // ignore: cast_nullable_to_non_nullable
as Money,monthNet: null == monthNet ? _self.monthNet : monthNet // ignore: cast_nullable_to_non_nullable
as Money,topSpending: null == topSpending ? _self.topSpending : topSpending // ignore: cast_nullable_to_non_nullable
as List<CategoryTotal>,recent: null == recent ? _self.recent : recent // ignore: cast_nullable_to_non_nullable
as List<TransactionSummary>,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeSummary].
extension HomeSummaryPatterns on HomeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSummary value)  $default,){
final _that = this;
switch (_that) {
case _HomeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime asOf,  Money netWorth,  Money assets,  Money liabilities,  Money monthIncome,  Money monthExpenses,  Money monthNet,  List<CategoryTotal> topSpending,  List<TransactionSummary> recent,  int pendingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
return $default(_that.asOf,_that.netWorth,_that.assets,_that.liabilities,_that.monthIncome,_that.monthExpenses,_that.monthNet,_that.topSpending,_that.recent,_that.pendingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime asOf,  Money netWorth,  Money assets,  Money liabilities,  Money monthIncome,  Money monthExpenses,  Money monthNet,  List<CategoryTotal> topSpending,  List<TransactionSummary> recent,  int pendingCount)  $default,) {final _that = this;
switch (_that) {
case _HomeSummary():
return $default(_that.asOf,_that.netWorth,_that.assets,_that.liabilities,_that.monthIncome,_that.monthExpenses,_that.monthNet,_that.topSpending,_that.recent,_that.pendingCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime asOf,  Money netWorth,  Money assets,  Money liabilities,  Money monthIncome,  Money monthExpenses,  Money monthNet,  List<CategoryTotal> topSpending,  List<TransactionSummary> recent,  int pendingCount)?  $default,) {final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
return $default(_that.asOf,_that.netWorth,_that.assets,_that.liabilities,_that.monthIncome,_that.monthExpenses,_that.monthNet,_that.topSpending,_that.recent,_that.pendingCount);case _:
  return null;

}
}

}

/// @nodoc


class _HomeSummary implements HomeSummary {
  const _HomeSummary({required this.asOf, required this.netWorth, required this.assets, required this.liabilities, required this.monthIncome, required this.monthExpenses, required this.monthNet, required  List<CategoryTotal> topSpending, required  List<TransactionSummary> recent, required this.pendingCount}): _topSpending = topSpending,_recent = recent;
  

@override final  DateTime asOf;
@override final  Money netWorth;
@override final  Money assets;
@override final  Money liabilities;
@override final  Money monthIncome;
@override final  Money monthExpenses;
@override final  Money monthNet;
 final  List<CategoryTotal> _topSpending;
@override List<CategoryTotal> get topSpending {
  if (_topSpending is EqualUnmodifiableListView) return _topSpending;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topSpending);
}

 final  List<TransactionSummary> _recent;
@override List<TransactionSummary> get recent {
  if (_recent is EqualUnmodifiableListView) return _recent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recent);
}

@override final  int pendingCount;

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSummaryCopyWith<_HomeSummary> get copyWith => __$HomeSummaryCopyWithImpl<_HomeSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSummary&&(identical(other.asOf, asOf) || other.asOf == asOf)&&(identical(other.netWorth, netWorth) || other.netWorth == netWorth)&&(identical(other.assets, assets) || other.assets == assets)&&(identical(other.liabilities, liabilities) || other.liabilities == liabilities)&&(identical(other.monthIncome, monthIncome) || other.monthIncome == monthIncome)&&(identical(other.monthExpenses, monthExpenses) || other.monthExpenses == monthExpenses)&&(identical(other.monthNet, monthNet) || other.monthNet == monthNet)&&const DeepCollectionEquality().equals(other.topSpending, _topSpending)&&const DeepCollectionEquality().equals(other.recent, _recent)&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,asOf,netWorth,assets,liabilities,monthIncome,monthExpenses,monthNet,const DeepCollectionEquality().hash(_topSpending),const DeepCollectionEquality().hash(_recent),pendingCount);
}

@override
String toString() {
    return 'HomeSummary(asOf: $asOf, netWorth: $netWorth, assets: $assets, liabilities: $liabilities, monthIncome: $monthIncome, monthExpenses: $monthExpenses, monthNet: $monthNet, topSpending: $topSpending, recent: $recent, pendingCount: $pendingCount)';
}


}

/// @nodoc
abstract mixin class _$HomeSummaryCopyWith<$Res> implements $HomeSummaryCopyWith<$Res> {
  factory _$HomeSummaryCopyWith(_HomeSummary value, $Res Function(_HomeSummary) _then) = __$HomeSummaryCopyWithImpl;
@override @useResult
$Res call({
 DateTime asOf, Money netWorth, Money assets, Money liabilities, Money monthIncome, Money monthExpenses, Money monthNet, List<CategoryTotal> topSpending, List<TransactionSummary> recent, int pendingCount
});




}
/// @nodoc
class __$HomeSummaryCopyWithImpl<$Res>
    implements _$HomeSummaryCopyWith<$Res> {
  __$HomeSummaryCopyWithImpl(this._self, this._then);

  final _HomeSummary _self;
  final $Res Function(_HomeSummary) _then;

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? asOf = null,Object? netWorth = null,Object? assets = null,Object? liabilities = null,Object? monthIncome = null,Object? monthExpenses = null,Object? monthNet = null,Object? topSpending = null,Object? recent = null,Object? pendingCount = null,}) {
  return _then(_HomeSummary(
asOf: null == asOf ? _self.asOf : asOf // ignore: cast_nullable_to_non_nullable
as DateTime,netWorth: null == netWorth ? _self.netWorth : netWorth // ignore: cast_nullable_to_non_nullable
as Money,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as Money,liabilities: null == liabilities ? _self.liabilities : liabilities // ignore: cast_nullable_to_non_nullable
as Money,monthIncome: null == monthIncome ? _self.monthIncome : monthIncome // ignore: cast_nullable_to_non_nullable
as Money,monthExpenses: null == monthExpenses ? _self.monthExpenses : monthExpenses // ignore: cast_nullable_to_non_nullable
as Money,monthNet: null == monthNet ? _self.monthNet : monthNet // ignore: cast_nullable_to_non_nullable
as Money,topSpending: null == topSpending ? _self._topSpending : topSpending // ignore: cast_nullable_to_non_nullable
as List<CategoryTotal>,recent: null == recent ? _self._recent : recent // ignore: cast_nullable_to_non_nullable
as List<TransactionSummary>,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

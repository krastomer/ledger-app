// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_spend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailySpend {

 DateTime get month;/// Expenses booked on each day; index 0 is the 1st of [month].
 List<Money> get days;/// Days counted towards [average]: up to today in the current month,
/// the whole month otherwise.
 int get elapsedDays;/// Today's day of the month when [month] is the current month.
 int? get today; Money get average;/// The day with the most spending, if any day had some.
 int? get peakDay;/// Name of the category that took the largest part of [peakDay].
 String? get peakCategory;
/// Create a copy of DailySpend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailySpendCopyWith<DailySpend> get copyWith => _$DailySpendCopyWithImpl<DailySpend>(this as DailySpend, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DailySpend;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailySpend&&(identical(other.month, _this.month) || other.month == _this.month)&&const DeepCollectionEquality().equals(other.days, _this.days)&&(identical(other.elapsedDays, _this.elapsedDays) || other.elapsedDays == _this.elapsedDays)&&(identical(other.today, _this.today) || other.today == _this.today)&&(identical(other.average, _this.average) || other.average == _this.average)&&(identical(other.peakDay, _this.peakDay) || other.peakDay == _this.peakDay)&&(identical(other.peakCategory, _this.peakCategory) || other.peakCategory == _this.peakCategory));
}


@override
int get hashCode {
  final _this = this as DailySpend;
  return Object.hash(runtimeType,_this.month,const DeepCollectionEquality().hash(_this.days),_this.elapsedDays,_this.today,_this.average,_this.peakDay,_this.peakCategory);
}

@override
String toString() {
  final _this = this as DailySpend;
  return 'DailySpend(month: ${_this.month}, days: ${_this.days}, elapsedDays: ${_this.elapsedDays}, today: ${_this.today}, average: ${_this.average}, peakDay: ${_this.peakDay}, peakCategory: ${_this.peakCategory})';
}


}

/// @nodoc
abstract mixin class $DailySpendCopyWith<$Res>  {
  factory $DailySpendCopyWith(DailySpend value, $Res Function(DailySpend) _then) = _$DailySpendCopyWithImpl;
@useResult
$Res call({
 DateTime month, List<Money> days, int elapsedDays, int? today, Money average, int? peakDay, String? peakCategory
});




}
/// @nodoc
class _$DailySpendCopyWithImpl<$Res>
    implements $DailySpendCopyWith<$Res> {
  _$DailySpendCopyWithImpl(this._self, this._then);

  final DailySpend _self;
  final $Res Function(DailySpend) _then;

/// Create a copy of DailySpend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? days = null,Object? elapsedDays = null,Object? today = freezed,Object? average = null,Object? peakDay = freezed,Object? peakCategory = freezed,}) {
  return _then(DailySpend(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<Money>,elapsedDays: null == elapsedDays ? _self.elapsedDays : elapsedDays // ignore: cast_nullable_to_non_nullable
as int,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as int?,average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as Money,peakDay: freezed == peakDay ? _self.peakDay : peakDay // ignore: cast_nullable_to_non_nullable
as int?,peakCategory: freezed == peakCategory ? _self.peakCategory : peakCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DailySpend].
extension DailySpendPatterns on DailySpend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailySpend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailySpend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailySpend value)  $default,){
final _that = this;
switch (_that) {
case _DailySpend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailySpend value)?  $default,){
final _that = this;
switch (_that) {
case _DailySpend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime month,  List<Money> days,  int elapsedDays,  int? today,  Money average,  int? peakDay,  String? peakCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailySpend() when $default != null:
return $default(_that.month,_that.days,_that.elapsedDays,_that.today,_that.average,_that.peakDay,_that.peakCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime month,  List<Money> days,  int elapsedDays,  int? today,  Money average,  int? peakDay,  String? peakCategory)  $default,) {final _that = this;
switch (_that) {
case _DailySpend():
return $default(_that.month,_that.days,_that.elapsedDays,_that.today,_that.average,_that.peakDay,_that.peakCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime month,  List<Money> days,  int elapsedDays,  int? today,  Money average,  int? peakDay,  String? peakCategory)?  $default,) {final _that = this;
switch (_that) {
case _DailySpend() when $default != null:
return $default(_that.month,_that.days,_that.elapsedDays,_that.today,_that.average,_that.peakDay,_that.peakCategory);case _:
  return null;

}
}

}

/// @nodoc


class _DailySpend extends DailySpend {
  const _DailySpend({required this.month, required  List<Money> days, required this.elapsedDays, this.today, required this.average, this.peakDay, this.peakCategory}): _days = days,super._();
  

@override final  DateTime month;
/// Expenses booked on each day; index 0 is the 1st of [month].
 final  List<Money> _days;
/// Expenses booked on each day; index 0 is the 1st of [month].
@override List<Money> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

/// Days counted towards [average]: up to today in the current month,
/// the whole month otherwise.
@override final  int elapsedDays;
/// Today's day of the month when [month] is the current month.
@override final  int? today;
@override final  Money average;
/// The day with the most spending, if any day had some.
@override final  int? peakDay;
/// Name of the category that took the largest part of [peakDay].
@override final  String? peakCategory;

/// Create a copy of DailySpend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailySpendCopyWith<_DailySpend> get copyWith => __$DailySpendCopyWithImpl<_DailySpend>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailySpend&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.days, _days)&&(identical(other.elapsedDays, elapsedDays) || other.elapsedDays == elapsedDays)&&(identical(other.today, today) || other.today == today)&&(identical(other.average, average) || other.average == average)&&(identical(other.peakDay, peakDay) || other.peakDay == peakDay)&&(identical(other.peakCategory, peakCategory) || other.peakCategory == peakCategory));
}


@override
int get hashCode {
    return Object.hash(runtimeType,month,const DeepCollectionEquality().hash(_days),elapsedDays,today,average,peakDay,peakCategory);
}

@override
String toString() {
    return 'DailySpend(month: $month, days: $days, elapsedDays: $elapsedDays, today: $today, average: $average, peakDay: $peakDay, peakCategory: $peakCategory)';
}


}

/// @nodoc
abstract mixin class _$DailySpendCopyWith<$Res> implements $DailySpendCopyWith<$Res> {
  factory _$DailySpendCopyWith(_DailySpend value, $Res Function(_DailySpend) _then) = __$DailySpendCopyWithImpl;
@override @useResult
$Res call({
 DateTime month, List<Money> days, int elapsedDays, int? today, Money average, int? peakDay, String? peakCategory
});




}
/// @nodoc
class __$DailySpendCopyWithImpl<$Res>
    implements _$DailySpendCopyWith<$Res> {
  __$DailySpendCopyWithImpl(this._self, this._then);

  final _DailySpend _self;
  final $Res Function(_DailySpend) _then;

/// Create a copy of DailySpend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? days = null,Object? elapsedDays = null,Object? today = freezed,Object? average = null,Object? peakDay = freezed,Object? peakCategory = freezed,}) {
  return _then(_DailySpend(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<Money>,elapsedDays: null == elapsedDays ? _self.elapsedDays : elapsedDays // ignore: cast_nullable_to_non_nullable
as int,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as int?,average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as Money,peakDay: freezed == peakDay ? _self.peakDay : peakDay // ignore: cast_nullable_to_non_nullable
as int?,peakCategory: freezed == peakCategory ? _self.peakCategory : peakCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

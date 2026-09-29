// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionSummary {

 String get id; String get description; DateTime get date; Duration? get time; String get from; String get to;/// Always positive; [kind] says which way the money went.
 Money get amount; TransactionKind get kind; bool get isPending; bool get hasSlip;
/// Create a copy of TransactionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionSummaryCopyWith<TransactionSummary> get copyWith => _$TransactionSummaryCopyWithImpl<TransactionSummary>(this as TransactionSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransactionSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.time, _this.time) || other.time == _this.time)&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.to, _this.to) || other.to == _this.to)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.isPending, _this.isPending) || other.isPending == _this.isPending)&&(identical(other.hasSlip, _this.hasSlip) || other.hasSlip == _this.hasSlip));
}


@override
int get hashCode {
  final _this = this as TransactionSummary;
  return Object.hash(runtimeType,_this.id,_this.description,_this.date,_this.time,_this.from,_this.to,_this.amount,_this.kind,_this.isPending,_this.hasSlip);
}

@override
String toString() {
  final _this = this as TransactionSummary;
  return 'TransactionSummary(id: ${_this.id}, description: ${_this.description}, date: ${_this.date}, time: ${_this.time}, from: ${_this.from}, to: ${_this.to}, amount: ${_this.amount}, kind: ${_this.kind}, isPending: ${_this.isPending}, hasSlip: ${_this.hasSlip})';
}


}

/// @nodoc
abstract mixin class $TransactionSummaryCopyWith<$Res>  {
  factory $TransactionSummaryCopyWith(TransactionSummary value, $Res Function(TransactionSummary) _then) = _$TransactionSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String description, DateTime date, Duration? time, String from, String to, Money amount, TransactionKind kind, bool isPending, bool hasSlip
});




}
/// @nodoc
class _$TransactionSummaryCopyWithImpl<$Res>
    implements $TransactionSummaryCopyWith<$Res> {
  _$TransactionSummaryCopyWithImpl(this._self, this._then);

  final TransactionSummary _self;
  final $Res Function(TransactionSummary) _then;

/// Create a copy of TransactionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? date = null,Object? time = freezed,Object? from = null,Object? to = null,Object? amount = null,Object? kind = null,Object? isPending = null,Object? hasSlip = null,}) {
  return _then(TransactionSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as Duration?,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TransactionKind,isPending: null == isPending ? _self.isPending : isPending // ignore: cast_nullable_to_non_nullable
as bool,hasSlip: null == hasSlip ? _self.hasSlip : hasSlip // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionSummary].
extension TransactionSummaryPatterns on TransactionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionSummary value)  $default,){
final _that = this;
switch (_that) {
case _TransactionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  DateTime date,  Duration? time,  String from,  String to,  Money amount,  TransactionKind kind,  bool isPending,  bool hasSlip)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionSummary() when $default != null:
return $default(_that.id,_that.description,_that.date,_that.time,_that.from,_that.to,_that.amount,_that.kind,_that.isPending,_that.hasSlip);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  DateTime date,  Duration? time,  String from,  String to,  Money amount,  TransactionKind kind,  bool isPending,  bool hasSlip)  $default,) {final _that = this;
switch (_that) {
case _TransactionSummary():
return $default(_that.id,_that.description,_that.date,_that.time,_that.from,_that.to,_that.amount,_that.kind,_that.isPending,_that.hasSlip);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  DateTime date,  Duration? time,  String from,  String to,  Money amount,  TransactionKind kind,  bool isPending,  bool hasSlip)?  $default,) {final _that = this;
switch (_that) {
case _TransactionSummary() when $default != null:
return $default(_that.id,_that.description,_that.date,_that.time,_that.from,_that.to,_that.amount,_that.kind,_that.isPending,_that.hasSlip);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionSummary implements TransactionSummary {
  const _TransactionSummary({required this.id, required this.description, required this.date, this.time, required this.from, required this.to, required this.amount, required this.kind, required this.isPending, required this.hasSlip});
  

@override final  String id;
@override final  String description;
@override final  DateTime date;
@override final  Duration? time;
@override final  String from;
@override final  String to;
/// Always positive; [kind] says which way the money went.
@override final  Money amount;
@override final  TransactionKind kind;
@override final  bool isPending;
@override final  bool hasSlip;

/// Create a copy of TransactionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionSummaryCopyWith<_TransactionSummary> get copyWith => __$TransactionSummaryCopyWithImpl<_TransactionSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.isPending, isPending) || other.isPending == isPending)&&(identical(other.hasSlip, hasSlip) || other.hasSlip == hasSlip));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,description,date,time,from,to,amount,kind,isPending,hasSlip);
}

@override
String toString() {
    return 'TransactionSummary(id: $id, description: $description, date: $date, time: $time, from: $from, to: $to, amount: $amount, kind: $kind, isPending: $isPending, hasSlip: $hasSlip)';
}


}

/// @nodoc
abstract mixin class _$TransactionSummaryCopyWith<$Res> implements $TransactionSummaryCopyWith<$Res> {
  factory _$TransactionSummaryCopyWith(_TransactionSummary value, $Res Function(_TransactionSummary) _then) = __$TransactionSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, DateTime date, Duration? time, String from, String to, Money amount, TransactionKind kind, bool isPending, bool hasSlip
});




}
/// @nodoc
class __$TransactionSummaryCopyWithImpl<$Res>
    implements _$TransactionSummaryCopyWith<$Res> {
  __$TransactionSummaryCopyWithImpl(this._self, this._then);

  final _TransactionSummary _self;
  final $Res Function(_TransactionSummary) _then;

/// Create a copy of TransactionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? date = null,Object? time = freezed,Object? from = null,Object? to = null,Object? amount = null,Object? kind = null,Object? isPending = null,Object? hasSlip = null,}) {
  return _then(_TransactionSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as Duration?,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TransactionKind,isPending: null == isPending ? _self.isPending : isPending // ignore: cast_nullable_to_non_nullable
as bool,hasSlip: null == hasSlip ? _self.hasSlip : hasSlip // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

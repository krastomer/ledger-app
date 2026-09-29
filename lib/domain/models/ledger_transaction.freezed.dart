// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LedgerTransaction {

 String get id;/// Calendar date in the user's time zone (time part is zero). Kept out
/// of UTC so a transaction at 01:00 doesn't move to the previous day.
 DateTime get date;/// Time of day, when known (e.g. read from a slip).
 Duration? get time; String get description; TransactionStatus get status;/// Slip reference number; hledger's transaction code.
 String? get code; List<Posting> get postings;
/// Create a copy of LedgerTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerTransactionCopyWith<LedgerTransaction> get copyWith => _$LedgerTransactionCopyWithImpl<LedgerTransaction>(this as LedgerTransaction, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LedgerTransaction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerTransaction&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.time, _this.time) || other.time == _this.time)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.code, _this.code) || other.code == _this.code)&&const DeepCollectionEquality().equals(other.postings, _this.postings));
}


@override
int get hashCode {
  final _this = this as LedgerTransaction;
  return Object.hash(runtimeType,_this.id,_this.date,_this.time,_this.description,_this.status,_this.code,const DeepCollectionEquality().hash(_this.postings));
}

@override
String toString() {
  final _this = this as LedgerTransaction;
  return 'LedgerTransaction(id: ${_this.id}, date: ${_this.date}, time: ${_this.time}, description: ${_this.description}, status: ${_this.status}, code: ${_this.code}, postings: ${_this.postings})';
}


}

/// @nodoc
abstract mixin class $LedgerTransactionCopyWith<$Res>  {
  factory $LedgerTransactionCopyWith(LedgerTransaction value, $Res Function(LedgerTransaction) _then) = _$LedgerTransactionCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, Duration? time, String description, TransactionStatus status, String? code, List<Posting> postings
});




}
/// @nodoc
class _$LedgerTransactionCopyWithImpl<$Res>
    implements $LedgerTransactionCopyWith<$Res> {
  _$LedgerTransactionCopyWithImpl(this._self, this._then);

  final LedgerTransaction _self;
  final $Res Function(LedgerTransaction) _then;

/// Create a copy of LedgerTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? time = freezed,Object? description = null,Object? status = null,Object? code = freezed,Object? postings = null,}) {
  return _then(LedgerTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as Duration?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,postings: null == postings ? _self.postings : postings // ignore: cast_nullable_to_non_nullable
as List<Posting>,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerTransaction].
extension LedgerTransactionPatterns on LedgerTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerTransaction value)  $default,){
final _that = this;
switch (_that) {
case _LedgerTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  Duration? time,  String description,  TransactionStatus status,  String? code,  List<Posting> postings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerTransaction() when $default != null:
return $default(_that.id,_that.date,_that.time,_that.description,_that.status,_that.code,_that.postings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  Duration? time,  String description,  TransactionStatus status,  String? code,  List<Posting> postings)  $default,) {final _that = this;
switch (_that) {
case _LedgerTransaction():
return $default(_that.id,_that.date,_that.time,_that.description,_that.status,_that.code,_that.postings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  Duration? time,  String description,  TransactionStatus status,  String? code,  List<Posting> postings)?  $default,) {final _that = this;
switch (_that) {
case _LedgerTransaction() when $default != null:
return $default(_that.id,_that.date,_that.time,_that.description,_that.status,_that.code,_that.postings);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerTransaction implements LedgerTransaction {
  const _LedgerTransaction({required this.id, required this.date, this.time, required this.description, this.status = TransactionStatus.unmarked, this.code, required  List<Posting> postings}): _postings = postings;
  

@override final  String id;
/// Calendar date in the user's time zone (time part is zero). Kept out
/// of UTC so a transaction at 01:00 doesn't move to the previous day.
@override final  DateTime date;
/// Time of day, when known (e.g. read from a slip).
@override final  Duration? time;
@override final  String description;
@override@JsonKey() final  TransactionStatus status;
/// Slip reference number; hledger's transaction code.
@override final  String? code;
 final  List<Posting> _postings;
@override List<Posting> get postings {
  if (_postings is EqualUnmodifiableListView) return _postings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_postings);
}


/// Create a copy of LedgerTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerTransactionCopyWith<_LedgerTransaction> get copyWith => __$LedgerTransactionCopyWithImpl<_LedgerTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.postings, _postings));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,date,time,description,status,code,const DeepCollectionEquality().hash(_postings));
}

@override
String toString() {
    return 'LedgerTransaction(id: $id, date: $date, time: $time, description: $description, status: $status, code: $code, postings: $postings)';
}


}

/// @nodoc
abstract mixin class _$LedgerTransactionCopyWith<$Res> implements $LedgerTransactionCopyWith<$Res> {
  factory _$LedgerTransactionCopyWith(_LedgerTransaction value, $Res Function(_LedgerTransaction) _then) = __$LedgerTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, Duration? time, String description, TransactionStatus status, String? code, List<Posting> postings
});




}
/// @nodoc
class __$LedgerTransactionCopyWithImpl<$Res>
    implements _$LedgerTransactionCopyWith<$Res> {
  __$LedgerTransactionCopyWithImpl(this._self, this._then);

  final _LedgerTransaction _self;
  final $Res Function(_LedgerTransaction) _then;

/// Create a copy of LedgerTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? time = freezed,Object? description = null,Object? status = null,Object? code = freezed,Object? postings = null,}) {
  return _then(_LedgerTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as Duration?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,postings: null == postings ? _self._postings : postings // ignore: cast_nullable_to_non_nullable
as List<Posting>,
  ));
}


}

// dart format on

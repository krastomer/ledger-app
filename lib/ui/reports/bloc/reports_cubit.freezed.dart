// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsState {

 ReportsStatus get status; IncomeStatement? get statement; ReportSide? get side; List<String> get drill; ReportsError? get error;
/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsStateCopyWith<ReportsState> get copyWith => _$ReportsStateCopyWithImpl<ReportsState>(this as ReportsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReportsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.statement, _this.statement) || other.statement == _this.statement)&&(identical(other.side, _this.side) || other.side == _this.side)&&const DeepCollectionEquality().equals(other.drill, _this.drill)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as ReportsState;
  return Object.hash(runtimeType,_this.status,_this.statement,_this.side,const DeepCollectionEquality().hash(_this.drill),_this.error);
}

@override
String toString() {
  final _this = this as ReportsState;
  return 'ReportsState(status: ${_this.status}, statement: ${_this.statement}, side: ${_this.side}, drill: ${_this.drill}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ReportsStateCopyWith<$Res>  {
  factory $ReportsStateCopyWith(ReportsState value, $Res Function(ReportsState) _then) = _$ReportsStateCopyWithImpl;
@useResult
$Res call({
 ReportsStatus status, IncomeStatement? statement, ReportSide? side, List<String> drill, ReportsError? error
});


$IncomeStatementCopyWith<$Res>? get statement;

}
/// @nodoc
class _$ReportsStateCopyWithImpl<$Res>
    implements $ReportsStateCopyWith<$Res> {
  _$ReportsStateCopyWithImpl(this._self, this._then);

  final ReportsState _self;
  final $Res Function(ReportsState) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? statement = freezed,Object? side = freezed,Object? drill = null,Object? error = freezed,}) {
  return _then(ReportsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReportsStatus,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as IncomeStatement?,side: freezed == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as ReportSide?,drill: null == drill ? _self.drill : drill // ignore: cast_nullable_to_non_nullable
as List<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ReportsError?,
  ));
}
/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IncomeStatementCopyWith<$Res>? get statement {
    if (_self.statement == null) {
    return null;
  }

  return $IncomeStatementCopyWith<$Res>(_self.statement!, (value) {
    return _then(_self.copyWith(statement: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportsState].
extension ReportsStatePatterns on ReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportsState value)  $default,){
final _that = this;
switch (_that) {
case _ReportsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportsState value)?  $default,){
final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportsStatus status,  IncomeStatement? statement,  ReportSide? side,  List<String> drill,  ReportsError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
return $default(_that.status,_that.statement,_that.side,_that.drill,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportsStatus status,  IncomeStatement? statement,  ReportSide? side,  List<String> drill,  ReportsError? error)  $default,) {final _that = this;
switch (_that) {
case _ReportsState():
return $default(_that.status,_that.statement,_that.side,_that.drill,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportsStatus status,  IncomeStatement? statement,  ReportSide? side,  List<String> drill,  ReportsError? error)?  $default,) {final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
return $default(_that.status,_that.statement,_that.side,_that.drill,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ReportsState extends ReportsState {
  const _ReportsState({this.status = ReportsStatus.initial, this.statement, this.side,  List<String> drill = const [], this.error}): _drill = drill,super._();
  

@override@JsonKey() final  ReportsStatus status;
@override final  IncomeStatement? statement;
@override final  ReportSide? side;
 final  List<String> _drill;
@override@JsonKey() List<String> get drill {
  if (_drill is EqualUnmodifiableListView) return _drill;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drill);
}

@override final  ReportsError? error;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsStateCopyWith<_ReportsState> get copyWith => __$ReportsStateCopyWithImpl<_ReportsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsState&&(identical(other.status, status) || other.status == status)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.side, side) || other.side == side)&&const DeepCollectionEquality().equals(other.drill, _drill)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,statement,side,const DeepCollectionEquality().hash(_drill),error);
}

@override
String toString() {
    return 'ReportsState(status: $status, statement: $statement, side: $side, drill: $drill, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ReportsStateCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory _$ReportsStateCopyWith(_ReportsState value, $Res Function(_ReportsState) _then) = __$ReportsStateCopyWithImpl;
@override @useResult
$Res call({
 ReportsStatus status, IncomeStatement? statement, ReportSide? side, List<String> drill, ReportsError? error
});


@override $IncomeStatementCopyWith<$Res>? get statement;

}
/// @nodoc
class __$ReportsStateCopyWithImpl<$Res>
    implements _$ReportsStateCopyWith<$Res> {
  __$ReportsStateCopyWithImpl(this._self, this._then);

  final _ReportsState _self;
  final $Res Function(_ReportsState) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? statement = freezed,Object? side = freezed,Object? drill = null,Object? error = freezed,}) {
  return _then(_ReportsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReportsStatus,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as IncomeStatement?,side: freezed == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as ReportSide?,drill: null == drill ? _self._drill : drill // ignore: cast_nullable_to_non_nullable
as List<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ReportsError?,
  ));
}

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IncomeStatementCopyWith<$Res>? get statement {
    if (_self.statement == null) {
    return null;
  }

  return $IncomeStatementCopyWith<$Res>(_self.statement!, (value) {
    return _then(_self.copyWith(statement: value));
  });
}
}

// dart format on

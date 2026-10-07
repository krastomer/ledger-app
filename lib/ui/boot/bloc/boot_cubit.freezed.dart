// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'boot_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BootState {

 BootStatus get status; LedgerCheck? get check;
/// Create a copy of BootState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BootStateCopyWith<BootState> get copyWith => _$BootStateCopyWithImpl<BootState>(this as BootState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BootState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BootState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.check, _this.check) || other.check == _this.check));
}


@override
int get hashCode {
  final _this = this as BootState;
  return Object.hash(runtimeType,_this.status,_this.check);
}

@override
String toString() {
  final _this = this as BootState;
  return 'BootState(status: ${_this.status}, check: ${_this.check})';
}


}

/// @nodoc
abstract mixin class $BootStateCopyWith<$Res>  {
  factory $BootStateCopyWith(BootState value, $Res Function(BootState) _then) = _$BootStateCopyWithImpl;
@useResult
$Res call({
 BootStatus status, LedgerCheck? check
});


$LedgerCheckCopyWith<$Res>? get check;

}
/// @nodoc
class _$BootStateCopyWithImpl<$Res>
    implements $BootStateCopyWith<$Res> {
  _$BootStateCopyWithImpl(this._self, this._then);

  final BootState _self;
  final $Res Function(BootState) _then;

/// Create a copy of BootState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? check = freezed,}) {
  return _then(BootState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BootStatus,check: freezed == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as LedgerCheck?,
  ));
}
/// Create a copy of BootState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerCheckCopyWith<$Res>? get check {
    if (_self.check == null) {
    return null;
  }

  return $LedgerCheckCopyWith<$Res>(_self.check!, (value) {
    return _then(_self.copyWith(check: value));
  });
}
}


/// Adds pattern-matching-related methods to [BootState].
extension BootStatePatterns on BootState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BootState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BootState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BootState value)  $default,){
final _that = this;
switch (_that) {
case _BootState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BootState value)?  $default,){
final _that = this;
switch (_that) {
case _BootState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BootStatus status,  LedgerCheck? check)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BootState() when $default != null:
return $default(_that.status,_that.check);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BootStatus status,  LedgerCheck? check)  $default,) {final _that = this;
switch (_that) {
case _BootState():
return $default(_that.status,_that.check);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BootStatus status,  LedgerCheck? check)?  $default,) {final _that = this;
switch (_that) {
case _BootState() when $default != null:
return $default(_that.status,_that.check);case _:
  return null;

}
}

}

/// @nodoc


class _BootState implements BootState {
  const _BootState({this.status = BootStatus.checking, this.check});
  

@override@JsonKey() final  BootStatus status;
@override final  LedgerCheck? check;

/// Create a copy of BootState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BootStateCopyWith<_BootState> get copyWith => __$BootStateCopyWithImpl<_BootState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BootState&&(identical(other.status, status) || other.status == status)&&(identical(other.check, check) || other.check == check));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,check);
}

@override
String toString() {
    return 'BootState(status: $status, check: $check)';
}


}

/// @nodoc
abstract mixin class _$BootStateCopyWith<$Res> implements $BootStateCopyWith<$Res> {
  factory _$BootStateCopyWith(_BootState value, $Res Function(_BootState) _then) = __$BootStateCopyWithImpl;
@override @useResult
$Res call({
 BootStatus status, LedgerCheck? check
});


@override $LedgerCheckCopyWith<$Res>? get check;

}
/// @nodoc
class __$BootStateCopyWithImpl<$Res>
    implements _$BootStateCopyWith<$Res> {
  __$BootStateCopyWithImpl(this._self, this._then);

  final _BootState _self;
  final $Res Function(_BootState) _then;

/// Create a copy of BootState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? check = freezed,}) {
  return _then(_BootState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BootStatus,check: freezed == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as LedgerCheck?,
  ));
}

/// Create a copy of BootState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerCheckCopyWith<$Res>? get check {
    if (_self.check == null) {
    return null;
  }

  return $LedgerCheckCopyWith<$Res>(_self.check!, (value) {
    return _then(_self.copyWith(check: value));
  });
}
}

// dart format on

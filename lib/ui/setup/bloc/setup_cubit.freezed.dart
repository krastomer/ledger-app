// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetupState {

 SetupStatus get status; LedgerImportDraft? get draft; SetupError? get error; int get unreadableCount;
/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupStateCopyWith<SetupState> get copyWith => _$SetupStateCopyWithImpl<SetupState>(this as SetupState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SetupState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.draft, _this.draft) || other.draft == _this.draft)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.unreadableCount, _this.unreadableCount) || other.unreadableCount == _this.unreadableCount));
}


@override
int get hashCode {
  final _this = this as SetupState;
  return Object.hash(runtimeType,_this.status,_this.draft,_this.error,_this.unreadableCount);
}

@override
String toString() {
  final _this = this as SetupState;
  return 'SetupState(status: ${_this.status}, draft: ${_this.draft}, error: ${_this.error}, unreadableCount: ${_this.unreadableCount})';
}


}

/// @nodoc
abstract mixin class $SetupStateCopyWith<$Res>  {
  factory $SetupStateCopyWith(SetupState value, $Res Function(SetupState) _then) = _$SetupStateCopyWithImpl;
@useResult
$Res call({
 SetupStatus status, LedgerImportDraft? draft, SetupError? error, int unreadableCount
});


$LedgerImportDraftCopyWith<$Res>? get draft;

}
/// @nodoc
class _$SetupStateCopyWithImpl<$Res>
    implements $SetupStateCopyWith<$Res> {
  _$SetupStateCopyWithImpl(this._self, this._then);

  final SetupState _self;
  final $Res Function(SetupState) _then;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? draft = freezed,Object? error = freezed,Object? unreadableCount = null,}) {
  return _then(SetupState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SetupStatus,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as LedgerImportDraft?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SetupError?,unreadableCount: null == unreadableCount ? _self.unreadableCount : unreadableCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerImportDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $LedgerImportDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [SetupState].
extension SetupStatePatterns on SetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetupState value)  $default,){
final _that = this;
switch (_that) {
case _SetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetupState value)?  $default,){
final _that = this;
switch (_that) {
case _SetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SetupStatus status,  LedgerImportDraft? draft,  SetupError? error,  int unreadableCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupState() when $default != null:
return $default(_that.status,_that.draft,_that.error,_that.unreadableCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SetupStatus status,  LedgerImportDraft? draft,  SetupError? error,  int unreadableCount)  $default,) {final _that = this;
switch (_that) {
case _SetupState():
return $default(_that.status,_that.draft,_that.error,_that.unreadableCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SetupStatus status,  LedgerImportDraft? draft,  SetupError? error,  int unreadableCount)?  $default,) {final _that = this;
switch (_that) {
case _SetupState() when $default != null:
return $default(_that.status,_that.draft,_that.error,_that.unreadableCount);case _:
  return null;

}
}

}

/// @nodoc


class _SetupState implements SetupState {
  const _SetupState({this.status = SetupStatus.idle, this.draft, this.error, this.unreadableCount = 0});
  

@override@JsonKey() final  SetupStatus status;
@override final  LedgerImportDraft? draft;
@override final  SetupError? error;
@override@JsonKey() final  int unreadableCount;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetupStateCopyWith<_SetupState> get copyWith => __$SetupStateCopyWithImpl<_SetupState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupState&&(identical(other.status, status) || other.status == status)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.error, error) || other.error == error)&&(identical(other.unreadableCount, unreadableCount) || other.unreadableCount == unreadableCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,draft,error,unreadableCount);
}

@override
String toString() {
    return 'SetupState(status: $status, draft: $draft, error: $error, unreadableCount: $unreadableCount)';
}


}

/// @nodoc
abstract mixin class _$SetupStateCopyWith<$Res> implements $SetupStateCopyWith<$Res> {
  factory _$SetupStateCopyWith(_SetupState value, $Res Function(_SetupState) _then) = __$SetupStateCopyWithImpl;
@override @useResult
$Res call({
 SetupStatus status, LedgerImportDraft? draft, SetupError? error, int unreadableCount
});


@override $LedgerImportDraftCopyWith<$Res>? get draft;

}
/// @nodoc
class __$SetupStateCopyWithImpl<$Res>
    implements _$SetupStateCopyWith<$Res> {
  __$SetupStateCopyWithImpl(this._self, this._then);

  final _SetupState _self;
  final $Res Function(_SetupState) _then;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? draft = freezed,Object? error = freezed,Object? unreadableCount = null,}) {
  return _then(_SetupState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SetupStatus,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as LedgerImportDraft?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SetupError?,unreadableCount: null == unreadableCount ? _self.unreadableCount : unreadableCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerImportDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $LedgerImportDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on

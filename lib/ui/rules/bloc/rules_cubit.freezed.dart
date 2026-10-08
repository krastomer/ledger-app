// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rules_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RulesState {

 RulesStatus get status; RuleSet? get saved; RuleSet? get draft; RulesError? get error;
/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesStateCopyWith<RulesState> get copyWith => _$RulesStateCopyWithImpl<RulesState>(this as RulesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RulesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.saved, _this.saved) || other.saved == _this.saved)&&(identical(other.draft, _this.draft) || other.draft == _this.draft)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as RulesState;
  return Object.hash(runtimeType,_this.status,_this.saved,_this.draft,_this.error);
}

@override
String toString() {
  final _this = this as RulesState;
  return 'RulesState(status: ${_this.status}, saved: ${_this.saved}, draft: ${_this.draft}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $RulesStateCopyWith<$Res>  {
  factory $RulesStateCopyWith(RulesState value, $Res Function(RulesState) _then) = _$RulesStateCopyWithImpl;
@useResult
$Res call({
 RulesStatus status, RuleSet? saved, RuleSet? draft, RulesError? error
});


$RuleSetCopyWith<$Res>? get saved;$RuleSetCopyWith<$Res>? get draft;

}
/// @nodoc
class _$RulesStateCopyWithImpl<$Res>
    implements $RulesStateCopyWith<$Res> {
  _$RulesStateCopyWithImpl(this._self, this._then);

  final RulesState _self;
  final $Res Function(RulesState) _then;

/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? saved = freezed,Object? draft = freezed,Object? error = freezed,}) {
  return _then(RulesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RulesStatus,saved: freezed == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as RuleSet?,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as RuleSet?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as RulesError?,
  ));
}
/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleSetCopyWith<$Res>? get saved {
    if (_self.saved == null) {
    return null;
  }

  return $RuleSetCopyWith<$Res>(_self.saved!, (value) {
    return _then(_self.copyWith(saved: value));
  });
}/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleSetCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $RuleSetCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [RulesState].
extension RulesStatePatterns on RulesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RulesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RulesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RulesState value)  $default,){
final _that = this;
switch (_that) {
case _RulesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RulesState value)?  $default,){
final _that = this;
switch (_that) {
case _RulesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RulesStatus status,  RuleSet? saved,  RuleSet? draft,  RulesError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RulesState() when $default != null:
return $default(_that.status,_that.saved,_that.draft,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RulesStatus status,  RuleSet? saved,  RuleSet? draft,  RulesError? error)  $default,) {final _that = this;
switch (_that) {
case _RulesState():
return $default(_that.status,_that.saved,_that.draft,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RulesStatus status,  RuleSet? saved,  RuleSet? draft,  RulesError? error)?  $default,) {final _that = this;
switch (_that) {
case _RulesState() when $default != null:
return $default(_that.status,_that.saved,_that.draft,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _RulesState implements RulesState {
  const _RulesState({this.status = RulesStatus.initial, this.saved, this.draft, this.error});
  

@override@JsonKey() final  RulesStatus status;
@override final  RuleSet? saved;
@override final  RuleSet? draft;
@override final  RulesError? error;

/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RulesStateCopyWith<_RulesState> get copyWith => __$RulesStateCopyWithImpl<_RulesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RulesState&&(identical(other.status, status) || other.status == status)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,saved,draft,error);
}

@override
String toString() {
    return 'RulesState(status: $status, saved: $saved, draft: $draft, error: $error)';
}


}

/// @nodoc
abstract mixin class _$RulesStateCopyWith<$Res> implements $RulesStateCopyWith<$Res> {
  factory _$RulesStateCopyWith(_RulesState value, $Res Function(_RulesState) _then) = __$RulesStateCopyWithImpl;
@override @useResult
$Res call({
 RulesStatus status, RuleSet? saved, RuleSet? draft, RulesError? error
});


@override $RuleSetCopyWith<$Res>? get saved;@override $RuleSetCopyWith<$Res>? get draft;

}
/// @nodoc
class __$RulesStateCopyWithImpl<$Res>
    implements _$RulesStateCopyWith<$Res> {
  __$RulesStateCopyWithImpl(this._self, this._then);

  final _RulesState _self;
  final $Res Function(_RulesState) _then;

/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? saved = freezed,Object? draft = freezed,Object? error = freezed,}) {
  return _then(_RulesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RulesStatus,saved: freezed == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as RuleSet?,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as RuleSet?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as RulesError?,
  ));
}

/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleSetCopyWith<$Res>? get saved {
    if (_self.saved == null) {
    return null;
  }

  return $RuleSetCopyWith<$Res>(_self.saved!, (value) {
    return _then(_self.copyWith(saved: value));
  });
}/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleSetCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $RuleSetCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on

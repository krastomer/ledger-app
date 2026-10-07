// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accounts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountsState {

 AccountsStatus get status; AccountsSummary? get summary; AccountsMode get mode; Set<String> get expanded; AccountsError? get error;
/// Create a copy of AccountsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountsStateCopyWith<AccountsState> get copyWith => _$AccountsStateCopyWithImpl<AccountsState>(this as AccountsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountsState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&const DeepCollectionEquality().equals(other.expanded, _this.expanded)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as AccountsState;
  return Object.hash(runtimeType,_this.status,_this.summary,_this.mode,const DeepCollectionEquality().hash(_this.expanded),_this.error);
}

@override
String toString() {
  final _this = this as AccountsState;
  return 'AccountsState(status: ${_this.status}, summary: ${_this.summary}, mode: ${_this.mode}, expanded: ${_this.expanded}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $AccountsStateCopyWith<$Res>  {
  factory $AccountsStateCopyWith(AccountsState value, $Res Function(AccountsState) _then) = _$AccountsStateCopyWithImpl;
@useResult
$Res call({
 AccountsStatus status, AccountsSummary? summary, AccountsMode mode, Set<String> expanded, AccountsError? error
});


$AccountsSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class _$AccountsStateCopyWithImpl<$Res>
    implements $AccountsStateCopyWith<$Res> {
  _$AccountsStateCopyWithImpl(this._self, this._then);

  final AccountsState _self;
  final $Res Function(AccountsState) _then;

/// Create a copy of AccountsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? summary = freezed,Object? mode = null,Object? expanded = null,Object? error = freezed,}) {
  return _then(AccountsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountsStatus,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as AccountsSummary?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AccountsMode,expanded: null == expanded ? _self.expanded : expanded // ignore: cast_nullable_to_non_nullable
as Set<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AccountsError?,
  ));
}
/// Create a copy of AccountsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountsSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $AccountsSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountsState].
extension AccountsStatePatterns on AccountsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountsState value)  $default,){
final _that = this;
switch (_that) {
case _AccountsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountsState value)?  $default,){
final _that = this;
switch (_that) {
case _AccountsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AccountsStatus status,  AccountsSummary? summary,  AccountsMode mode,  Set<String> expanded,  AccountsError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountsState() when $default != null:
return $default(_that.status,_that.summary,_that.mode,_that.expanded,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AccountsStatus status,  AccountsSummary? summary,  AccountsMode mode,  Set<String> expanded,  AccountsError? error)  $default,) {final _that = this;
switch (_that) {
case _AccountsState():
return $default(_that.status,_that.summary,_that.mode,_that.expanded,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AccountsStatus status,  AccountsSummary? summary,  AccountsMode mode,  Set<String> expanded,  AccountsError? error)?  $default,) {final _that = this;
switch (_that) {
case _AccountsState() when $default != null:
return $default(_that.status,_that.summary,_that.mode,_that.expanded,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _AccountsState implements AccountsState {
  const _AccountsState({this.status = AccountsStatus.initial, this.summary, this.mode = AccountsMode.balance,  Set<String> expanded = const {}, this.error}): _expanded = expanded;
  

@override@JsonKey() final  AccountsStatus status;
@override final  AccountsSummary? summary;
@override@JsonKey() final  AccountsMode mode;
 final  Set<String> _expanded;
@override@JsonKey() Set<String> get expanded {
  if (_expanded is EqualUnmodifiableSetView) return _expanded;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_expanded);
}

@override final  AccountsError? error;

/// Create a copy of AccountsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountsStateCopyWith<_AccountsState> get copyWith => __$AccountsStateCopyWithImpl<_AccountsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountsState&&(identical(other.status, status) || other.status == status)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.expanded, _expanded)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,summary,mode,const DeepCollectionEquality().hash(_expanded),error);
}

@override
String toString() {
    return 'AccountsState(status: $status, summary: $summary, mode: $mode, expanded: $expanded, error: $error)';
}


}

/// @nodoc
abstract mixin class _$AccountsStateCopyWith<$Res> implements $AccountsStateCopyWith<$Res> {
  factory _$AccountsStateCopyWith(_AccountsState value, $Res Function(_AccountsState) _then) = __$AccountsStateCopyWithImpl;
@override @useResult
$Res call({
 AccountsStatus status, AccountsSummary? summary, AccountsMode mode, Set<String> expanded, AccountsError? error
});


@override $AccountsSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class __$AccountsStateCopyWithImpl<$Res>
    implements _$AccountsStateCopyWith<$Res> {
  __$AccountsStateCopyWithImpl(this._self, this._then);

  final _AccountsState _self;
  final $Res Function(_AccountsState) _then;

/// Create a copy of AccountsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? summary = freezed,Object? mode = null,Object? expanded = null,Object? error = freezed,}) {
  return _then(_AccountsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountsStatus,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as AccountsSummary?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AccountsMode,expanded: null == expanded ? _self._expanded : expanded // ignore: cast_nullable_to_non_nullable
as Set<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AccountsError?,
  ));
}

/// Create a copy of AccountsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountsSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $AccountsSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on

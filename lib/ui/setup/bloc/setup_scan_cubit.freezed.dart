// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_scan_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetupScanState {

 SetupScanPhase get phase; int get libraryCount; int get toCheck; int get checked; List<FoundSlip> get found; Set<String> get selected; SetupScanError? get error;
/// Create a copy of SetupScanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupScanStateCopyWith<SetupScanState> get copyWith => _$SetupScanStateCopyWithImpl<SetupScanState>(this as SetupScanState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SetupScanState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupScanState&&(identical(other.phase, _this.phase) || other.phase == _this.phase)&&(identical(other.libraryCount, _this.libraryCount) || other.libraryCount == _this.libraryCount)&&(identical(other.toCheck, _this.toCheck) || other.toCheck == _this.toCheck)&&(identical(other.checked, _this.checked) || other.checked == _this.checked)&&const DeepCollectionEquality().equals(other.found, _this.found)&&const DeepCollectionEquality().equals(other.selected, _this.selected)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as SetupScanState;
  return Object.hash(runtimeType,_this.phase,_this.libraryCount,_this.toCheck,_this.checked,const DeepCollectionEquality().hash(_this.found),const DeepCollectionEquality().hash(_this.selected),_this.error);
}

@override
String toString() {
  final _this = this as SetupScanState;
  return 'SetupScanState(phase: ${_this.phase}, libraryCount: ${_this.libraryCount}, toCheck: ${_this.toCheck}, checked: ${_this.checked}, found: ${_this.found}, selected: ${_this.selected}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $SetupScanStateCopyWith<$Res>  {
  factory $SetupScanStateCopyWith(SetupScanState value, $Res Function(SetupScanState) _then) = _$SetupScanStateCopyWithImpl;
@useResult
$Res call({
 SetupScanPhase phase, int libraryCount, int toCheck, int checked, List<FoundSlip> found, Set<String> selected, SetupScanError? error
});




}
/// @nodoc
class _$SetupScanStateCopyWithImpl<$Res>
    implements $SetupScanStateCopyWith<$Res> {
  _$SetupScanStateCopyWithImpl(this._self, this._then);

  final SetupScanState _self;
  final $Res Function(SetupScanState) _then;

/// Create a copy of SetupScanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? libraryCount = null,Object? toCheck = null,Object? checked = null,Object? found = null,Object? selected = null,Object? error = freezed,}) {
  return _then(SetupScanState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SetupScanPhase,libraryCount: null == libraryCount ? _self.libraryCount : libraryCount // ignore: cast_nullable_to_non_nullable
as int,toCheck: null == toCheck ? _self.toCheck : toCheck // ignore: cast_nullable_to_non_nullable
as int,checked: null == checked ? _self.checked : checked // ignore: cast_nullable_to_non_nullable
as int,found: null == found ? _self.found : found // ignore: cast_nullable_to_non_nullable
as List<FoundSlip>,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as Set<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SetupScanError?,
  ));
}

}


/// Adds pattern-matching-related methods to [SetupScanState].
extension SetupScanStatePatterns on SetupScanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetupScanState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupScanState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetupScanState value)  $default,){
final _that = this;
switch (_that) {
case _SetupScanState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetupScanState value)?  $default,){
final _that = this;
switch (_that) {
case _SetupScanState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SetupScanPhase phase,  int libraryCount,  int toCheck,  int checked,  List<FoundSlip> found,  Set<String> selected,  SetupScanError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupScanState() when $default != null:
return $default(_that.phase,_that.libraryCount,_that.toCheck,_that.checked,_that.found,_that.selected,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SetupScanPhase phase,  int libraryCount,  int toCheck,  int checked,  List<FoundSlip> found,  Set<String> selected,  SetupScanError? error)  $default,) {final _that = this;
switch (_that) {
case _SetupScanState():
return $default(_that.phase,_that.libraryCount,_that.toCheck,_that.checked,_that.found,_that.selected,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SetupScanPhase phase,  int libraryCount,  int toCheck,  int checked,  List<FoundSlip> found,  Set<String> selected,  SetupScanError? error)?  $default,) {final _that = this;
switch (_that) {
case _SetupScanState() when $default != null:
return $default(_that.phase,_that.libraryCount,_that.toCheck,_that.checked,_that.found,_that.selected,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SetupScanState extends SetupScanState {
  const _SetupScanState({this.phase = SetupScanPhase.starting, this.libraryCount = 0, this.toCheck = 0, this.checked = 0,  List<FoundSlip> found = const [],  Set<String> selected = const {}, this.error}): _found = found,_selected = selected,super._();
  

@override@JsonKey() final  SetupScanPhase phase;
@override@JsonKey() final  int libraryCount;
@override@JsonKey() final  int toCheck;
@override@JsonKey() final  int checked;
 final  List<FoundSlip> _found;
@override@JsonKey() List<FoundSlip> get found {
  if (_found is EqualUnmodifiableListView) return _found;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_found);
}

 final  Set<String> _selected;
@override@JsonKey() Set<String> get selected {
  if (_selected is EqualUnmodifiableSetView) return _selected;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selected);
}

@override final  SetupScanError? error;

/// Create a copy of SetupScanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetupScanStateCopyWith<_SetupScanState> get copyWith => __$SetupScanStateCopyWithImpl<_SetupScanState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupScanState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.libraryCount, libraryCount) || other.libraryCount == libraryCount)&&(identical(other.toCheck, toCheck) || other.toCheck == toCheck)&&(identical(other.checked, checked) || other.checked == checked)&&const DeepCollectionEquality().equals(other.found, _found)&&const DeepCollectionEquality().equals(other.selected, _selected)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,phase,libraryCount,toCheck,checked,const DeepCollectionEquality().hash(_found),const DeepCollectionEquality().hash(_selected),error);
}

@override
String toString() {
    return 'SetupScanState(phase: $phase, libraryCount: $libraryCount, toCheck: $toCheck, checked: $checked, found: $found, selected: $selected, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SetupScanStateCopyWith<$Res> implements $SetupScanStateCopyWith<$Res> {
  factory _$SetupScanStateCopyWith(_SetupScanState value, $Res Function(_SetupScanState) _then) = __$SetupScanStateCopyWithImpl;
@override @useResult
$Res call({
 SetupScanPhase phase, int libraryCount, int toCheck, int checked, List<FoundSlip> found, Set<String> selected, SetupScanError? error
});




}
/// @nodoc
class __$SetupScanStateCopyWithImpl<$Res>
    implements _$SetupScanStateCopyWith<$Res> {
  __$SetupScanStateCopyWithImpl(this._self, this._then);

  final _SetupScanState _self;
  final $Res Function(_SetupScanState) _then;

/// Create a copy of SetupScanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? libraryCount = null,Object? toCheck = null,Object? checked = null,Object? found = null,Object? selected = null,Object? error = freezed,}) {
  return _then(_SetupScanState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SetupScanPhase,libraryCount: null == libraryCount ? _self.libraryCount : libraryCount // ignore: cast_nullable_to_non_nullable
as int,toCheck: null == toCheck ? _self.toCheck : toCheck // ignore: cast_nullable_to_non_nullable
as int,checked: null == checked ? _self.checked : checked // ignore: cast_nullable_to_non_nullable
as int,found: null == found ? _self._found : found // ignore: cast_nullable_to_non_nullable
as List<FoundSlip>,selected: null == selected ? _self._selected : selected // ignore: cast_nullable_to_non_nullable
as Set<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SetupScanError?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slip_review_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SlipReviewState {

 List<String> get imagePaths; int get index; SlipReviewStatus get status; SlipDraft? get draft; int get savedCount; SlipReviewError? get error;
/// Create a copy of SlipReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlipReviewStateCopyWith<SlipReviewState> get copyWith => _$SlipReviewStateCopyWithImpl<SlipReviewState>(this as SlipReviewState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SlipReviewState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlipReviewState&&const DeepCollectionEquality().equals(other.imagePaths, _this.imagePaths)&&(identical(other.index, _this.index) || other.index == _this.index)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.draft, _this.draft) || other.draft == _this.draft)&&(identical(other.savedCount, _this.savedCount) || other.savedCount == _this.savedCount)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as SlipReviewState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.imagePaths),_this.index,_this.status,_this.draft,_this.savedCount,_this.error);
}

@override
String toString() {
  final _this = this as SlipReviewState;
  return 'SlipReviewState(imagePaths: ${_this.imagePaths}, index: ${_this.index}, status: ${_this.status}, draft: ${_this.draft}, savedCount: ${_this.savedCount}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $SlipReviewStateCopyWith<$Res>  {
  factory $SlipReviewStateCopyWith(SlipReviewState value, $Res Function(SlipReviewState) _then) = _$SlipReviewStateCopyWithImpl;
@useResult
$Res call({
 List<String> imagePaths, int index, SlipReviewStatus status, SlipDraft? draft, int savedCount, SlipReviewError? error
});


$SlipDraftCopyWith<$Res>? get draft;

}
/// @nodoc
class _$SlipReviewStateCopyWithImpl<$Res>
    implements $SlipReviewStateCopyWith<$Res> {
  _$SlipReviewStateCopyWithImpl(this._self, this._then);

  final SlipReviewState _self;
  final $Res Function(SlipReviewState) _then;

/// Create a copy of SlipReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imagePaths = null,Object? index = null,Object? status = null,Object? draft = freezed,Object? savedCount = null,Object? error = freezed,}) {
  return _then(SlipReviewState(
imagePaths: null == imagePaths ? _self.imagePaths : imagePaths // ignore: cast_nullable_to_non_nullable
as List<String>,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SlipReviewStatus,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as SlipDraft?,savedCount: null == savedCount ? _self.savedCount : savedCount // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SlipReviewError?,
  ));
}
/// Create a copy of SlipReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlipDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $SlipDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [SlipReviewState].
extension SlipReviewStatePatterns on SlipReviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlipReviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlipReviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlipReviewState value)  $default,){
final _that = this;
switch (_that) {
case _SlipReviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlipReviewState value)?  $default,){
final _that = this;
switch (_that) {
case _SlipReviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> imagePaths,  int index,  SlipReviewStatus status,  SlipDraft? draft,  int savedCount,  SlipReviewError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlipReviewState() when $default != null:
return $default(_that.imagePaths,_that.index,_that.status,_that.draft,_that.savedCount,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> imagePaths,  int index,  SlipReviewStatus status,  SlipDraft? draft,  int savedCount,  SlipReviewError? error)  $default,) {final _that = this;
switch (_that) {
case _SlipReviewState():
return $default(_that.imagePaths,_that.index,_that.status,_that.draft,_that.savedCount,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> imagePaths,  int index,  SlipReviewStatus status,  SlipDraft? draft,  int savedCount,  SlipReviewError? error)?  $default,) {final _that = this;
switch (_that) {
case _SlipReviewState() when $default != null:
return $default(_that.imagePaths,_that.index,_that.status,_that.draft,_that.savedCount,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SlipReviewState extends SlipReviewState {
  const _SlipReviewState({required  List<String> imagePaths, this.index = 0, this.status = SlipReviewStatus.reading, this.draft, this.savedCount = 0, this.error}): _imagePaths = imagePaths,super._();
  

 final  List<String> _imagePaths;
@override List<String> get imagePaths {
  if (_imagePaths is EqualUnmodifiableListView) return _imagePaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imagePaths);
}

@override@JsonKey() final  int index;
@override@JsonKey() final  SlipReviewStatus status;
@override final  SlipDraft? draft;
@override@JsonKey() final  int savedCount;
@override final  SlipReviewError? error;

/// Create a copy of SlipReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlipReviewStateCopyWith<_SlipReviewState> get copyWith => __$SlipReviewStateCopyWithImpl<_SlipReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlipReviewState&&const DeepCollectionEquality().equals(other.imagePaths, _imagePaths)&&(identical(other.index, index) || other.index == index)&&(identical(other.status, status) || other.status == status)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.savedCount, savedCount) || other.savedCount == savedCount)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_imagePaths),index,status,draft,savedCount,error);
}

@override
String toString() {
    return 'SlipReviewState(imagePaths: $imagePaths, index: $index, status: $status, draft: $draft, savedCount: $savedCount, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SlipReviewStateCopyWith<$Res> implements $SlipReviewStateCopyWith<$Res> {
  factory _$SlipReviewStateCopyWith(_SlipReviewState value, $Res Function(_SlipReviewState) _then) = __$SlipReviewStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> imagePaths, int index, SlipReviewStatus status, SlipDraft? draft, int savedCount, SlipReviewError? error
});


@override $SlipDraftCopyWith<$Res>? get draft;

}
/// @nodoc
class __$SlipReviewStateCopyWithImpl<$Res>
    implements _$SlipReviewStateCopyWith<$Res> {
  __$SlipReviewStateCopyWithImpl(this._self, this._then);

  final _SlipReviewState _self;
  final $Res Function(_SlipReviewState) _then;

/// Create a copy of SlipReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imagePaths = null,Object? index = null,Object? status = null,Object? draft = freezed,Object? savedCount = null,Object? error = freezed,}) {
  return _then(_SlipReviewState(
imagePaths: null == imagePaths ? _self._imagePaths : imagePaths // ignore: cast_nullable_to_non_nullable
as List<String>,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SlipReviewStatus,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as SlipDraft?,savedCount: null == savedCount ? _self.savedCount : savedCount // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SlipReviewError?,
  ));
}

/// Create a copy of SlipReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlipDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $SlipDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on

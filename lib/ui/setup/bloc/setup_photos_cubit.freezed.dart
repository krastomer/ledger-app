// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_photos_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetupPhotosState {

 SetupPhotosStatus get status; List<GalleryAlbum> get albums; bool get limited;
/// Create a copy of SetupPhotosState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupPhotosStateCopyWith<SetupPhotosState> get copyWith => _$SetupPhotosStateCopyWithImpl<SetupPhotosState>(this as SetupPhotosState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SetupPhotosState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupPhotosState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.albums, _this.albums)&&(identical(other.limited, _this.limited) || other.limited == _this.limited));
}


@override
int get hashCode {
  final _this = this as SetupPhotosState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.albums),_this.limited);
}

@override
String toString() {
  final _this = this as SetupPhotosState;
  return 'SetupPhotosState(status: ${_this.status}, albums: ${_this.albums}, limited: ${_this.limited})';
}


}

/// @nodoc
abstract mixin class $SetupPhotosStateCopyWith<$Res>  {
  factory $SetupPhotosStateCopyWith(SetupPhotosState value, $Res Function(SetupPhotosState) _then) = _$SetupPhotosStateCopyWithImpl;
@useResult
$Res call({
 SetupPhotosStatus status, List<GalleryAlbum> albums, bool limited
});




}
/// @nodoc
class _$SetupPhotosStateCopyWithImpl<$Res>
    implements $SetupPhotosStateCopyWith<$Res> {
  _$SetupPhotosStateCopyWithImpl(this._self, this._then);

  final SetupPhotosState _self;
  final $Res Function(SetupPhotosState) _then;

/// Create a copy of SetupPhotosState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? albums = null,Object? limited = null,}) {
  return _then(SetupPhotosState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SetupPhotosStatus,albums: null == albums ? _self.albums : albums // ignore: cast_nullable_to_non_nullable
as List<GalleryAlbum>,limited: null == limited ? _self.limited : limited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SetupPhotosState].
extension SetupPhotosStatePatterns on SetupPhotosState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetupPhotosState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupPhotosState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetupPhotosState value)  $default,){
final _that = this;
switch (_that) {
case _SetupPhotosState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetupPhotosState value)?  $default,){
final _that = this;
switch (_that) {
case _SetupPhotosState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SetupPhotosStatus status,  List<GalleryAlbum> albums,  bool limited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupPhotosState() when $default != null:
return $default(_that.status,_that.albums,_that.limited);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SetupPhotosStatus status,  List<GalleryAlbum> albums,  bool limited)  $default,) {final _that = this;
switch (_that) {
case _SetupPhotosState():
return $default(_that.status,_that.albums,_that.limited);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SetupPhotosStatus status,  List<GalleryAlbum> albums,  bool limited)?  $default,) {final _that = this;
switch (_that) {
case _SetupPhotosState() when $default != null:
return $default(_that.status,_that.albums,_that.limited);case _:
  return null;

}
}

}

/// @nodoc


class _SetupPhotosState implements SetupPhotosState {
  const _SetupPhotosState({this.status = SetupPhotosStatus.idle,  List<GalleryAlbum> albums = const [], this.limited = false}): _albums = albums;
  

@override@JsonKey() final  SetupPhotosStatus status;
 final  List<GalleryAlbum> _albums;
@override@JsonKey() List<GalleryAlbum> get albums {
  if (_albums is EqualUnmodifiableListView) return _albums;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_albums);
}

@override@JsonKey() final  bool limited;

/// Create a copy of SetupPhotosState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetupPhotosStateCopyWith<_SetupPhotosState> get copyWith => __$SetupPhotosStateCopyWithImpl<_SetupPhotosState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupPhotosState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.albums, _albums)&&(identical(other.limited, limited) || other.limited == limited));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_albums),limited);
}

@override
String toString() {
    return 'SetupPhotosState(status: $status, albums: $albums, limited: $limited)';
}


}

/// @nodoc
abstract mixin class _$SetupPhotosStateCopyWith<$Res> implements $SetupPhotosStateCopyWith<$Res> {
  factory _$SetupPhotosStateCopyWith(_SetupPhotosState value, $Res Function(_SetupPhotosState) _then) = __$SetupPhotosStateCopyWithImpl;
@override @useResult
$Res call({
 SetupPhotosStatus status, List<GalleryAlbum> albums, bool limited
});




}
/// @nodoc
class __$SetupPhotosStateCopyWithImpl<$Res>
    implements _$SetupPhotosStateCopyWith<$Res> {
  __$SetupPhotosStateCopyWithImpl(this._self, this._then);

  final _SetupPhotosState _self;
  final $Res Function(_SetupPhotosState) _then;

/// Create a copy of SetupPhotosState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? albums = null,Object? limited = null,}) {
  return _then(_SetupPhotosState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SetupPhotosStatus,albums: null == albums ? _self._albums : albums // ignore: cast_nullable_to_non_nullable
as List<GalleryAlbum>,limited: null == limited ? _self.limited : limited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

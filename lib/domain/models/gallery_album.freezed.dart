// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_album.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GalleryAlbum {

 String get id; String get name; int get count; GalleryAlbumKind get kind;
/// Create a copy of GalleryAlbum
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GalleryAlbumCopyWith<GalleryAlbum> get copyWith => _$GalleryAlbumCopyWithImpl<GalleryAlbum>(this as GalleryAlbum, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GalleryAlbum;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GalleryAlbum&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.kind, _this.kind) || other.kind == _this.kind));
}


@override
int get hashCode {
  final _this = this as GalleryAlbum;
  return Object.hash(runtimeType,_this.id,_this.name,_this.count,_this.kind);
}

@override
String toString() {
  final _this = this as GalleryAlbum;
  return 'GalleryAlbum(id: ${_this.id}, name: ${_this.name}, count: ${_this.count}, kind: ${_this.kind})';
}


}

/// @nodoc
abstract mixin class $GalleryAlbumCopyWith<$Res>  {
  factory $GalleryAlbumCopyWith(GalleryAlbum value, $Res Function(GalleryAlbum) _then) = _$GalleryAlbumCopyWithImpl;
@useResult
$Res call({
 String id, String name, int count, GalleryAlbumKind kind
});




}
/// @nodoc
class _$GalleryAlbumCopyWithImpl<$Res>
    implements $GalleryAlbumCopyWith<$Res> {
  _$GalleryAlbumCopyWithImpl(this._self, this._then);

  final GalleryAlbum _self;
  final $Res Function(GalleryAlbum) _then;

/// Create a copy of GalleryAlbum
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? count = null,Object? kind = null,}) {
  return _then(GalleryAlbum(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as GalleryAlbumKind,
  ));
}

}


/// Adds pattern-matching-related methods to [GalleryAlbum].
extension GalleryAlbumPatterns on GalleryAlbum {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GalleryAlbum value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GalleryAlbum() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GalleryAlbum value)  $default,){
final _that = this;
switch (_that) {
case _GalleryAlbum():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GalleryAlbum value)?  $default,){
final _that = this;
switch (_that) {
case _GalleryAlbum() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int count,  GalleryAlbumKind kind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GalleryAlbum() when $default != null:
return $default(_that.id,_that.name,_that.count,_that.kind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int count,  GalleryAlbumKind kind)  $default,) {final _that = this;
switch (_that) {
case _GalleryAlbum():
return $default(_that.id,_that.name,_that.count,_that.kind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int count,  GalleryAlbumKind kind)?  $default,) {final _that = this;
switch (_that) {
case _GalleryAlbum() when $default != null:
return $default(_that.id,_that.name,_that.count,_that.kind);case _:
  return null;

}
}

}

/// @nodoc


class _GalleryAlbum extends GalleryAlbum {
  const _GalleryAlbum({required this.id, required this.name, required this.count, required this.kind}): super._();
  

@override final  String id;
@override final  String name;
@override final  int count;
@override final  GalleryAlbumKind kind;

/// Create a copy of GalleryAlbum
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GalleryAlbumCopyWith<_GalleryAlbum> get copyWith => __$GalleryAlbumCopyWithImpl<_GalleryAlbum>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GalleryAlbum&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count)&&(identical(other.kind, kind) || other.kind == kind));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,count,kind);
}

@override
String toString() {
    return 'GalleryAlbum(id: $id, name: $name, count: $count, kind: $kind)';
}


}

/// @nodoc
abstract mixin class _$GalleryAlbumCopyWith<$Res> implements $GalleryAlbumCopyWith<$Res> {
  factory _$GalleryAlbumCopyWith(_GalleryAlbum value, $Res Function(_GalleryAlbum) _then) = __$GalleryAlbumCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int count, GalleryAlbumKind kind
});




}
/// @nodoc
class __$GalleryAlbumCopyWithImpl<$Res>
    implements _$GalleryAlbumCopyWith<$Res> {
  __$GalleryAlbumCopyWithImpl(this._self, this._then);

  final _GalleryAlbum _self;
  final $Res Function(_GalleryAlbum) _then;

/// Create a copy of GalleryAlbum
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? count = null,Object? kind = null,}) {
  return _then(_GalleryAlbum(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as GalleryAlbumKind,
  ));
}


}

// dart format on

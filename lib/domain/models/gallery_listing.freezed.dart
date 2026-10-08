// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GalleryListing {

/// Every image on the device, whatever the scope.
 int get libraryCount;/// Images in the scope to check, newest first.
 List<String> get photoIds;
/// Create a copy of GalleryListing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GalleryListingCopyWith<GalleryListing> get copyWith => _$GalleryListingCopyWithImpl<GalleryListing>(this as GalleryListing, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GalleryListing;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GalleryListing&&(identical(other.libraryCount, _this.libraryCount) || other.libraryCount == _this.libraryCount)&&const DeepCollectionEquality().equals(other.photoIds, _this.photoIds));
}


@override
int get hashCode {
  final _this = this as GalleryListing;
  return Object.hash(runtimeType,_this.libraryCount,const DeepCollectionEquality().hash(_this.photoIds));
}

@override
String toString() {
  final _this = this as GalleryListing;
  return 'GalleryListing(libraryCount: ${_this.libraryCount}, photoIds: ${_this.photoIds})';
}


}

/// @nodoc
abstract mixin class $GalleryListingCopyWith<$Res>  {
  factory $GalleryListingCopyWith(GalleryListing value, $Res Function(GalleryListing) _then) = _$GalleryListingCopyWithImpl;
@useResult
$Res call({
 int libraryCount, List<String> photoIds
});




}
/// @nodoc
class _$GalleryListingCopyWithImpl<$Res>
    implements $GalleryListingCopyWith<$Res> {
  _$GalleryListingCopyWithImpl(this._self, this._then);

  final GalleryListing _self;
  final $Res Function(GalleryListing) _then;

/// Create a copy of GalleryListing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? libraryCount = null,Object? photoIds = null,}) {
  return _then(GalleryListing(
libraryCount: null == libraryCount ? _self.libraryCount : libraryCount // ignore: cast_nullable_to_non_nullable
as int,photoIds: null == photoIds ? _self.photoIds : photoIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [GalleryListing].
extension GalleryListingPatterns on GalleryListing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GalleryListing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GalleryListing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GalleryListing value)  $default,){
final _that = this;
switch (_that) {
case _GalleryListing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GalleryListing value)?  $default,){
final _that = this;
switch (_that) {
case _GalleryListing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int libraryCount,  List<String> photoIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GalleryListing() when $default != null:
return $default(_that.libraryCount,_that.photoIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int libraryCount,  List<String> photoIds)  $default,) {final _that = this;
switch (_that) {
case _GalleryListing():
return $default(_that.libraryCount,_that.photoIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int libraryCount,  List<String> photoIds)?  $default,) {final _that = this;
switch (_that) {
case _GalleryListing() when $default != null:
return $default(_that.libraryCount,_that.photoIds);case _:
  return null;

}
}

}

/// @nodoc


class _GalleryListing implements GalleryListing {
  const _GalleryListing({required this.libraryCount, required  List<String> photoIds}): _photoIds = photoIds;
  

/// Every image on the device, whatever the scope.
@override final  int libraryCount;
/// Images in the scope to check, newest first.
 final  List<String> _photoIds;
/// Images in the scope to check, newest first.
@override List<String> get photoIds {
  if (_photoIds is EqualUnmodifiableListView) return _photoIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoIds);
}


/// Create a copy of GalleryListing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GalleryListingCopyWith<_GalleryListing> get copyWith => __$GalleryListingCopyWithImpl<_GalleryListing>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GalleryListing&&(identical(other.libraryCount, libraryCount) || other.libraryCount == libraryCount)&&const DeepCollectionEquality().equals(other.photoIds, _photoIds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,libraryCount,const DeepCollectionEquality().hash(_photoIds));
}

@override
String toString() {
    return 'GalleryListing(libraryCount: $libraryCount, photoIds: $photoIds)';
}


}

/// @nodoc
abstract mixin class _$GalleryListingCopyWith<$Res> implements $GalleryListingCopyWith<$Res> {
  factory _$GalleryListingCopyWith(_GalleryListing value, $Res Function(_GalleryListing) _then) = __$GalleryListingCopyWithImpl;
@override @useResult
$Res call({
 int libraryCount, List<String> photoIds
});




}
/// @nodoc
class __$GalleryListingCopyWithImpl<$Res>
    implements _$GalleryListingCopyWith<$Res> {
  __$GalleryListingCopyWithImpl(this._self, this._then);

  final _GalleryListing _self;
  final $Res Function(_GalleryListing) _then;

/// Create a copy of GalleryListing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? libraryCount = null,Object? photoIds = null,}) {
  return _then(_GalleryListing(
libraryCount: null == libraryCount ? _self.libraryCount : libraryCount // ignore: cast_nullable_to_non_nullable
as int,photoIds: null == photoIds ? _self._photoIds : photoIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

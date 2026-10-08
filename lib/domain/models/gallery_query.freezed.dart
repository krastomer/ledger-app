// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GalleryQuery {

/// Empty means the whole library.
 Set<String> get albumIds; GalleryLookBack get lookBack;
/// Create a copy of GalleryQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GalleryQueryCopyWith<GalleryQuery> get copyWith => _$GalleryQueryCopyWithImpl<GalleryQuery>(this as GalleryQuery, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GalleryQuery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GalleryQuery&&const DeepCollectionEquality().equals(other.albumIds, _this.albumIds)&&(identical(other.lookBack, _this.lookBack) || other.lookBack == _this.lookBack));
}


@override
int get hashCode {
  final _this = this as GalleryQuery;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.albumIds),_this.lookBack);
}

@override
String toString() {
  final _this = this as GalleryQuery;
  return 'GalleryQuery(albumIds: ${_this.albumIds}, lookBack: ${_this.lookBack})';
}


}

/// @nodoc
abstract mixin class $GalleryQueryCopyWith<$Res>  {
  factory $GalleryQueryCopyWith(GalleryQuery value, $Res Function(GalleryQuery) _then) = _$GalleryQueryCopyWithImpl;
@useResult
$Res call({
 Set<String> albumIds, GalleryLookBack lookBack
});




}
/// @nodoc
class _$GalleryQueryCopyWithImpl<$Res>
    implements $GalleryQueryCopyWith<$Res> {
  _$GalleryQueryCopyWithImpl(this._self, this._then);

  final GalleryQuery _self;
  final $Res Function(GalleryQuery) _then;

/// Create a copy of GalleryQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? albumIds = null,Object? lookBack = null,}) {
  return _then(GalleryQuery(
albumIds: null == albumIds ? _self.albumIds : albumIds // ignore: cast_nullable_to_non_nullable
as Set<String>,lookBack: null == lookBack ? _self.lookBack : lookBack // ignore: cast_nullable_to_non_nullable
as GalleryLookBack,
  ));
}

}


/// Adds pattern-matching-related methods to [GalleryQuery].
extension GalleryQueryPatterns on GalleryQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GalleryQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GalleryQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GalleryQuery value)  $default,){
final _that = this;
switch (_that) {
case _GalleryQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GalleryQuery value)?  $default,){
final _that = this;
switch (_that) {
case _GalleryQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<String> albumIds,  GalleryLookBack lookBack)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GalleryQuery() when $default != null:
return $default(_that.albumIds,_that.lookBack);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<String> albumIds,  GalleryLookBack lookBack)  $default,) {final _that = this;
switch (_that) {
case _GalleryQuery():
return $default(_that.albumIds,_that.lookBack);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<String> albumIds,  GalleryLookBack lookBack)?  $default,) {final _that = this;
switch (_that) {
case _GalleryQuery() when $default != null:
return $default(_that.albumIds,_that.lookBack);case _:
  return null;

}
}

}

/// @nodoc


class _GalleryQuery implements GalleryQuery {
  const _GalleryQuery({ Set<String> albumIds = const {}, this.lookBack = GalleryLookBack.days90}): _albumIds = albumIds;
  

/// Empty means the whole library.
 final  Set<String> _albumIds;
/// Empty means the whole library.
@override@JsonKey() Set<String> get albumIds {
  if (_albumIds is EqualUnmodifiableSetView) return _albumIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_albumIds);
}

@override@JsonKey() final  GalleryLookBack lookBack;

/// Create a copy of GalleryQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GalleryQueryCopyWith<_GalleryQuery> get copyWith => __$GalleryQueryCopyWithImpl<_GalleryQuery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GalleryQuery&&const DeepCollectionEquality().equals(other.albumIds, _albumIds)&&(identical(other.lookBack, lookBack) || other.lookBack == lookBack));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_albumIds),lookBack);
}

@override
String toString() {
    return 'GalleryQuery(albumIds: $albumIds, lookBack: $lookBack)';
}


}

/// @nodoc
abstract mixin class _$GalleryQueryCopyWith<$Res> implements $GalleryQueryCopyWith<$Res> {
  factory _$GalleryQueryCopyWith(_GalleryQuery value, $Res Function(_GalleryQuery) _then) = __$GalleryQueryCopyWithImpl;
@override @useResult
$Res call({
 Set<String> albumIds, GalleryLookBack lookBack
});




}
/// @nodoc
class __$GalleryQueryCopyWithImpl<$Res>
    implements _$GalleryQueryCopyWith<$Res> {
  __$GalleryQueryCopyWithImpl(this._self, this._then);

  final _GalleryQuery _self;
  final $Res Function(_GalleryQuery) _then;

/// Create a copy of GalleryQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? albumIds = null,Object? lookBack = null,}) {
  return _then(_GalleryQuery(
albumIds: null == albumIds ? _self._albumIds : albumIds // ignore: cast_nullable_to_non_nullable
as Set<String>,lookBack: null == lookBack ? _self.lookBack : lookBack // ignore: cast_nullable_to_non_nullable
as GalleryLookBack,
  ));
}


}

// dart format on

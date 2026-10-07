// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InboxState {

 InboxStatus get status;/// Null until the first load.
 List<ReviewItem>? get items;/// Items handled this session, shown greyed out under the open ones.
 List<ReviewItem> get resolved;/// Suspected duplicates the user chose to keep.
 Set<String> get kept;/// Slip images just picked; the view opens the review with them.
 List<String>? get picked; InboxError? get error;
/// Create a copy of InboxState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InboxStateCopyWith<InboxState> get copyWith => _$InboxStateCopyWithImpl<InboxState>(this as InboxState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InboxState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InboxState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.items, _this.items)&&const DeepCollectionEquality().equals(other.resolved, _this.resolved)&&const DeepCollectionEquality().equals(other.kept, _this.kept)&&const DeepCollectionEquality().equals(other.picked, _this.picked)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as InboxState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.items),const DeepCollectionEquality().hash(_this.resolved),const DeepCollectionEquality().hash(_this.kept),const DeepCollectionEquality().hash(_this.picked),_this.error);
}

@override
String toString() {
  final _this = this as InboxState;
  return 'InboxState(status: ${_this.status}, items: ${_this.items}, resolved: ${_this.resolved}, kept: ${_this.kept}, picked: ${_this.picked}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $InboxStateCopyWith<$Res>  {
  factory $InboxStateCopyWith(InboxState value, $Res Function(InboxState) _then) = _$InboxStateCopyWithImpl;
@useResult
$Res call({
 InboxStatus status, List<ReviewItem>? items, List<ReviewItem> resolved, Set<String> kept, List<String>? picked, InboxError? error
});




}
/// @nodoc
class _$InboxStateCopyWithImpl<$Res>
    implements $InboxStateCopyWith<$Res> {
  _$InboxStateCopyWithImpl(this._self, this._then);

  final InboxState _self;
  final $Res Function(InboxState) _then;

/// Create a copy of InboxState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = freezed,Object? resolved = null,Object? kept = null,Object? picked = freezed,Object? error = freezed,}) {
  return _then(InboxState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InboxStatus,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ReviewItem>?,resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as List<ReviewItem>,kept: null == kept ? _self.kept : kept // ignore: cast_nullable_to_non_nullable
as Set<String>,picked: freezed == picked ? _self.picked : picked // ignore: cast_nullable_to_non_nullable
as List<String>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as InboxError?,
  ));
}

}


/// Adds pattern-matching-related methods to [InboxState].
extension InboxStatePatterns on InboxState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InboxState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InboxState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InboxState value)  $default,){
final _that = this;
switch (_that) {
case _InboxState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InboxState value)?  $default,){
final _that = this;
switch (_that) {
case _InboxState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InboxStatus status,  List<ReviewItem>? items,  List<ReviewItem> resolved,  Set<String> kept,  List<String>? picked,  InboxError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InboxState() when $default != null:
return $default(_that.status,_that.items,_that.resolved,_that.kept,_that.picked,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InboxStatus status,  List<ReviewItem>? items,  List<ReviewItem> resolved,  Set<String> kept,  List<String>? picked,  InboxError? error)  $default,) {final _that = this;
switch (_that) {
case _InboxState():
return $default(_that.status,_that.items,_that.resolved,_that.kept,_that.picked,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InboxStatus status,  List<ReviewItem>? items,  List<ReviewItem> resolved,  Set<String> kept,  List<String>? picked,  InboxError? error)?  $default,) {final _that = this;
switch (_that) {
case _InboxState() when $default != null:
return $default(_that.status,_that.items,_that.resolved,_that.kept,_that.picked,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _InboxState extends InboxState {
  const _InboxState({this.status = InboxStatus.initial,  List<ReviewItem>? items,  List<ReviewItem> resolved = const [],  Set<String> kept = const {},  List<String>? picked, this.error}): _items = items,_resolved = resolved,_kept = kept,_picked = picked,super._();
  

@override@JsonKey() final  InboxStatus status;
/// Null until the first load.
 final  List<ReviewItem>? _items;
/// Null until the first load.
@override List<ReviewItem>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Items handled this session, shown greyed out under the open ones.
 final  List<ReviewItem> _resolved;
/// Items handled this session, shown greyed out under the open ones.
@override@JsonKey() List<ReviewItem> get resolved {
  if (_resolved is EqualUnmodifiableListView) return _resolved;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resolved);
}

/// Suspected duplicates the user chose to keep.
 final  Set<String> _kept;
/// Suspected duplicates the user chose to keep.
@override@JsonKey() Set<String> get kept {
  if (_kept is EqualUnmodifiableSetView) return _kept;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_kept);
}

/// Slip images just picked; the view opens the review with them.
 final  List<String>? _picked;
/// Slip images just picked; the view opens the review with them.
@override List<String>? get picked {
  final value = _picked;
  if (value == null) return null;
  if (_picked is EqualUnmodifiableListView) return _picked;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  InboxError? error;

/// Create a copy of InboxState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InboxStateCopyWith<_InboxState> get copyWith => __$InboxStateCopyWithImpl<_InboxState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InboxState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, _items)&&const DeepCollectionEquality().equals(other.resolved, _resolved)&&const DeepCollectionEquality().equals(other.kept, _kept)&&const DeepCollectionEquality().equals(other.picked, _picked)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_resolved),const DeepCollectionEquality().hash(_kept),const DeepCollectionEquality().hash(_picked),error);
}

@override
String toString() {
    return 'InboxState(status: $status, items: $items, resolved: $resolved, kept: $kept, picked: $picked, error: $error)';
}


}

/// @nodoc
abstract mixin class _$InboxStateCopyWith<$Res> implements $InboxStateCopyWith<$Res> {
  factory _$InboxStateCopyWith(_InboxState value, $Res Function(_InboxState) _then) = __$InboxStateCopyWithImpl;
@override @useResult
$Res call({
 InboxStatus status, List<ReviewItem>? items, List<ReviewItem> resolved, Set<String> kept, List<String>? picked, InboxError? error
});




}
/// @nodoc
class __$InboxStateCopyWithImpl<$Res>
    implements _$InboxStateCopyWith<$Res> {
  __$InboxStateCopyWithImpl(this._self, this._then);

  final _InboxState _self;
  final $Res Function(_InboxState) _then;

/// Create a copy of InboxState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = freezed,Object? resolved = null,Object? kept = null,Object? picked = freezed,Object? error = freezed,}) {
  return _then(_InboxState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InboxStatus,items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ReviewItem>?,resolved: null == resolved ? _self._resolved : resolved // ignore: cast_nullable_to_non_nullable
as List<ReviewItem>,kept: null == kept ? _self._kept : kept // ignore: cast_nullable_to_non_nullable
as Set<String>,picked: freezed == picked ? _self._picked : picked // ignore: cast_nullable_to_non_nullable
as List<String>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as InboxError?,
  ));
}


}

// dart format on

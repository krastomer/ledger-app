// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'found_slip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FoundSlip {

 SlipDraft get draft;
/// Create a copy of FoundSlip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoundSlipCopyWith<FoundSlip> get copyWith => _$FoundSlipCopyWithImpl<FoundSlip>(this as FoundSlip, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FoundSlip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoundSlip&&(identical(other.draft, _this.draft) || other.draft == _this.draft));
}


@override
int get hashCode {
  final _this = this as FoundSlip;
  return Object.hash(runtimeType,_this.draft);
}

@override
String toString() {
  final _this = this as FoundSlip;
  return 'FoundSlip(draft: ${_this.draft})';
}


}

/// @nodoc
abstract mixin class $FoundSlipCopyWith<$Res>  {
  factory $FoundSlipCopyWith(FoundSlip value, $Res Function(FoundSlip) _then) = _$FoundSlipCopyWithImpl;
@useResult
$Res call({
 SlipDraft draft
});


$SlipDraftCopyWith<$Res> get draft;

}
/// @nodoc
class _$FoundSlipCopyWithImpl<$Res>
    implements $FoundSlipCopyWith<$Res> {
  _$FoundSlipCopyWithImpl(this._self, this._then);

  final FoundSlip _self;
  final $Res Function(FoundSlip) _then;

/// Create a copy of FoundSlip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draft = null,}) {
  return _then(FoundSlip(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as SlipDraft,
  ));
}
/// Create a copy of FoundSlip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlipDraftCopyWith<$Res> get draft {
  
  return $SlipDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [FoundSlip].
extension FoundSlipPatterns on FoundSlip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoundSlip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoundSlip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoundSlip value)  $default,){
final _that = this;
switch (_that) {
case _FoundSlip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoundSlip value)?  $default,){
final _that = this;
switch (_that) {
case _FoundSlip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SlipDraft draft)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoundSlip() when $default != null:
return $default(_that.draft);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SlipDraft draft)  $default,) {final _that = this;
switch (_that) {
case _FoundSlip():
return $default(_that.draft);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SlipDraft draft)?  $default,) {final _that = this;
switch (_that) {
case _FoundSlip() when $default != null:
return $default(_that.draft);case _:
  return null;

}
}

}

/// @nodoc


class _FoundSlip extends FoundSlip {
  const _FoundSlip({required this.draft}): super._();
  

@override final  SlipDraft draft;

/// Create a copy of FoundSlip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoundSlipCopyWith<_FoundSlip> get copyWith => __$FoundSlipCopyWithImpl<_FoundSlip>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoundSlip&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode {
    return Object.hash(runtimeType,draft);
}

@override
String toString() {
    return 'FoundSlip(draft: $draft)';
}


}

/// @nodoc
abstract mixin class _$FoundSlipCopyWith<$Res> implements $FoundSlipCopyWith<$Res> {
  factory _$FoundSlipCopyWith(_FoundSlip value, $Res Function(_FoundSlip) _then) = __$FoundSlipCopyWithImpl;
@override @useResult
$Res call({
 SlipDraft draft
});


@override $SlipDraftCopyWith<$Res> get draft;

}
/// @nodoc
class __$FoundSlipCopyWithImpl<$Res>
    implements _$FoundSlipCopyWith<$Res> {
  __$FoundSlipCopyWithImpl(this._self, this._then);

  final _FoundSlip _self;
  final $Res Function(_FoundSlip) _then;

/// Create a copy of FoundSlip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draft = null,}) {
  return _then(_FoundSlip(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as SlipDraft,
  ));
}

/// Create a copy of FoundSlip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlipDraftCopyWith<$Res> get draft {
  
  return $SlipDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on

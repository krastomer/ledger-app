// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Posting {

 String get account; Money get amount;
/// Create a copy of Posting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostingCopyWith<Posting> get copyWith => _$PostingCopyWithImpl<Posting>(this as Posting, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Posting;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Posting&&(identical(other.account, _this.account) || other.account == _this.account)&&(identical(other.amount, _this.amount) || other.amount == _this.amount));
}


@override
int get hashCode {
  final _this = this as Posting;
  return Object.hash(runtimeType,_this.account,_this.amount);
}

@override
String toString() {
  final _this = this as Posting;
  return 'Posting(account: ${_this.account}, amount: ${_this.amount})';
}


}

/// @nodoc
abstract mixin class $PostingCopyWith<$Res>  {
  factory $PostingCopyWith(Posting value, $Res Function(Posting) _then) = _$PostingCopyWithImpl;
@useResult
$Res call({
 String account, Money amount
});




}
/// @nodoc
class _$PostingCopyWithImpl<$Res>
    implements $PostingCopyWith<$Res> {
  _$PostingCopyWithImpl(this._self, this._then);

  final Posting _self;
  final $Res Function(Posting) _then;

/// Create a copy of Posting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? amount = null,}) {
  return _then(Posting(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [Posting].
extension PostingPatterns on Posting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Posting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Posting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Posting value)  $default,){
final _that = this;
switch (_that) {
case _Posting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Posting value)?  $default,){
final _that = this;
switch (_that) {
case _Posting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String account,  Money amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Posting() when $default != null:
return $default(_that.account,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String account,  Money amount)  $default,) {final _that = this;
switch (_that) {
case _Posting():
return $default(_that.account,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String account,  Money amount)?  $default,) {final _that = this;
switch (_that) {
case _Posting() when $default != null:
return $default(_that.account,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _Posting extends Posting {
  const _Posting({required this.account, required this.amount}): super._();
  

@override final  String account;
@override final  Money amount;

/// Create a copy of Posting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostingCopyWith<_Posting> get copyWith => __$PostingCopyWithImpl<_Posting>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Posting&&(identical(other.account, account) || other.account == account)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,account,amount);
}

@override
String toString() {
    return 'Posting(account: $account, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$PostingCopyWith<$Res> implements $PostingCopyWith<$Res> {
  factory _$PostingCopyWith(_Posting value, $Res Function(_Posting) _then) = __$PostingCopyWithImpl;
@override @useResult
$Res call({
 String account, Money amount
});




}
/// @nodoc
class __$PostingCopyWithImpl<$Res>
    implements _$PostingCopyWith<$Res> {
  __$PostingCopyWithImpl(this._self, this._then);

  final _Posting _self;
  final $Res Function(_Posting) _then;

/// Create a copy of Posting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? amount = null,}) {
  return _then(_Posting(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

// dart format on

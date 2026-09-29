// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_total.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryTotal {

 String get account; String get name; Money get amount;/// Share of the period's total in tenths of a percent (386 = 38.6%).
 int get sharePerMille;
/// Create a copy of CategoryTotal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryTotalCopyWith<CategoryTotal> get copyWith => _$CategoryTotalCopyWithImpl<CategoryTotal>(this as CategoryTotal, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryTotal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryTotal&&(identical(other.account, _this.account) || other.account == _this.account)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.sharePerMille, _this.sharePerMille) || other.sharePerMille == _this.sharePerMille));
}


@override
int get hashCode {
  final _this = this as CategoryTotal;
  return Object.hash(runtimeType,_this.account,_this.name,_this.amount,_this.sharePerMille);
}

@override
String toString() {
  final _this = this as CategoryTotal;
  return 'CategoryTotal(account: ${_this.account}, name: ${_this.name}, amount: ${_this.amount}, sharePerMille: ${_this.sharePerMille})';
}


}

/// @nodoc
abstract mixin class $CategoryTotalCopyWith<$Res>  {
  factory $CategoryTotalCopyWith(CategoryTotal value, $Res Function(CategoryTotal) _then) = _$CategoryTotalCopyWithImpl;
@useResult
$Res call({
 String account, String name, Money amount, int sharePerMille
});




}
/// @nodoc
class _$CategoryTotalCopyWithImpl<$Res>
    implements $CategoryTotalCopyWith<$Res> {
  _$CategoryTotalCopyWithImpl(this._self, this._then);

  final CategoryTotal _self;
  final $Res Function(CategoryTotal) _then;

/// Create a copy of CategoryTotal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? name = null,Object? amount = null,Object? sharePerMille = null,}) {
  return _then(CategoryTotal(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,sharePerMille: null == sharePerMille ? _self.sharePerMille : sharePerMille // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryTotal].
extension CategoryTotalPatterns on CategoryTotal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryTotal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryTotal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryTotal value)  $default,){
final _that = this;
switch (_that) {
case _CategoryTotal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryTotal value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryTotal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String account,  String name,  Money amount,  int sharePerMille)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryTotal() when $default != null:
return $default(_that.account,_that.name,_that.amount,_that.sharePerMille);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String account,  String name,  Money amount,  int sharePerMille)  $default,) {final _that = this;
switch (_that) {
case _CategoryTotal():
return $default(_that.account,_that.name,_that.amount,_that.sharePerMille);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String account,  String name,  Money amount,  int sharePerMille)?  $default,) {final _that = this;
switch (_that) {
case _CategoryTotal() when $default != null:
return $default(_that.account,_that.name,_that.amount,_that.sharePerMille);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryTotal implements CategoryTotal {
  const _CategoryTotal({required this.account, required this.name, required this.amount, required this.sharePerMille});
  

@override final  String account;
@override final  String name;
@override final  Money amount;
/// Share of the period's total in tenths of a percent (386 = 38.6%).
@override final  int sharePerMille;

/// Create a copy of CategoryTotal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryTotalCopyWith<_CategoryTotal> get copyWith => __$CategoryTotalCopyWithImpl<_CategoryTotal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryTotal&&(identical(other.account, account) || other.account == account)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.sharePerMille, sharePerMille) || other.sharePerMille == sharePerMille));
}


@override
int get hashCode {
    return Object.hash(runtimeType,account,name,amount,sharePerMille);
}

@override
String toString() {
    return 'CategoryTotal(account: $account, name: $name, amount: $amount, sharePerMille: $sharePerMille)';
}


}

/// @nodoc
abstract mixin class _$CategoryTotalCopyWith<$Res> implements $CategoryTotalCopyWith<$Res> {
  factory _$CategoryTotalCopyWith(_CategoryTotal value, $Res Function(_CategoryTotal) _then) = __$CategoryTotalCopyWithImpl;
@override @useResult
$Res call({
 String account, String name, Money amount, int sharePerMille
});




}
/// @nodoc
class __$CategoryTotalCopyWithImpl<$Res>
    implements _$CategoryTotalCopyWith<$Res> {
  __$CategoryTotalCopyWithImpl(this._self, this._then);

  final _CategoryTotal _self;
  final $Res Function(_CategoryTotal) _then;

/// Create a copy of CategoryTotal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? name = null,Object? amount = null,Object? sharePerMille = null,}) {
  return _then(_CategoryTotal(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,sharePerMille: null == sharePerMille ? _self.sharePerMille : sharePerMille // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

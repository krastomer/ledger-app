// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryRule {

 RuleField get field; String get pattern; String get account;
/// Create a copy of CategoryRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryRuleCopyWith<CategoryRule> get copyWith => _$CategoryRuleCopyWithImpl<CategoryRule>(this as CategoryRule, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryRule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryRule&&(identical(other.field, _this.field) || other.field == _this.field)&&(identical(other.pattern, _this.pattern) || other.pattern == _this.pattern)&&(identical(other.account, _this.account) || other.account == _this.account));
}


@override
int get hashCode {
  final _this = this as CategoryRule;
  return Object.hash(runtimeType,_this.field,_this.pattern,_this.account);
}

@override
String toString() {
  final _this = this as CategoryRule;
  return 'CategoryRule(field: ${_this.field}, pattern: ${_this.pattern}, account: ${_this.account})';
}


}

/// @nodoc
abstract mixin class $CategoryRuleCopyWith<$Res>  {
  factory $CategoryRuleCopyWith(CategoryRule value, $Res Function(CategoryRule) _then) = _$CategoryRuleCopyWithImpl;
@useResult
$Res call({
 RuleField field, String pattern, String account
});




}
/// @nodoc
class _$CategoryRuleCopyWithImpl<$Res>
    implements $CategoryRuleCopyWith<$Res> {
  _$CategoryRuleCopyWithImpl(this._self, this._then);

  final CategoryRule _self;
  final $Res Function(CategoryRule) _then;

/// Create a copy of CategoryRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = null,Object? pattern = null,Object? account = null,}) {
  return _then(CategoryRule(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as RuleField,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryRule].
extension CategoryRulePatterns on CategoryRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryRule value)  $default,){
final _that = this;
switch (_that) {
case _CategoryRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryRule value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RuleField field,  String pattern,  String account)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryRule() when $default != null:
return $default(_that.field,_that.pattern,_that.account);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RuleField field,  String pattern,  String account)  $default,) {final _that = this;
switch (_that) {
case _CategoryRule():
return $default(_that.field,_that.pattern,_that.account);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RuleField field,  String pattern,  String account)?  $default,) {final _that = this;
switch (_that) {
case _CategoryRule() when $default != null:
return $default(_that.field,_that.pattern,_that.account);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryRule implements CategoryRule {
  const _CategoryRule({required this.field, required this.pattern, required this.account});
  

@override final  RuleField field;
@override final  String pattern;
@override final  String account;

/// Create a copy of CategoryRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryRuleCopyWith<_CategoryRule> get copyWith => __$CategoryRuleCopyWithImpl<_CategoryRule>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryRule&&(identical(other.field, field) || other.field == field)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode {
    return Object.hash(runtimeType,field,pattern,account);
}

@override
String toString() {
    return 'CategoryRule(field: $field, pattern: $pattern, account: $account)';
}


}

/// @nodoc
abstract mixin class _$CategoryRuleCopyWith<$Res> implements $CategoryRuleCopyWith<$Res> {
  factory _$CategoryRuleCopyWith(_CategoryRule value, $Res Function(_CategoryRule) _then) = __$CategoryRuleCopyWithImpl;
@override @useResult
$Res call({
 RuleField field, String pattern, String account
});




}
/// @nodoc
class __$CategoryRuleCopyWithImpl<$Res>
    implements _$CategoryRuleCopyWith<$Res> {
  __$CategoryRuleCopyWithImpl(this._self, this._then);

  final _CategoryRule _self;
  final $Res Function(_CategoryRule) _then;

/// Create a copy of CategoryRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = null,Object? pattern = null,Object? account = null,}) {
  return _then(_CategoryRule(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as RuleField,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

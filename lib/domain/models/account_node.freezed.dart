// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountNode {

 String get account; String get name;/// Own postings plus everything below.
 Money get amount; Money get ownAmount; int get ownEntryCount; List<AccountNode> get children;
/// Create a copy of AccountNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountNodeCopyWith<AccountNode> get copyWith => _$AccountNodeCopyWithImpl<AccountNode>(this as AccountNode, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountNode;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountNode&&(identical(other.account, _this.account) || other.account == _this.account)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.ownAmount, _this.ownAmount) || other.ownAmount == _this.ownAmount)&&(identical(other.ownEntryCount, _this.ownEntryCount) || other.ownEntryCount == _this.ownEntryCount)&&const DeepCollectionEquality().equals(other.children, _this.children));
}


@override
int get hashCode {
  final _this = this as AccountNode;
  return Object.hash(runtimeType,_this.account,_this.name,_this.amount,_this.ownAmount,_this.ownEntryCount,const DeepCollectionEquality().hash(_this.children));
}

@override
String toString() {
  final _this = this as AccountNode;
  return 'AccountNode(account: ${_this.account}, name: ${_this.name}, amount: ${_this.amount}, ownAmount: ${_this.ownAmount}, ownEntryCount: ${_this.ownEntryCount}, children: ${_this.children})';
}


}

/// @nodoc
abstract mixin class $AccountNodeCopyWith<$Res>  {
  factory $AccountNodeCopyWith(AccountNode value, $Res Function(AccountNode) _then) = _$AccountNodeCopyWithImpl;
@useResult
$Res call({
 String account, String name, Money amount, Money ownAmount, int ownEntryCount, List<AccountNode> children
});




}
/// @nodoc
class _$AccountNodeCopyWithImpl<$Res>
    implements $AccountNodeCopyWith<$Res> {
  _$AccountNodeCopyWithImpl(this._self, this._then);

  final AccountNode _self;
  final $Res Function(AccountNode) _then;

/// Create a copy of AccountNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? name = null,Object? amount = null,Object? ownAmount = null,Object? ownEntryCount = null,Object? children = null,}) {
  return _then(AccountNode(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,ownAmount: null == ownAmount ? _self.ownAmount : ownAmount // ignore: cast_nullable_to_non_nullable
as Money,ownEntryCount: null == ownEntryCount ? _self.ownEntryCount : ownEntryCount // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<AccountNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountNode].
extension AccountNodePatterns on AccountNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountNode value)  $default,){
final _that = this;
switch (_that) {
case _AccountNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountNode value)?  $default,){
final _that = this;
switch (_that) {
case _AccountNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String account,  String name,  Money amount,  Money ownAmount,  int ownEntryCount,  List<AccountNode> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountNode() when $default != null:
return $default(_that.account,_that.name,_that.amount,_that.ownAmount,_that.ownEntryCount,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String account,  String name,  Money amount,  Money ownAmount,  int ownEntryCount,  List<AccountNode> children)  $default,) {final _that = this;
switch (_that) {
case _AccountNode():
return $default(_that.account,_that.name,_that.amount,_that.ownAmount,_that.ownEntryCount,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String account,  String name,  Money amount,  Money ownAmount,  int ownEntryCount,  List<AccountNode> children)?  $default,) {final _that = this;
switch (_that) {
case _AccountNode() when $default != null:
return $default(_that.account,_that.name,_that.amount,_that.ownAmount,_that.ownEntryCount,_that.children);case _:
  return null;

}
}

}

/// @nodoc


class _AccountNode extends AccountNode {
  const _AccountNode({required this.account, required this.name, required this.amount, required this.ownAmount, required this.ownEntryCount, required  List<AccountNode> children}): _children = children,super._();
  

@override final  String account;
@override final  String name;
/// Own postings plus everything below.
@override final  Money amount;
@override final  Money ownAmount;
@override final  int ownEntryCount;
 final  List<AccountNode> _children;
@override List<AccountNode> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of AccountNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountNodeCopyWith<_AccountNode> get copyWith => __$AccountNodeCopyWithImpl<_AccountNode>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountNode&&(identical(other.account, account) || other.account == account)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.ownAmount, ownAmount) || other.ownAmount == ownAmount)&&(identical(other.ownEntryCount, ownEntryCount) || other.ownEntryCount == ownEntryCount)&&const DeepCollectionEquality().equals(other.children, _children));
}


@override
int get hashCode {
    return Object.hash(runtimeType,account,name,amount,ownAmount,ownEntryCount,const DeepCollectionEquality().hash(_children));
}

@override
String toString() {
    return 'AccountNode(account: $account, name: $name, amount: $amount, ownAmount: $ownAmount, ownEntryCount: $ownEntryCount, children: $children)';
}


}

/// @nodoc
abstract mixin class _$AccountNodeCopyWith<$Res> implements $AccountNodeCopyWith<$Res> {
  factory _$AccountNodeCopyWith(_AccountNode value, $Res Function(_AccountNode) _then) = __$AccountNodeCopyWithImpl;
@override @useResult
$Res call({
 String account, String name, Money amount, Money ownAmount, int ownEntryCount, List<AccountNode> children
});




}
/// @nodoc
class __$AccountNodeCopyWithImpl<$Res>
    implements _$AccountNodeCopyWith<$Res> {
  __$AccountNodeCopyWithImpl(this._self, this._then);

  final _AccountNode _self;
  final $Res Function(_AccountNode) _then;

/// Create a copy of AccountNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? name = null,Object? amount = null,Object? ownAmount = null,Object? ownEntryCount = null,Object? children = null,}) {
  return _then(_AccountNode(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,ownAmount: null == ownAmount ? _self.ownAmount : ownAmount // ignore: cast_nullable_to_non_nullable
as Money,ownEntryCount: null == ownEntryCount ? _self.ownEntryCount : ownEntryCount // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<AccountNode>,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allocation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Allocation {

/// Null for the postings made directly on the parent account.
 String? get account; String get name; Money get amount;/// Share of the parent's total in tenths of a percent.
 int get perMille; int get entryCount; int get childCount;
/// Create a copy of Allocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllocationCopyWith<Allocation> get copyWith => _$AllocationCopyWithImpl<Allocation>(this as Allocation, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Allocation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Allocation&&(identical(other.account, _this.account) || other.account == _this.account)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.perMille, _this.perMille) || other.perMille == _this.perMille)&&(identical(other.entryCount, _this.entryCount) || other.entryCount == _this.entryCount)&&(identical(other.childCount, _this.childCount) || other.childCount == _this.childCount));
}


@override
int get hashCode {
  final _this = this as Allocation;
  return Object.hash(runtimeType,_this.account,_this.name,_this.amount,_this.perMille,_this.entryCount,_this.childCount);
}

@override
String toString() {
  final _this = this as Allocation;
  return 'Allocation(account: ${_this.account}, name: ${_this.name}, amount: ${_this.amount}, perMille: ${_this.perMille}, entryCount: ${_this.entryCount}, childCount: ${_this.childCount})';
}


}

/// @nodoc
abstract mixin class $AllocationCopyWith<$Res>  {
  factory $AllocationCopyWith(Allocation value, $Res Function(Allocation) _then) = _$AllocationCopyWithImpl;
@useResult
$Res call({
 String? account, String name, Money amount, int perMille, int entryCount, int childCount
});




}
/// @nodoc
class _$AllocationCopyWithImpl<$Res>
    implements $AllocationCopyWith<$Res> {
  _$AllocationCopyWithImpl(this._self, this._then);

  final Allocation _self;
  final $Res Function(Allocation) _then;

/// Create a copy of Allocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = freezed,Object? name = null,Object? amount = null,Object? perMille = null,Object? entryCount = null,Object? childCount = null,}) {
  return _then(Allocation(
account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,perMille: null == perMille ? _self.perMille : perMille // ignore: cast_nullable_to_non_nullable
as int,entryCount: null == entryCount ? _self.entryCount : entryCount // ignore: cast_nullable_to_non_nullable
as int,childCount: null == childCount ? _self.childCount : childCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Allocation].
extension AllocationPatterns on Allocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Allocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Allocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Allocation value)  $default,){
final _that = this;
switch (_that) {
case _Allocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Allocation value)?  $default,){
final _that = this;
switch (_that) {
case _Allocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? account,  String name,  Money amount,  int perMille,  int entryCount,  int childCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Allocation() when $default != null:
return $default(_that.account,_that.name,_that.amount,_that.perMille,_that.entryCount,_that.childCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? account,  String name,  Money amount,  int perMille,  int entryCount,  int childCount)  $default,) {final _that = this;
switch (_that) {
case _Allocation():
return $default(_that.account,_that.name,_that.amount,_that.perMille,_that.entryCount,_that.childCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? account,  String name,  Money amount,  int perMille,  int entryCount,  int childCount)?  $default,) {final _that = this;
switch (_that) {
case _Allocation() when $default != null:
return $default(_that.account,_that.name,_that.amount,_that.perMille,_that.entryCount,_that.childCount);case _:
  return null;

}
}

}

/// @nodoc


class _Allocation implements Allocation {
  const _Allocation({required this.account, required this.name, required this.amount, required this.perMille, required this.entryCount, required this.childCount});
  

/// Null for the postings made directly on the parent account.
@override final  String? account;
@override final  String name;
@override final  Money amount;
/// Share of the parent's total in tenths of a percent.
@override final  int perMille;
@override final  int entryCount;
@override final  int childCount;

/// Create a copy of Allocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllocationCopyWith<_Allocation> get copyWith => __$AllocationCopyWithImpl<_Allocation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Allocation&&(identical(other.account, account) || other.account == account)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.perMille, perMille) || other.perMille == perMille)&&(identical(other.entryCount, entryCount) || other.entryCount == entryCount)&&(identical(other.childCount, childCount) || other.childCount == childCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,account,name,amount,perMille,entryCount,childCount);
}

@override
String toString() {
    return 'Allocation(account: $account, name: $name, amount: $amount, perMille: $perMille, entryCount: $entryCount, childCount: $childCount)';
}


}

/// @nodoc
abstract mixin class _$AllocationCopyWith<$Res> implements $AllocationCopyWith<$Res> {
  factory _$AllocationCopyWith(_Allocation value, $Res Function(_Allocation) _then) = __$AllocationCopyWithImpl;
@override @useResult
$Res call({
 String? account, String name, Money amount, int perMille, int entryCount, int childCount
});




}
/// @nodoc
class __$AllocationCopyWithImpl<$Res>
    implements _$AllocationCopyWith<$Res> {
  __$AllocationCopyWithImpl(this._self, this._then);

  final _Allocation _self;
  final $Res Function(_Allocation) _then;

/// Create a copy of Allocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = freezed,Object? name = null,Object? amount = null,Object? perMille = null,Object? entryCount = null,Object? childCount = null,}) {
  return _then(_Allocation(
account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,perMille: null == perMille ? _self.perMille : perMille // ignore: cast_nullable_to_non_nullable
as int,entryCount: null == entryCount ? _self.entryCount : entryCount // ignore: cast_nullable_to_non_nullable
as int,childCount: null == childCount ? _self.childCount : childCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

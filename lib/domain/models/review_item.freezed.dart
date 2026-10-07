// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReviewItem {

 ReviewReason get reason;/// The entry to act on; for a duplicate, the later copy.
 TransactionSummary get transaction;/// For a duplicate, the earlier entry it repeats.
 String? get duplicateOf;/// For an uncategorized entry, the account to replace and the
/// accounts of the same kind it could move to.
 String? get uncategorizedAccount; List<String> get categoryChoices;
/// Create a copy of ReviewItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewItemCopyWith<ReviewItem> get copyWith => _$ReviewItemCopyWithImpl<ReviewItem>(this as ReviewItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReviewItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewItem&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.transaction, _this.transaction) || other.transaction == _this.transaction)&&(identical(other.duplicateOf, _this.duplicateOf) || other.duplicateOf == _this.duplicateOf)&&(identical(other.uncategorizedAccount, _this.uncategorizedAccount) || other.uncategorizedAccount == _this.uncategorizedAccount)&&const DeepCollectionEquality().equals(other.categoryChoices, _this.categoryChoices));
}


@override
int get hashCode {
  final _this = this as ReviewItem;
  return Object.hash(runtimeType,_this.reason,_this.transaction,_this.duplicateOf,_this.uncategorizedAccount,const DeepCollectionEquality().hash(_this.categoryChoices));
}

@override
String toString() {
  final _this = this as ReviewItem;
  return 'ReviewItem(reason: ${_this.reason}, transaction: ${_this.transaction}, duplicateOf: ${_this.duplicateOf}, uncategorizedAccount: ${_this.uncategorizedAccount}, categoryChoices: ${_this.categoryChoices})';
}


}

/// @nodoc
abstract mixin class $ReviewItemCopyWith<$Res>  {
  factory $ReviewItemCopyWith(ReviewItem value, $Res Function(ReviewItem) _then) = _$ReviewItemCopyWithImpl;
@useResult
$Res call({
 ReviewReason reason, TransactionSummary transaction, String? duplicateOf, String? uncategorizedAccount, List<String> categoryChoices
});


$TransactionSummaryCopyWith<$Res> get transaction;

}
/// @nodoc
class _$ReviewItemCopyWithImpl<$Res>
    implements $ReviewItemCopyWith<$Res> {
  _$ReviewItemCopyWithImpl(this._self, this._then);

  final ReviewItem _self;
  final $Res Function(ReviewItem) _then;

/// Create a copy of ReviewItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reason = null,Object? transaction = null,Object? duplicateOf = freezed,Object? uncategorizedAccount = freezed,Object? categoryChoices = null,}) {
  return _then(ReviewItem(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReviewReason,transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TransactionSummary,duplicateOf: freezed == duplicateOf ? _self.duplicateOf : duplicateOf // ignore: cast_nullable_to_non_nullable
as String?,uncategorizedAccount: freezed == uncategorizedAccount ? _self.uncategorizedAccount : uncategorizedAccount // ignore: cast_nullable_to_non_nullable
as String?,categoryChoices: null == categoryChoices ? _self.categoryChoices : categoryChoices // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ReviewItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionSummaryCopyWith<$Res> get transaction {
  
  return $TransactionSummaryCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReviewItem].
extension ReviewItemPatterns on ReviewItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewItem value)  $default,){
final _that = this;
switch (_that) {
case _ReviewItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewItem value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReviewReason reason,  TransactionSummary transaction,  String? duplicateOf,  String? uncategorizedAccount,  List<String> categoryChoices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewItem() when $default != null:
return $default(_that.reason,_that.transaction,_that.duplicateOf,_that.uncategorizedAccount,_that.categoryChoices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReviewReason reason,  TransactionSummary transaction,  String? duplicateOf,  String? uncategorizedAccount,  List<String> categoryChoices)  $default,) {final _that = this;
switch (_that) {
case _ReviewItem():
return $default(_that.reason,_that.transaction,_that.duplicateOf,_that.uncategorizedAccount,_that.categoryChoices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReviewReason reason,  TransactionSummary transaction,  String? duplicateOf,  String? uncategorizedAccount,  List<String> categoryChoices)?  $default,) {final _that = this;
switch (_that) {
case _ReviewItem() when $default != null:
return $default(_that.reason,_that.transaction,_that.duplicateOf,_that.uncategorizedAccount,_that.categoryChoices);case _:
  return null;

}
}

}

/// @nodoc


class _ReviewItem implements ReviewItem {
  const _ReviewItem({required this.reason, required this.transaction, this.duplicateOf, this.uncategorizedAccount,  List<String> categoryChoices = const []}): _categoryChoices = categoryChoices;
  

@override final  ReviewReason reason;
/// The entry to act on; for a duplicate, the later copy.
@override final  TransactionSummary transaction;
/// For a duplicate, the earlier entry it repeats.
@override final  String? duplicateOf;
/// For an uncategorized entry, the account to replace and the
/// accounts of the same kind it could move to.
@override final  String? uncategorizedAccount;
 final  List<String> _categoryChoices;
@override@JsonKey() List<String> get categoryChoices {
  if (_categoryChoices is EqualUnmodifiableListView) return _categoryChoices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryChoices);
}


/// Create a copy of ReviewItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewItemCopyWith<_ReviewItem> get copyWith => __$ReviewItemCopyWithImpl<_ReviewItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewItem&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.duplicateOf, duplicateOf) || other.duplicateOf == duplicateOf)&&(identical(other.uncategorizedAccount, uncategorizedAccount) || other.uncategorizedAccount == uncategorizedAccount)&&const DeepCollectionEquality().equals(other.categoryChoices, _categoryChoices));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reason,transaction,duplicateOf,uncategorizedAccount,const DeepCollectionEquality().hash(_categoryChoices));
}

@override
String toString() {
    return 'ReviewItem(reason: $reason, transaction: $transaction, duplicateOf: $duplicateOf, uncategorizedAccount: $uncategorizedAccount, categoryChoices: $categoryChoices)';
}


}

/// @nodoc
abstract mixin class _$ReviewItemCopyWith<$Res> implements $ReviewItemCopyWith<$Res> {
  factory _$ReviewItemCopyWith(_ReviewItem value, $Res Function(_ReviewItem) _then) = __$ReviewItemCopyWithImpl;
@override @useResult
$Res call({
 ReviewReason reason, TransactionSummary transaction, String? duplicateOf, String? uncategorizedAccount, List<String> categoryChoices
});


@override $TransactionSummaryCopyWith<$Res> get transaction;

}
/// @nodoc
class __$ReviewItemCopyWithImpl<$Res>
    implements _$ReviewItemCopyWith<$Res> {
  __$ReviewItemCopyWithImpl(this._self, this._then);

  final _ReviewItem _self;
  final $Res Function(_ReviewItem) _then;

/// Create a copy of ReviewItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? transaction = null,Object? duplicateOf = freezed,Object? uncategorizedAccount = freezed,Object? categoryChoices = null,}) {
  return _then(_ReviewItem(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReviewReason,transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TransactionSummary,duplicateOf: freezed == duplicateOf ? _self.duplicateOf : duplicateOf // ignore: cast_nullable_to_non_nullable
as String?,uncategorizedAccount: freezed == uncategorizedAccount ? _self.uncategorizedAccount : uncategorizedAccount // ignore: cast_nullable_to_non_nullable
as String?,categoryChoices: null == categoryChoices ? _self._categoryChoices : categoryChoices // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ReviewItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionSummaryCopyWith<$Res> get transaction {
  
  return $TransactionSummaryCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}

// dart format on

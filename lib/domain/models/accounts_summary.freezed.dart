// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accounts_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountSection {

 AccountType get type;/// Root accounts with their balances; income and expenses are this
/// month's totals.
 List<AccountNode> get balance;/// Root accounts with this month's movement.
 List<AccountNode> get monthChange;
/// Create a copy of AccountSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountSectionCopyWith<AccountSection> get copyWith => _$AccountSectionCopyWithImpl<AccountSection>(this as AccountSection, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountSection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountSection&&(identical(other.type, _this.type) || other.type == _this.type)&&const DeepCollectionEquality().equals(other.balance, _this.balance)&&const DeepCollectionEquality().equals(other.monthChange, _this.monthChange));
}


@override
int get hashCode {
  final _this = this as AccountSection;
  return Object.hash(runtimeType,_this.type,const DeepCollectionEquality().hash(_this.balance),const DeepCollectionEquality().hash(_this.monthChange));
}

@override
String toString() {
  final _this = this as AccountSection;
  return 'AccountSection(type: ${_this.type}, balance: ${_this.balance}, monthChange: ${_this.monthChange})';
}


}

/// @nodoc
abstract mixin class $AccountSectionCopyWith<$Res>  {
  factory $AccountSectionCopyWith(AccountSection value, $Res Function(AccountSection) _then) = _$AccountSectionCopyWithImpl;
@useResult
$Res call({
 AccountType type, List<AccountNode> balance, List<AccountNode> monthChange
});




}
/// @nodoc
class _$AccountSectionCopyWithImpl<$Res>
    implements $AccountSectionCopyWith<$Res> {
  _$AccountSectionCopyWithImpl(this._self, this._then);

  final AccountSection _self;
  final $Res Function(AccountSection) _then;

/// Create a copy of AccountSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? balance = null,Object? monthChange = null,}) {
  return _then(AccountSection(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as List<AccountNode>,monthChange: null == monthChange ? _self.monthChange : monthChange // ignore: cast_nullable_to_non_nullable
as List<AccountNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountSection].
extension AccountSectionPatterns on AccountSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountSection value)  $default,){
final _that = this;
switch (_that) {
case _AccountSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountSection value)?  $default,){
final _that = this;
switch (_that) {
case _AccountSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AccountType type,  List<AccountNode> balance,  List<AccountNode> monthChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountSection() when $default != null:
return $default(_that.type,_that.balance,_that.monthChange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AccountType type,  List<AccountNode> balance,  List<AccountNode> monthChange)  $default,) {final _that = this;
switch (_that) {
case _AccountSection():
return $default(_that.type,_that.balance,_that.monthChange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AccountType type,  List<AccountNode> balance,  List<AccountNode> monthChange)?  $default,) {final _that = this;
switch (_that) {
case _AccountSection() when $default != null:
return $default(_that.type,_that.balance,_that.monthChange);case _:
  return null;

}
}

}

/// @nodoc


class _AccountSection extends AccountSection {
  const _AccountSection({required this.type, required  List<AccountNode> balance, required  List<AccountNode> monthChange}): _balance = balance,_monthChange = monthChange,super._();
  

@override final  AccountType type;
/// Root accounts with their balances; income and expenses are this
/// month's totals.
 final  List<AccountNode> _balance;
/// Root accounts with their balances; income and expenses are this
/// month's totals.
@override List<AccountNode> get balance {
  if (_balance is EqualUnmodifiableListView) return _balance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_balance);
}

/// Root accounts with this month's movement.
 final  List<AccountNode> _monthChange;
/// Root accounts with this month's movement.
@override List<AccountNode> get monthChange {
  if (_monthChange is EqualUnmodifiableListView) return _monthChange;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthChange);
}


/// Create a copy of AccountSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountSectionCopyWith<_AccountSection> get copyWith => __$AccountSectionCopyWithImpl<_AccountSection>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountSection&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.balance, _balance)&&const DeepCollectionEquality().equals(other.monthChange, _monthChange));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_balance),const DeepCollectionEquality().hash(_monthChange));
}

@override
String toString() {
    return 'AccountSection(type: $type, balance: $balance, monthChange: $monthChange)';
}


}

/// @nodoc
abstract mixin class _$AccountSectionCopyWith<$Res> implements $AccountSectionCopyWith<$Res> {
  factory _$AccountSectionCopyWith(_AccountSection value, $Res Function(_AccountSection) _then) = __$AccountSectionCopyWithImpl;
@override @useResult
$Res call({
 AccountType type, List<AccountNode> balance, List<AccountNode> monthChange
});




}
/// @nodoc
class __$AccountSectionCopyWithImpl<$Res>
    implements _$AccountSectionCopyWith<$Res> {
  __$AccountSectionCopyWithImpl(this._self, this._then);

  final _AccountSection _self;
  final $Res Function(_AccountSection) _then;

/// Create a copy of AccountSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? balance = null,Object? monthChange = null,}) {
  return _then(_AccountSection(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self._balance : balance // ignore: cast_nullable_to_non_nullable
as List<AccountNode>,monthChange: null == monthChange ? _self._monthChange : monthChange // ignore: cast_nullable_to_non_nullable
as List<AccountNode>,
  ));
}


}

/// @nodoc
mixin _$AccountsSummary {

 DateTime get asOf; Money get netWorth; Money get assets; Money get liabilities; List<AccountSection> get sections;
/// Create a copy of AccountsSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountsSummaryCopyWith<AccountsSummary> get copyWith => _$AccountsSummaryCopyWithImpl<AccountsSummary>(this as AccountsSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountsSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountsSummary&&(identical(other.asOf, _this.asOf) || other.asOf == _this.asOf)&&(identical(other.netWorth, _this.netWorth) || other.netWorth == _this.netWorth)&&(identical(other.assets, _this.assets) || other.assets == _this.assets)&&(identical(other.liabilities, _this.liabilities) || other.liabilities == _this.liabilities)&&const DeepCollectionEquality().equals(other.sections, _this.sections));
}


@override
int get hashCode {
  final _this = this as AccountsSummary;
  return Object.hash(runtimeType,_this.asOf,_this.netWorth,_this.assets,_this.liabilities,const DeepCollectionEquality().hash(_this.sections));
}

@override
String toString() {
  final _this = this as AccountsSummary;
  return 'AccountsSummary(asOf: ${_this.asOf}, netWorth: ${_this.netWorth}, assets: ${_this.assets}, liabilities: ${_this.liabilities}, sections: ${_this.sections})';
}


}

/// @nodoc
abstract mixin class $AccountsSummaryCopyWith<$Res>  {
  factory $AccountsSummaryCopyWith(AccountsSummary value, $Res Function(AccountsSummary) _then) = _$AccountsSummaryCopyWithImpl;
@useResult
$Res call({
 DateTime asOf, Money netWorth, Money assets, Money liabilities, List<AccountSection> sections
});




}
/// @nodoc
class _$AccountsSummaryCopyWithImpl<$Res>
    implements $AccountsSummaryCopyWith<$Res> {
  _$AccountsSummaryCopyWithImpl(this._self, this._then);

  final AccountsSummary _self;
  final $Res Function(AccountsSummary) _then;

/// Create a copy of AccountsSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? asOf = null,Object? netWorth = null,Object? assets = null,Object? liabilities = null,Object? sections = null,}) {
  return _then(AccountsSummary(
asOf: null == asOf ? _self.asOf : asOf // ignore: cast_nullable_to_non_nullable
as DateTime,netWorth: null == netWorth ? _self.netWorth : netWorth // ignore: cast_nullable_to_non_nullable
as Money,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as Money,liabilities: null == liabilities ? _self.liabilities : liabilities // ignore: cast_nullable_to_non_nullable
as Money,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<AccountSection>,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountsSummary].
extension AccountsSummaryPatterns on AccountsSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountsSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountsSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountsSummary value)  $default,){
final _that = this;
switch (_that) {
case _AccountsSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountsSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AccountsSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime asOf,  Money netWorth,  Money assets,  Money liabilities,  List<AccountSection> sections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountsSummary() when $default != null:
return $default(_that.asOf,_that.netWorth,_that.assets,_that.liabilities,_that.sections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime asOf,  Money netWorth,  Money assets,  Money liabilities,  List<AccountSection> sections)  $default,) {final _that = this;
switch (_that) {
case _AccountsSummary():
return $default(_that.asOf,_that.netWorth,_that.assets,_that.liabilities,_that.sections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime asOf,  Money netWorth,  Money assets,  Money liabilities,  List<AccountSection> sections)?  $default,) {final _that = this;
switch (_that) {
case _AccountsSummary() when $default != null:
return $default(_that.asOf,_that.netWorth,_that.assets,_that.liabilities,_that.sections);case _:
  return null;

}
}

}

/// @nodoc


class _AccountsSummary extends AccountsSummary {
  const _AccountsSummary({required this.asOf, required this.netWorth, required this.assets, required this.liabilities, required  List<AccountSection> sections}): _sections = sections,super._();
  

@override final  DateTime asOf;
@override final  Money netWorth;
@override final  Money assets;
@override final  Money liabilities;
 final  List<AccountSection> _sections;
@override List<AccountSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}


/// Create a copy of AccountsSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountsSummaryCopyWith<_AccountsSummary> get copyWith => __$AccountsSummaryCopyWithImpl<_AccountsSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountsSummary&&(identical(other.asOf, asOf) || other.asOf == asOf)&&(identical(other.netWorth, netWorth) || other.netWorth == netWorth)&&(identical(other.assets, assets) || other.assets == assets)&&(identical(other.liabilities, liabilities) || other.liabilities == liabilities)&&const DeepCollectionEquality().equals(other.sections, _sections));
}


@override
int get hashCode {
    return Object.hash(runtimeType,asOf,netWorth,assets,liabilities,const DeepCollectionEquality().hash(_sections));
}

@override
String toString() {
    return 'AccountsSummary(asOf: $asOf, netWorth: $netWorth, assets: $assets, liabilities: $liabilities, sections: $sections)';
}


}

/// @nodoc
abstract mixin class _$AccountsSummaryCopyWith<$Res> implements $AccountsSummaryCopyWith<$Res> {
  factory _$AccountsSummaryCopyWith(_AccountsSummary value, $Res Function(_AccountsSummary) _then) = __$AccountsSummaryCopyWithImpl;
@override @useResult
$Res call({
 DateTime asOf, Money netWorth, Money assets, Money liabilities, List<AccountSection> sections
});




}
/// @nodoc
class __$AccountsSummaryCopyWithImpl<$Res>
    implements _$AccountsSummaryCopyWith<$Res> {
  __$AccountsSummaryCopyWithImpl(this._self, this._then);

  final _AccountsSummary _self;
  final $Res Function(_AccountsSummary) _then;

/// Create a copy of AccountsSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? asOf = null,Object? netWorth = null,Object? assets = null,Object? liabilities = null,Object? sections = null,}) {
  return _then(_AccountsSummary(
asOf: null == asOf ? _self.asOf : asOf // ignore: cast_nullable_to_non_nullable
as DateTime,netWorth: null == netWorth ? _self.netWorth : netWorth // ignore: cast_nullable_to_non_nullable
as Money,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as Money,liabilities: null == liabilities ? _self.liabilities : liabilities // ignore: cast_nullable_to_non_nullable
as Money,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<AccountSection>,
  ));
}


}

// dart format on

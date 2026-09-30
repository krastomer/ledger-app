// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionFilter {

 String get query; bool get pendingOnly; bool get withSlipOnly;
/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionFilterCopyWith<TransactionFilter> get copyWith => _$TransactionFilterCopyWithImpl<TransactionFilter>(this as TransactionFilter, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransactionFilter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionFilter&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.pendingOnly, _this.pendingOnly) || other.pendingOnly == _this.pendingOnly)&&(identical(other.withSlipOnly, _this.withSlipOnly) || other.withSlipOnly == _this.withSlipOnly));
}


@override
int get hashCode {
  final _this = this as TransactionFilter;
  return Object.hash(runtimeType,_this.query,_this.pendingOnly,_this.withSlipOnly);
}

@override
String toString() {
  final _this = this as TransactionFilter;
  return 'TransactionFilter(query: ${_this.query}, pendingOnly: ${_this.pendingOnly}, withSlipOnly: ${_this.withSlipOnly})';
}


}

/// @nodoc
abstract mixin class $TransactionFilterCopyWith<$Res>  {
  factory $TransactionFilterCopyWith(TransactionFilter value, $Res Function(TransactionFilter) _then) = _$TransactionFilterCopyWithImpl;
@useResult
$Res call({
 String query, bool pendingOnly, bool withSlipOnly
});




}
/// @nodoc
class _$TransactionFilterCopyWithImpl<$Res>
    implements $TransactionFilterCopyWith<$Res> {
  _$TransactionFilterCopyWithImpl(this._self, this._then);

  final TransactionFilter _self;
  final $Res Function(TransactionFilter) _then;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? pendingOnly = null,Object? withSlipOnly = null,}) {
  return _then(TransactionFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,pendingOnly: null == pendingOnly ? _self.pendingOnly : pendingOnly // ignore: cast_nullable_to_non_nullable
as bool,withSlipOnly: null == withSlipOnly ? _self.withSlipOnly : withSlipOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionFilter].
extension TransactionFilterPatterns on TransactionFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionFilter value)  $default,){
final _that = this;
switch (_that) {
case _TransactionFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionFilter value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  bool pendingOnly,  bool withSlipOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
return $default(_that.query,_that.pendingOnly,_that.withSlipOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  bool pendingOnly,  bool withSlipOnly)  $default,) {final _that = this;
switch (_that) {
case _TransactionFilter():
return $default(_that.query,_that.pendingOnly,_that.withSlipOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  bool pendingOnly,  bool withSlipOnly)?  $default,) {final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
return $default(_that.query,_that.pendingOnly,_that.withSlipOnly);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionFilter extends TransactionFilter {
  const _TransactionFilter({this.query = '', this.pendingOnly = false, this.withSlipOnly = false}): super._();
  

@override@JsonKey() final  String query;
@override@JsonKey() final  bool pendingOnly;
@override@JsonKey() final  bool withSlipOnly;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionFilterCopyWith<_TransactionFilter> get copyWith => __$TransactionFilterCopyWithImpl<_TransactionFilter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionFilter&&(identical(other.query, query) || other.query == query)&&(identical(other.pendingOnly, pendingOnly) || other.pendingOnly == pendingOnly)&&(identical(other.withSlipOnly, withSlipOnly) || other.withSlipOnly == withSlipOnly));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,pendingOnly,withSlipOnly);
}

@override
String toString() {
    return 'TransactionFilter(query: $query, pendingOnly: $pendingOnly, withSlipOnly: $withSlipOnly)';
}


}

/// @nodoc
abstract mixin class _$TransactionFilterCopyWith<$Res> implements $TransactionFilterCopyWith<$Res> {
  factory _$TransactionFilterCopyWith(_TransactionFilter value, $Res Function(_TransactionFilter) _then) = __$TransactionFilterCopyWithImpl;
@override @useResult
$Res call({
 String query, bool pendingOnly, bool withSlipOnly
});




}
/// @nodoc
class __$TransactionFilterCopyWithImpl<$Res>
    implements _$TransactionFilterCopyWith<$Res> {
  __$TransactionFilterCopyWithImpl(this._self, this._then);

  final _TransactionFilter _self;
  final $Res Function(_TransactionFilter) _then;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? pendingOnly = null,Object? withSlipOnly = null,}) {
  return _then(_TransactionFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,pendingOnly: null == pendingOnly ? _self.pendingOnly : pendingOnly // ignore: cast_nullable_to_non_nullable
as bool,withSlipOnly: null == withSlipOnly ? _self.withSlipOnly : withSlipOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

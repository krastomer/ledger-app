// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rule_issue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RuleIssue {

 int get line; RuleIssueReason get reason;
/// Create a copy of RuleIssue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuleIssueCopyWith<RuleIssue> get copyWith => _$RuleIssueCopyWithImpl<RuleIssue>(this as RuleIssue, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RuleIssue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuleIssue&&(identical(other.line, _this.line) || other.line == _this.line)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}


@override
int get hashCode {
  final _this = this as RuleIssue;
  return Object.hash(runtimeType,_this.line,_this.reason);
}

@override
String toString() {
  final _this = this as RuleIssue;
  return 'RuleIssue(line: ${_this.line}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $RuleIssueCopyWith<$Res>  {
  factory $RuleIssueCopyWith(RuleIssue value, $Res Function(RuleIssue) _then) = _$RuleIssueCopyWithImpl;
@useResult
$Res call({
 int line, RuleIssueReason reason
});




}
/// @nodoc
class _$RuleIssueCopyWithImpl<$Res>
    implements $RuleIssueCopyWith<$Res> {
  _$RuleIssueCopyWithImpl(this._self, this._then);

  final RuleIssue _self;
  final $Res Function(RuleIssue) _then;

/// Create a copy of RuleIssue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line = null,Object? reason = null,}) {
  return _then(RuleIssue(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RuleIssueReason,
  ));
}

}


/// Adds pattern-matching-related methods to [RuleIssue].
extension RuleIssuePatterns on RuleIssue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuleIssue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuleIssue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuleIssue value)  $default,){
final _that = this;
switch (_that) {
case _RuleIssue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuleIssue value)?  $default,){
final _that = this;
switch (_that) {
case _RuleIssue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int line,  RuleIssueReason reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuleIssue() when $default != null:
return $default(_that.line,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int line,  RuleIssueReason reason)  $default,) {final _that = this;
switch (_that) {
case _RuleIssue():
return $default(_that.line,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int line,  RuleIssueReason reason)?  $default,) {final _that = this;
switch (_that) {
case _RuleIssue() when $default != null:
return $default(_that.line,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class _RuleIssue implements RuleIssue {
  const _RuleIssue({required this.line, required this.reason});
  

@override final  int line;
@override final  RuleIssueReason reason;

/// Create a copy of RuleIssue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuleIssueCopyWith<_RuleIssue> get copyWith => __$RuleIssueCopyWithImpl<_RuleIssue>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuleIssue&&(identical(other.line, line) || other.line == line)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,line,reason);
}

@override
String toString() {
    return 'RuleIssue(line: $line, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$RuleIssueCopyWith<$Res> implements $RuleIssueCopyWith<$Res> {
  factory _$RuleIssueCopyWith(_RuleIssue value, $Res Function(_RuleIssue) _then) = __$RuleIssueCopyWithImpl;
@override @useResult
$Res call({
 int line, RuleIssueReason reason
});




}
/// @nodoc
class __$RuleIssueCopyWithImpl<$Res>
    implements _$RuleIssueCopyWith<$Res> {
  __$RuleIssueCopyWithImpl(this._self, this._then);

  final _RuleIssue _self;
  final $Res Function(_RuleIssue) _then;

/// Create a copy of RuleIssue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line = null,Object? reason = null,}) {
  return _then(_RuleIssue(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RuleIssueReason,
  ));
}


}

// dart format on

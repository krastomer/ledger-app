// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rule_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RuleSet {

 String get fileName; String get text; DateTime get loadedAt; List<CategoryRule> get rules; List<RuleIssue> get issues;
/// Create a copy of RuleSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuleSetCopyWith<RuleSet> get copyWith => _$RuleSetCopyWithImpl<RuleSet>(this as RuleSet, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RuleSet;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuleSet&&(identical(other.fileName, _this.fileName) || other.fileName == _this.fileName)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.loadedAt, _this.loadedAt) || other.loadedAt == _this.loadedAt)&&const DeepCollectionEquality().equals(other.rules, _this.rules)&&const DeepCollectionEquality().equals(other.issues, _this.issues));
}


@override
int get hashCode {
  final _this = this as RuleSet;
  return Object.hash(runtimeType,_this.fileName,_this.text,_this.loadedAt,const DeepCollectionEquality().hash(_this.rules),const DeepCollectionEquality().hash(_this.issues));
}

@override
String toString() {
  final _this = this as RuleSet;
  return 'RuleSet(fileName: ${_this.fileName}, text: ${_this.text}, loadedAt: ${_this.loadedAt}, rules: ${_this.rules}, issues: ${_this.issues})';
}


}

/// @nodoc
abstract mixin class $RuleSetCopyWith<$Res>  {
  factory $RuleSetCopyWith(RuleSet value, $Res Function(RuleSet) _then) = _$RuleSetCopyWithImpl;
@useResult
$Res call({
 String fileName, String text, DateTime loadedAt, List<CategoryRule> rules, List<RuleIssue> issues
});




}
/// @nodoc
class _$RuleSetCopyWithImpl<$Res>
    implements $RuleSetCopyWith<$Res> {
  _$RuleSetCopyWithImpl(this._self, this._then);

  final RuleSet _self;
  final $Res Function(RuleSet) _then;

/// Create a copy of RuleSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileName = null,Object? text = null,Object? loadedAt = null,Object? rules = null,Object? issues = null,}) {
  return _then(RuleSet(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,loadedAt: null == loadedAt ? _self.loadedAt : loadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<CategoryRule>,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<RuleIssue>,
  ));
}

}


/// Adds pattern-matching-related methods to [RuleSet].
extension RuleSetPatterns on RuleSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuleSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuleSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuleSet value)  $default,){
final _that = this;
switch (_that) {
case _RuleSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuleSet value)?  $default,){
final _that = this;
switch (_that) {
case _RuleSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileName,  String text,  DateTime loadedAt,  List<CategoryRule> rules,  List<RuleIssue> issues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuleSet() when $default != null:
return $default(_that.fileName,_that.text,_that.loadedAt,_that.rules,_that.issues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileName,  String text,  DateTime loadedAt,  List<CategoryRule> rules,  List<RuleIssue> issues)  $default,) {final _that = this;
switch (_that) {
case _RuleSet():
return $default(_that.fileName,_that.text,_that.loadedAt,_that.rules,_that.issues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileName,  String text,  DateTime loadedAt,  List<CategoryRule> rules,  List<RuleIssue> issues)?  $default,) {final _that = this;
switch (_that) {
case _RuleSet() when $default != null:
return $default(_that.fileName,_that.text,_that.loadedAt,_that.rules,_that.issues);case _:
  return null;

}
}

}

/// @nodoc


class _RuleSet implements RuleSet {
  const _RuleSet({required this.fileName, required this.text, required this.loadedAt, required  List<CategoryRule> rules, required  List<RuleIssue> issues}): _rules = rules,_issues = issues;
  

@override final  String fileName;
@override final  String text;
@override final  DateTime loadedAt;
 final  List<CategoryRule> _rules;
@override List<CategoryRule> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}

 final  List<RuleIssue> _issues;
@override List<RuleIssue> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}


/// Create a copy of RuleSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuleSetCopyWith<_RuleSet> get copyWith => __$RuleSetCopyWithImpl<_RuleSet>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuleSet&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.text, text) || other.text == text)&&(identical(other.loadedAt, loadedAt) || other.loadedAt == loadedAt)&&const DeepCollectionEquality().equals(other.rules, _rules)&&const DeepCollectionEquality().equals(other.issues, _issues));
}


@override
int get hashCode {
    return Object.hash(runtimeType,fileName,text,loadedAt,const DeepCollectionEquality().hash(_rules),const DeepCollectionEquality().hash(_issues));
}

@override
String toString() {
    return 'RuleSet(fileName: $fileName, text: $text, loadedAt: $loadedAt, rules: $rules, issues: $issues)';
}


}

/// @nodoc
abstract mixin class _$RuleSetCopyWith<$Res> implements $RuleSetCopyWith<$Res> {
  factory _$RuleSetCopyWith(_RuleSet value, $Res Function(_RuleSet) _then) = __$RuleSetCopyWithImpl;
@override @useResult
$Res call({
 String fileName, String text, DateTime loadedAt, List<CategoryRule> rules, List<RuleIssue> issues
});




}
/// @nodoc
class __$RuleSetCopyWithImpl<$Res>
    implements _$RuleSetCopyWith<$Res> {
  __$RuleSetCopyWithImpl(this._self, this._then);

  final _RuleSet _self;
  final $Res Function(_RuleSet) _then;

/// Create a copy of RuleSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileName = null,Object? text = null,Object? loadedAt = null,Object? rules = null,Object? issues = null,}) {
  return _then(_RuleSet(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,loadedAt: null == loadedAt ? _self.loadedAt : loadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<CategoryRule>,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<RuleIssue>,
  ));
}


}

// dart format on

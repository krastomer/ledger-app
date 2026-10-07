// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 AppLanguage get language; YearEra get yearEra;/// Start with amounts masked on Home.
 bool get hideOnLaunch; bool get showZeroBalance; bool get keepSlipImages;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.language, _this.language) || other.language == _this.language)&&(identical(other.yearEra, _this.yearEra) || other.yearEra == _this.yearEra)&&(identical(other.hideOnLaunch, _this.hideOnLaunch) || other.hideOnLaunch == _this.hideOnLaunch)&&(identical(other.showZeroBalance, _this.showZeroBalance) || other.showZeroBalance == _this.showZeroBalance)&&(identical(other.keepSlipImages, _this.keepSlipImages) || other.keepSlipImages == _this.keepSlipImages));
}


@override
int get hashCode {
  final _this = this as AppSettings;
  return Object.hash(runtimeType,_this.language,_this.yearEra,_this.hideOnLaunch,_this.showZeroBalance,_this.keepSlipImages);
}

@override
String toString() {
  final _this = this as AppSettings;
  return 'AppSettings(language: ${_this.language}, yearEra: ${_this.yearEra}, hideOnLaunch: ${_this.hideOnLaunch}, showZeroBalance: ${_this.showZeroBalance}, keepSlipImages: ${_this.keepSlipImages})';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 AppLanguage language, YearEra yearEra, bool hideOnLaunch, bool showZeroBalance, bool keepSlipImages
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? yearEra = null,Object? hideOnLaunch = null,Object? showZeroBalance = null,Object? keepSlipImages = null,}) {
  return _then(AppSettings(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,yearEra: null == yearEra ? _self.yearEra : yearEra // ignore: cast_nullable_to_non_nullable
as YearEra,hideOnLaunch: null == hideOnLaunch ? _self.hideOnLaunch : hideOnLaunch // ignore: cast_nullable_to_non_nullable
as bool,showZeroBalance: null == showZeroBalance ? _self.showZeroBalance : showZeroBalance // ignore: cast_nullable_to_non_nullable
as bool,keepSlipImages: null == keepSlipImages ? _self.keepSlipImages : keepSlipImages // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppLanguage language,  YearEra yearEra,  bool hideOnLaunch,  bool showZeroBalance,  bool keepSlipImages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.language,_that.yearEra,_that.hideOnLaunch,_that.showZeroBalance,_that.keepSlipImages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppLanguage language,  YearEra yearEra,  bool hideOnLaunch,  bool showZeroBalance,  bool keepSlipImages)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.language,_that.yearEra,_that.hideOnLaunch,_that.showZeroBalance,_that.keepSlipImages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppLanguage language,  YearEra yearEra,  bool hideOnLaunch,  bool showZeroBalance,  bool keepSlipImages)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.language,_that.yearEra,_that.hideOnLaunch,_that.showZeroBalance,_that.keepSlipImages);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings implements AppSettings {
  const _AppSettings({this.language = AppLanguage.th, this.yearEra = YearEra.buddhist, this.hideOnLaunch = false, this.showZeroBalance = false, this.keepSlipImages = true});
  

@override@JsonKey() final  AppLanguage language;
@override@JsonKey() final  YearEra yearEra;
/// Start with amounts masked on Home.
@override@JsonKey() final  bool hideOnLaunch;
@override@JsonKey() final  bool showZeroBalance;
@override@JsonKey() final  bool keepSlipImages;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.language, language) || other.language == language)&&(identical(other.yearEra, yearEra) || other.yearEra == yearEra)&&(identical(other.hideOnLaunch, hideOnLaunch) || other.hideOnLaunch == hideOnLaunch)&&(identical(other.showZeroBalance, showZeroBalance) || other.showZeroBalance == showZeroBalance)&&(identical(other.keepSlipImages, keepSlipImages) || other.keepSlipImages == keepSlipImages));
}


@override
int get hashCode {
    return Object.hash(runtimeType,language,yearEra,hideOnLaunch,showZeroBalance,keepSlipImages);
}

@override
String toString() {
    return 'AppSettings(language: $language, yearEra: $yearEra, hideOnLaunch: $hideOnLaunch, showZeroBalance: $showZeroBalance, keepSlipImages: $keepSlipImages)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 AppLanguage language, YearEra yearEra, bool hideOnLaunch, bool showZeroBalance, bool keepSlipImages
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? yearEra = null,Object? hideOnLaunch = null,Object? showZeroBalance = null,Object? keepSlipImages = null,}) {
  return _then(_AppSettings(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,yearEra: null == yearEra ? _self.yearEra : yearEra // ignore: cast_nullable_to_non_nullable
as YearEra,hideOnLaunch: null == hideOnLaunch ? _self.hideOnLaunch : hideOnLaunch // ignore: cast_nullable_to_non_nullable
as bool,showZeroBalance: null == showZeroBalance ? _self.showZeroBalance : showZeroBalance // ignore: cast_nullable_to_non_nullable
as bool,keepSlipImages: null == keepSlipImages ? _self.keepSlipImages : keepSlipImages // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

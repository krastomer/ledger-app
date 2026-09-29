import 'package:flutter/material.dart';

import 'dimens.dart';
import 'money_colors.dart';

abstract final class AppTheme {
  static const fontFamily = 'IBMPlexSansThai';
  static const monoFontFamily = 'IBMPlexMono';

  static const _seed = Color(0xFF2E5B4E);

  static ThemeData get light => _build(
    ColorScheme.fromSeed(seedColor: _seed).copyWith(
      primary: _seed,
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFFD5E7DF),
      onPrimaryContainer: const Color(0xFF0F2D24),
      secondaryContainer: const Color(0xFFD5E7DF),
      onSecondaryContainer: const Color(0xFF0F2D24),
      tertiaryContainer: const Color(0xFFFBEBC8),
      onTertiaryContainer: const Color(0xFF3D2A00),
      error: const Color(0xFFB3261E),
      surface: const Color(0xFFF6F5EF),
      onSurface: const Color(0xFF1C1D19),
      onSurfaceVariant: const Color(0xFF585A52),
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFF1F0EA),
      surfaceContainer: const Color(0xFFEFEEE7),
      surfaceContainerHigh: const Color(0xFFEAE8E0),
      surfaceContainerHighest: const Color(0xFFEEECE5),
      outline: const Color(0xFF797B72),
      outlineVariant: const Color(0xFFE4E2D9),
    ),
    MoneyColors.light,
    divider: const Color(0xFFEEECE5),
  );

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    );
    return _build(scheme, MoneyColors.dark, divider: scheme.outlineVariant);
  }

  /// The design's type scale. Material's default letter spacing is dropped:
  /// it spreads Thai text and the monospaced amounts.
  static const _textTheme = TextTheme(
    displayLarge: _TextStyle(57, 64, FontWeight.w400),
    displayMedium: _TextStyle(45, 52, FontWeight.w400),
    displaySmall: _TextStyle(30, 36, FontWeight.w600),
    headlineLarge: _TextStyle(32, 40, FontWeight.w400),
    headlineMedium: _TextStyle(28, 36, FontWeight.w700),
    headlineSmall: _TextStyle(24, 32, FontWeight.w400),
    titleLarge: _TextStyle(22, 28, FontWeight.w600),
    titleMedium: _TextStyle(15, 22, FontWeight.w600),
    titleSmall: _TextStyle(13, 18, FontWeight.w600),
    bodyLarge: _TextStyle(15, 22, FontWeight.w400),
    bodyMedium: _TextStyle(14, 20, FontWeight.w400),
    bodySmall: _TextStyle(13, 18, FontWeight.w400),
    labelLarge: _TextStyle(13, 18, FontWeight.w600),
    labelMedium: _TextStyle(12, 16, FontWeight.w600),
    labelSmall: _TextStyle(12, 16, FontWeight.w400),
  );

  static ThemeData _build(
    ColorScheme scheme,
    MoneyColors moneyColors, {
    required Color divider,
  }) => ThemeData(
    colorScheme: scheme,
    fontFamily: fontFamily,
    textTheme: _textTheme,
    scaffoldBackgroundColor: scheme.surface,
    extensions: [moneyColors],
    dividerTheme: DividerThemeData(color: divider, space: 1, thickness: 1),
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surfaceContainer,
      indicatorColor: scheme.primaryContainer,
      surfaceTintColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => _textTheme.labelMedium?.copyWith(
          fontFamily: fontFamily,
          color: scheme.onSurface,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w600
              : FontWeight.w500,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: scheme.surfaceContainerLowest,
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusM),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
  );
}

class _TextStyle extends TextStyle {
  const _TextStyle(double size, double lineHeight, FontWeight weight)
    : super(
        fontSize: size,
        height: lineHeight / size,
        fontWeight: weight,
        letterSpacing: 0,
      );
}

import 'package:flutter/material.dart';

import 'money_colors.dart';

abstract final class AppTheme {
  static const fontFamily = 'IBMPlexMono';
  static const thaiFontFamily = 'IBMPlexSansThai';

  static const _amber = Color(0xFFFFB547);

  static ThemeData get dark => _build(
    ColorScheme.fromSeed(
      seedColor: _amber,
      brightness: Brightness.dark,
    ).copyWith(
      primary: _amber,
      onPrimary: const Color(0xFF0B0C0B),
      primaryContainer: const Color(0xFF3A2C12),
      onPrimaryContainer: _amber,
      tertiary: const Color(0xFF7BD88F),
      onTertiary: const Color(0xFF0B0C0B),
      error: const Color(0xFFFF6B5E),
      onError: const Color(0xFF0B0C0B),
      surface: const Color(0xFF0B0C0B),
      onSurface: const Color(0xFFD9DDD3),
      onSurfaceVariant: const Color(0xFF858C82),
      surfaceContainerLowest: const Color(0xFF0B0C0B),
      surfaceContainerLow: const Color(0xFF111311),
      surfaceContainer: const Color(0xFF141714),
      surfaceContainerHigh: const Color(0xFF232723),
      surfaceContainerHighest: const Color(0xFF232723),
      outline: const Color(0xFF4F564F),
      outlineVariant: const Color(0xFF343A34),
    ),
    MoneyColors.dark,
  );

  /// 13/20 body text like the design. Material's default letter spacing is
  /// dropped: it breaks the monospaced grid.
  static const _textTheme = TextTheme(
    displaySmall: _TextStyle(30, 36, FontWeight.w500),
    headlineSmall: _TextStyle(26, 30, FontWeight.w600),
    titleLarge: _TextStyle(18, 26, FontWeight.w500),
    titleMedium: _TextStyle(15, 22, FontWeight.w500),
    titleSmall: _TextStyle(13, 20, FontWeight.w600),
    bodyLarge: _TextStyle(13, 20, FontWeight.w400),
    bodyMedium: _TextStyle(13, 20, FontWeight.w400),
    bodySmall: _TextStyle(12, 18, FontWeight.w400),
    labelLarge: _TextStyle(13, 20, FontWeight.w500),
    labelMedium: _TextStyle(12, 18, FontWeight.w500),
    labelSmall: _TextStyle(11, 14, FontWeight.w400),
  );

  static ThemeData _build(ColorScheme scheme, MoneyColors moneyColors) {
    const square = RoundedRectangleBorder();
    final line = BorderSide(color: scheme.outlineVariant);
    return ThemeData(
      colorScheme: scheme,
      fontFamily: fontFamily,
      fontFamilyFallback: const [thaiFontFamily],
      textTheme: _textTheme,
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: NoSplash.splashFactory,
      highlightColor: scheme.primary.withValues(alpha: 0.12),
      hoverColor: scheme.primary.withValues(alpha: 0.08),
      extensions: [moneyColors],
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        space: 1,
        thickness: 1,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        refreshBackgroundColor: scheme.surfaceContainer,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(side: line),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(side: line),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        contentTextStyle: _textTheme.bodyMedium?.copyWith(
          color: scheme.onSurface,
        ),
        shape: square,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          shape: square,
          textStyle: _textTheme.bodyMedium,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: square,
          textStyle: _textTheme.labelLarge,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: scheme.primary,
        selectionColor: scheme.primary.withValues(alpha: 0.3),
        selectionHandleColor: scheme.primary,
      ),
    );
  }
}

class _TextStyle extends TextStyle {
  const _TextStyle(double size, double lineHeight, FontWeight weight)
    : super(
        fontSize: size,
        height: lineHeight / size,
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: weight,
        letterSpacing: 0,
      );
}

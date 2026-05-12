import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App-wide colour palette and theme
class AppColors {
  // Primary tomato red
  static const tomato = Color(0xFFD85A30);
  static const tomatoDark = Color(0xFF993C1D);
  static const tomatoLight = Color(0xFFFAECE7);
  
  // Background
  static const cream = Color(0xFFFDF8F3);
  static const surface = Color(0xFFFFFFFF);
  
  // Accents
  static const leaf = Color(0xFF639922);
  static const leafLight = Color(0xFFEAF3DE);
  static const leafDark = Color(0xFF27500A);
  
  static const sun = Color(0xFFBA7517);
  static const sunLight = Color(0xFFFAEEDA);
  static const sunDark = Color(0xFF633806);
  
  static const sky = Color(0xFF378ADD);
  static const skyLight = Color(0xFFE6F1FB);
  static const skyDark = Color(0xFF0C447C);
  
  // Text
  static const textPrimary = Color(0xFF2C2C2A);
  static const textSecondary = Color(0xFF6B6963);
  static const textTertiary = Color(0xFF9C9A92);
  
  // Borders
  static const border = Color(0xFFE5E1D9);
  static const borderStrong = Color(0xFFCFCBC1);
}

/// App-wide spacing constants
class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

/// App-wide border radius
class AppRadius {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const pill = 999.0;
}

/// Main app theme
class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.tomato,
          primary: AppColors.tomato,
          surface: AppColors.cream,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.cream,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: AppColors.tomatoLight,
          height: 68,
          labelTextStyle: WidgetStatePropertyAll(
            GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(
                color: AppColors.tomato,
                size: 24,
              );
            }
            return const IconThemeData(
              color: AppColors.textSecondary,
              size: 24,
            );
          }),
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            side: const BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),
      );
}

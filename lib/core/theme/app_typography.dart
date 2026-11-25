import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  // Headlines using Space Grotesk
  static TextStyle headlineXl({Color color = AppColors.ink}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.02,
        color: color,
      );

  static TextStyle headlineLg({Color color = AppColors.ink}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.02,
        color: color,
      );

  static TextStyle headlineMd({Color color = AppColors.ink}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: -0.01,
        color: color,
      );

  static TextStyle headlineSm({Color color = AppColors.ink}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.01,
        color: color,
      );

  // Labels & Badges using Space Grotesk
  static TextStyle labelLg({Color color = AppColors.ink}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.02,
        color: color,
      );

  static TextStyle labelMd({Color color = AppColors.ink}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.02,
        color: color,
      );

  static TextStyle labelSm({Color color = AppColors.ink}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.04,
        color: color,
      );

  // Body Text using Inter
  static TextStyle bodyLg({Color color = AppColors.onSurface}) =>
      GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: color,
      );

  static TextStyle bodyMd({Color color = AppColors.onSurface}) =>
      GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: color,
      );

  static TextStyle bodySm({Color color = AppColors.onSurfaceVariant}) =>
      GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color,
      );
}

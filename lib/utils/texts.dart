part of 'util.dart';

class CIPSTextThemes {
  static TextTheme get theme => TextTheme(
        displayLarge: TextStyle(
          color: CIPSColor.textPrimaryColor,
          fontSize: 26.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'Raleway',
        ),
        bodyLarge: TextStyle(
          color: CIPSColor.textPrimaryColor,
          fontSize: 28.0,
          fontWeight: FontWeight.w800,
          fontFamily: 'Raleway',
        ),
        bodyMedium: TextStyle(
          color: CIPSColor.textPrimaryColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
          fontFamily: 'Raleway',
        ),
        titleMedium: TextStyle(
          color: CIPSColor.textPrimaryColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Montserrat',
        ),
        titleSmall: TextStyle(
          color: CIPSColor.textPrimaryColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Montserrat',
        ),
        labelLarge: TextStyle(
          color: CIPSColor.textPrimaryColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
        ),
        labelMedium: TextStyle(
          color: CIPSColor.textPrimaryColor,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
        ),
      );
}

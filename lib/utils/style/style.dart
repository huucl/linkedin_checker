import 'package:flutter/material.dart';

import 'theme_model.dart';

//region new
const Color _lp800 = Color(0xFF5f01d6);
const Color _dp800 = Color(0xFF5f01d6);

const Color _lp700 = Color(0xFF7000FF);
const Color _dp700 = Color(0xFF7000FF);

const Color _lp600 = Color(0xFF7E14FF);
const Color _dp600 = Color(0xFF7E14FF);

const Color _lp500 = Color(0xFF883BFF);
const Color _dp500 = Color(0xFF883BFF);

const Color _lp400 = Color(0xFFA273FF);
const Color _dp400 = Color(0xFFA273FF);

const Color _lp300 = Color(0xFFBFA6FF);
const Color _dp300 = Color(0xFFBFA6FF);

const Color _lp200 = Color(0xFFD9CDFF);
const Color _dp200 = Color(0xFFD9CDFF);

const Color _lp100 = Color(0xFFF4F0FF);
const Color _dp100 = Color(0xFFF4F0FF);

const Color _lS800 = Color(0xFF94320C);
const Color _dS800 = Color(0xFF94320C);

const Color _lS700 = Color(0xFFB74206);
const Color _dS700 = Color(0xFFB74206);

const Color _lS600 = Color(0xFFDD6202);
const Color _dS600 = Color(0xFFDD6202);

const Color _lS500 = Color(0xFFF98807);
const Color _dS500 = Color(0xFFF98807);

const Color _lS400 = Color(0xFFFFAC20);
const Color _dS400 = Color(0xFFFFAC20);

const Color _lS300 = Color(0xFFFFBF3C);
const Color _dS300 = Color(0xFFFFBF3C);

const Color _lS200 = Color(0xFFFFDC88);
const Color _dS200 = Color(0xFFFFDC88);

const Color _lS100 = Color(0xFFFFF9EB);
const Color _dS100 = Color(0xFFFFF9EB);

const Color _lN800 = Color(0xFF35353A);
const Color _dN800 = Color(0xFF35353A);

const Color _lN700 = Color(0xFF4A4B54);
const Color _dN700 = Color(0xFF4A4B54);

const Color _lN600 = Color(0xFF666874);
const Color _dN600 = Color(0xFF666874);

const Color _lN500 = Color(0xFF8c8c99);
const Color _dN500 = Color(0xFF8c8c99);

const Color _lN400 = Color(0xFFBBBBCC);
const Color _dN400 = Color(0xFFBBBBCC);

const Color _lN300 = Color(0xFFDEDFE7);
const Color _dN300 = Color(0xFFDEDFE7);

const Color _lN200 = Color(0xFFEDEEF2);
const Color _dN200 = Color(0xFFEDEEF2);

const Color _lN100 = Color(0xFFF5F5F7);
const Color _dN100 = Color(0xFFF5F5F7);

const Color _lN0 = Color(0xFFFFFFFF);
const Color _dN0 = Color(0xFFFFFFFF);

const Color _lInfo500 = Color(0xFF1B64F5);
const Color _dInfo500 = Color(0xFF1B64F5);

const Color _lInfo400 = Color(0xFF59A8FF);
const Color _dInfo400 = Color(0xFF59A8FF);

const Color _lInfo300 = Color(0xFF8EC8FF);
const Color _dInfo300 = Color(0xFF8EC8FF);

const Color _lInfo200 = Color(0xFFD9EBFF);
const Color _dInfo200 = Color(0xFFD9EBFF);

const Color _lInfo100 = Color(0xFFEEF6FF);
const Color _dInfo100 = Color(0xFFEEF6FF);

const Color _lSuccess500 = Color(0xFF04911C);
const Color _dSuccess500 = Color(0xFF04911C);

const Color _lSuccess400 = Color(0xFF00c01f);
const Color _dSuccess400 = Color(0xFF00c01f);

const Color _lSuccess300 = Color(0xFF33f552);
const Color _dSuccess300 = Color(0xFF33f552);

const Color _lSuccess200 = Color(0xFFd7ffdd);
const Color _dSuccess200 = Color(0xFFd7ffdd);

const Color _lSuccess100 = Color(0xFFeeffef);
const Color _dSuccess100 = Color(0xFFeeffef);

const Color _lError500 = Color(0xFF9D0F11);
const Color _dError500 = Color(0xFF9D0F11);

const Color _lError400 = Color(0xFFEF1907);
const Color _dError400 = Color(0xFFEF1907);

const Color _lError300 = Color(0xFFFF5630);
const Color _dError300 = Color(0xFFFF5630);

const Color _lError200 = Color(0xFFFFe2D4);
const Color _dError200 = Color(0xFFFFe2D4);

const Color _lError100 = Color(0xFFFFF2ED);
const Color _dError100 = Color(0xFFFFF2ED);

const Color _lLink = Color(0xFF1B64F5);
const Color _dLink = Color(0xFF1B64F5);

//endregion

const Color _transparent = Colors.transparent;

ThemeModel get dark => const ThemeModel(
    p800: _dp800,
    p700: _dp700,
    p600: _dp600,
    p500: _dp500,
    p400: _dp400,
    p300: _dp300,
    p200: _dp200,
    p100: _dp100,
    s800: _dS800,
    s700: _dS700,
    s600: _dS600,
    s500: _dS500,
    s400: _dS400,
    s300: _dS300,
    s200: _dS200,
    s100: _dS100,
    n800: _dN800,
    n700: _dN700,
    n600: _dN600,
    n500: _dN500,
    n400: _dN400,
    n300: _dN300,
    n200: _dN200,
    n100: _dN100,
    n000: _dN0,
    info500: _dInfo500,
    info400: _dInfo400,
    info300: _dInfo300,
    info200: _dInfo200,
    info100: _dInfo100,
    success500: _dSuccess500,
    success400: _dSuccess400,
    success300: _dSuccess300,
    success200: _dSuccess200,
    success100: _dSuccess100,
    error500: _dError500,
    error400: _dError400,
    error300: _dError300,
    error200: _dError200,
    error100: _dError100,
    transparent: _transparent,
    link: _dLink);

ThemeModel get light => const ThemeModel(
    p800: _lp800,
    p700: _lp700,
    p600: _lp600,
    p500: _lp500,
    p400: _lp400,
    p300: _lp300,
    p200: _lp200,
    p100: _lp100,
    s800: _lS800,
    s700: _lS700,
    s600: _lS600,
    s500: _lS500,
    s400: _lS400,
    s300: _lS300,
    s200: _lS200,
    s100: _lS100,
    n800: _lN800,
    n700: _lN700,
    n600: _lN600,
    n500: _lN500,
    n400: _lN400,
    n300: _lN300,
    n200: _lN200,
    n100: _lN100,
    n000: _lN0,
    info500: _lInfo500,
    info400: _lInfo400,
    info300: _lInfo300,
    info200: _lInfo200,
    info100: _lInfo100,
    success500: _lSuccess500,
    success400: _lSuccess400,
    success300: _lSuccess300,
    success200: _lSuccess200,
    success100: _lSuccess100,
    error500: _lError500,
    error400: _lError400,
    error300: _lError300,
    error200: _lError200,
    error100: _lError100,
    transparent: _transparent,
    link: _lLink);

ThemeData get darkTheme => ThemeData.dark().copyWith(
      primaryColor: _lp700,
      appBarTheme: AppBarTheme(
        backgroundColor: _lN0,
        iconTheme: const IconThemeData(
          color: _lp700, // default Leading appbar icon color
        ),
        titleTextStyle: TextStyle(
          color: _lN700,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      scaffoldBackgroundColor: _lN0,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: _lN700),
        bodyMedium: TextStyle(color: _lN700),
        labelSmall: TextStyle(color: _lN700),
      ), // default font
    );

ThemeData get lightTheme => ThemeData.light().copyWith(
      primaryColor: _lp700,
      appBarTheme: AppBarTheme(
        backgroundColor: _lN0,
        iconTheme: const IconThemeData(
          color: _lp700, // default Leading appbar icon color
        ),
        titleTextStyle: TextStyle(
          color: _lN700,
          fontSize: 16,
          fontWeight: FontWeight.w700,

        ),
      ),
      scaffoldBackgroundColor: _lN0,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: _lN700,),
        bodyMedium: TextStyle(color: _lN700,),
        labelSmall: TextStyle(color: _lN700,),
      ), // default font
    );

ThemeModel theme = dark;

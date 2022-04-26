import 'package:flutter/material.dart';
import 'package:stores/presentation/resources/color_manager.dart';
import 'package:stores/presentation/resources/font_manager.dart';
import 'package:stores/presentation/resources/styles_manager.dart';
import 'package:stores/presentation/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,

    // cardview theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.white,
      ),
    ),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    // eleveted button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s17,
        ),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s12,
          ),
        ),
      ),
    ),

    // text theme
    textTheme: TextTheme(
      displayLarge: getLightStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s14,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s14,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.grey1,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.grey,
      ),
    ),

    // inpit decoration theme text form field theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(
        AppPadding.p8,
      ),
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle: getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(
        color: ColorManager.error,
      ),

      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s8,
        ),
      ),

      // focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s8,
        ),
      ),

      // error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s8,
        ),
      ),

      // focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s8,
        ),
      ),
    ),
  );
}

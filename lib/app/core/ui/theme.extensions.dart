import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext{
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get colorSchemePrimary => Theme.of(this).colorScheme.primary;
  Color get colorSchemeOnPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get colorSchemeOnPrimaryContainer => Theme.of(this).colorScheme.onPrimaryContainer;
  Color get colorSchemeOnSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get colorSchemeOnSecondaryContainer => Theme.of(this).colorScheme.onSecondaryContainer;
  Color get colorSchemeOnTertiary => Theme.of(this).colorScheme.onTertiary;
  Color get colorSchemeOnTertiaryContainer => Theme.of(this).colorScheme.onTertiaryContainer;
  Color get colorSchemeOnError => Theme.of(this).colorScheme.onError;
  Color get colorSchemeOnErrorContainer => Theme.of(this).colorScheme.onErrorContainer;
  Color? get buttonColor => Theme.of(this).buttonTheme.colorScheme?.primary;
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get titleStyle => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );

}
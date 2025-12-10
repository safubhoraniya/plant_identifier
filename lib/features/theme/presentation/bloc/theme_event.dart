part of 'theme_bloc.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class LoadThemeEvent extends ThemeEvent {
  const LoadThemeEvent();
}

class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent();
}

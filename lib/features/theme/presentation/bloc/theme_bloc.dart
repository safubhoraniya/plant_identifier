import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_identifier/core/theme/app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(isDarkMode: false)) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  Future<void> _onLoadTheme(
    LoadThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final isDarkMode = await ThemeService.getThemeMode();
    emit(ThemeState(isDarkMode: isDarkMode));
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final newTheme = !state.isDarkMode;
    await ThemeService.setThemeMode(newTheme);
    emit(ThemeState(isDarkMode: newTheme));
  }
}

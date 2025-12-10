import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Domain Layer
import 'domain/usecases/plant_usecases.dart';
import 'domain/usecases/favorites_usecases.dart';

// Data Layer
import 'data/datasources/plant_local_datasource.dart';
import 'data/datasources/favorites_local_datasource.dart';
import 'data/repositories/plant_repository_impl.dart';
import 'data/repositories/favorites_repository_impl.dart';

// Core Services
import 'core/services/ml_service.dart';
import 'core/theme/app_theme.dart';

// BLoCs
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/scanner/presentation/bloc/scanner_bloc.dart';
import 'features/plant_detail/presentation/bloc/plant_detail_bloc.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/plant_list/presentation/bloc/plant_list_bloc.dart';
import 'features/theme/presentation/bloc/theme_bloc.dart';

// Screens
import 'features/home/presentation/pages/home_screen.dart';
import 'features/scanner/presentation/pages/scanner_screen.dart';
import 'features/scanner/presentation/pages/scanner_result_screen.dart';
import 'features/plant_detail/presentation/pages/plant_detail_screen.dart';
import 'features/favorites/presentation/pages/favorites_screen.dart';
import 'features/plant_list/presentation/pages/plant_list_screen.dart';
import 'features/settings/presentation/pages/settings_screen.dart';
import 'features/onboarding/presentation/pages/onboarding_screen.dart';
import 'features/about/presentation/pages/about_screen.dart';
import 'features/privacy/presentation/pages/privacy_policy_screen.dart';

// Core


Future<bool> _checkOnboardingStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_completed') ?? false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    // Initialize Data Sources
    final plantLocalDataSource = PlantLocalDataSourceImpl();
    final favoritesLocalDataSource = FavoritesLocalDataSourceImpl(
      sharedPreferences: sharedPreferences,
    );

    // Initialize Repositories
    final plantRepository = PlantRepositoryImpl(
      localDataSource: plantLocalDataSource,
    );
    final favoritesRepository = FavoritesRepositoryImpl(
      localDataSource: favoritesLocalDataSource,
    );

    // Initialize Use Cases
    final getAllPlantsUseCase = GetAllPlantsUseCase(repository: plantRepository);
    final getPlantByIdUseCase = GetPlantByIdUseCase(repository: plantRepository);
    final searchPlantsUseCase = SearchPlantsUseCase(repository: plantRepository);

    final getFavoritesUseCase =
        GetFavoritesUseCase(repository: favoritesRepository);
    final addFavoriteUseCase =
        AddFavoriteUseCase(repository: favoritesRepository);
    final removeFavoriteUseCase =
        RemoveFavoriteUseCase(repository: favoritesRepository);
    final isFavoriteUseCase =
        IsFavoriteUseCase(repository: favoritesRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PlantRepositoryImpl>(
          create: (_) => plantRepository,
        ),
        RepositoryProvider<FavoritesRepositoryImpl>(
          create: (_) => favoritesRepository,
        ),
        // ML Service Provider
        RepositoryProvider<MLService>(
          create: (_) => MLServiceImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Home BLoC
          BlocProvider(
            create: (_) => HomeBloc(
              getAllPlantsUseCase: getAllPlantsUseCase,
              searchPlantsUseCase: searchPlantsUseCase,
            ),
          ),
          // Scanner BLoC with ML Service
          BlocProvider(
            create: (context) => ScannerBloc(
              mlService: context.read<MLService>(),
            ),
          ),
          // Plant Detail BLoC
          BlocProvider(
            create: (_) => PlantDetailBloc(
              getPlantByIdUseCase: getPlantByIdUseCase,
              isFavoriteUseCase: isFavoriteUseCase,
              addFavoriteUseCase: addFavoriteUseCase,
              removeFavoriteUseCase: removeFavoriteUseCase,
            ),
          ),
          // Favorites BLoC
          BlocProvider(
            create: (_) => FavoritesBloc(
              getFavoritesUseCase: getFavoritesUseCase,
              getAllPlantsUseCase: getAllPlantsUseCase,
              addFavoriteUseCase: addFavoriteUseCase,
              removeFavoriteUseCase: removeFavoriteUseCase,
            ),
          ),
          // Plant List BLoC
          BlocProvider(
            create: (_) => PlantListBloc(
              getAllPlantsUseCase: getAllPlantsUseCase,
            ),
          ),
          // Theme BLoC
          BlocProvider(
            create: (_) => ThemeBloc()..add(const LoadThemeEvent()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: 'Plant Identifier',
              theme: ThemeService.lightTheme(),
              darkTheme: ThemeService.darkTheme(),
              themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: FutureBuilder<bool>(
                future: _checkOnboardingStatus(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final onboardingCompleted = snapshot.data ?? false;
                  return onboardingCompleted 
                    ? const HomeScreen() 
                    : const OnboardingScreen();
                },
              ),
              routes: {
                '/home': (context) => const HomeScreen(),
                '/scanner': (context) => const ScannerScreen(),
                '/favorites': (context) => const FavoritesScreen(),
                '/settings': (context) => const SettingsScreen(),
                '/about-us': (context) => const AboutScreen(),
                '/privacy-policy': (context) => const PrivacyPolicyScreen(),
                '/plant-detail': (context) {
                  final plantId =
                      ModalRoute.of(context)?.settings.arguments as String;
                  return PlantDetailScreen(plantId: plantId);
                },
                '/scanner-result': (context) {
                  final args = ModalRoute.of(context)?.settings.arguments
                      as Map<String, dynamic>;
                  return ScannerResultScreen(
                    plantId: args['plantId'],
                    plantName: args['plantName'],
                    confidence: args['confidence'],
                  );
                },
                '/plant-list': (context) {
                  final category =
                      ModalRoute.of(context)?.settings.arguments as String;
                  return PlantListScreen(category: category);
                },
              },
            );
          },
        ),
      ),
    );
  }
}


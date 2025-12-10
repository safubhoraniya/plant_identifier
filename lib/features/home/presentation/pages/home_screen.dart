import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/bloc/home_bloc.dart';
import 'package:plant_identifier/features/theme/presentation/bloc/theme_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? _lastBackPressed;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const FetchPlantsEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleBackPress() {
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _navigateToFavorites() {
    Navigator.of(context).pushNamed('/favorites');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _handleBackPress();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Plant Identifier'),
          backgroundColor: Colors.green,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: _navigateToFavorites,
            ),
            const SizedBox(width: 8),
          ],
        ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.local_florist,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Plant Identifier',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/about-us');
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/privacy-policy');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.brightness_4),
              title: const Text('Dark Mode'),
              trailing: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return Switch(
                    value: themeState.isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeBloc>().add(const ToggleThemeEvent());
                    },
                  );
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Exit'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: GestureDetector(
        // Swipe Gesture: Right-to-Left (Daayein se baayein)
        onHorizontalDragEnd: (details) {
          // Check if swipe velocity is significant and in the right direction (negative velocity)
          if (details.primaryVelocity! < -500) { 
            _navigateToFavorites();
          }
        },
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search plants...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (query) {
                  if (query.isEmpty) {
                    context.read<HomeBloc>().add(const ClearSearchEvent());
                  } else {
                    context.read<HomeBloc>().add(SearchPlantsEvent(query));
                  }
                },
              ),
            ),
            // Plant Grid - Using Expanded to prevent overflow
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomePlantsLoaded) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.80,
                      ),
                      itemCount: state.plants.length,
                      itemBuilder: (context, index) {
                        final plant = state.plants[index];
                        return _buildPlantCard(context, plant);
                      },
                    );
                  } else if (state is HomeSearchLoaded) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.80,
                      ),
                      itemCount: state.plants.length,
                      itemBuilder: (context, index) {
                        final plant = state.plants[index];
                        return _buildPlantCard(context, plant);
                      },
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/scanner');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    ));
  }
}

  Widget _buildPlantCard(BuildContext context, dynamic plant) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/plant-detail', arguments: plant.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plant Image - Fixed height with proper aspect ratio
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: plant.imageUrl != null && plant.imageUrl!.isNotEmpty
                    ? Image.asset(
                        plant.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.green.shade100,
                          child: const Icon(
                            Icons.local_florist,
                            size: 48,
                            color: Colors.green,
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.green.shade100,
                        child: const Icon(
                          Icons.local_florist,
                          size: 48,
                          color: Colors.green,
                        ),
                      ),
              ),
            ),
            // Plant Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      plant.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      plant.careLevel,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));

}
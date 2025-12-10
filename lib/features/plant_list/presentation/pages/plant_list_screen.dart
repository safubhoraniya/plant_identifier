import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/bloc/plant_list_bloc.dart';

class PlantListScreen extends StatefulWidget {
  final String category;

  const PlantListScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<PlantListScreen> createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlantListBloc>().add(FetchPlantsByCareLevelEvent(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Plants'),
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<PlantListBloc, PlantListState>(
        builder: (context, state) {
          if (state is PlantListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PlantListLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.plants.length,
              itemBuilder: (context, index) {
                final plant = state.plants[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: plant.imageUrl != null && plant.imageUrl!.isNotEmpty
                          ? Image.asset(
                              plant.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.local_florist,
                                color: Colors.green,
                              ),
                            )
                          : const Icon(
                              Icons.local_florist,
                              color: Colors.green,
                            ),
                    ),
                    title: Text(
                      plant.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      plant.scientificName,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/plant-detail',
                        arguments: plant.id,
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is PlantListError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

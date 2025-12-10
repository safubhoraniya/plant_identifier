import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/bloc/plant_detail_bloc.dart';

class PlantDetailScreen extends StatefulWidget {
  final String plantId;

  const PlantDetailScreen({Key? key, required this.plantId}) : super(key: key);

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlantDetailBloc>().add(FetchPlantDetailsEvent(widget.plantId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Details'),
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<PlantDetailBloc, PlantDetailState>(
        builder: (context, state) {
          if (state is PlantDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PlantDetailLoaded) {
            final plant = state.plant;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plant Image
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.green.shade100,
                    child: plant.imageUrl != null && plant.imageUrl!.isNotEmpty
                        ? Image.asset(
                            plant.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.local_florist,
                              size: 120,
                              color: Colors.green,
                            ),
                          )
                        : const Icon(
                            Icons.local_florist,
                            size: 120,
                            color: Colors.green,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Favorite Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plant.name,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    plant.scientificName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<PlantDetailBloc>().add(
                                      ToggleFavoriteEvent(plant.id),
                                    );
                              },
                              icon: Icon(
                                state.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Description
                        Text(
                          plant.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Care Info Section
                        _buildSectionTitle('Care Information'),
                        _buildInfoRow('Care Level', plant.careLevel),
                        _buildInfoRow('Water Needs', plant.waterNeeds),
                        _buildInfoRow(
                            'Light Requirements', plant.lightRequirements),
                        _buildInfoRow('Temperature', plant.temperature),
                        _buildInfoRow('Humidity', plant.humidity),
                        const SizedBox(height: 20),
                        // Additional Info
                        _buildSectionTitle('Additional Information'),
                        _buildInfoRow('Propagation', plant.propagation),
                        _buildInfoRow('Toxicity', plant.toxicity),
                        _buildInfoRow('Native Region', plant.nativeRegion),
                        const SizedBox(height: 20),
                        // Benefits
                        _buildSectionTitle('Benefits'),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: plant.benefits
                              .map(
                                (benefit) => Chip(
                                  label: Text(benefit),
                                  backgroundColor: Colors.green.shade100,
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        // Care Tips
                        _buildSectionTitle('Care Tips'),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: plant.careTips.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      plant.careTips[index],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is PlantDetailError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

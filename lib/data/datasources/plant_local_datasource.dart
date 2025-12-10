import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/plant_model.dart';

abstract class PlantLocalDataSource {
  Future<List<PlantModel>> getAllPlants();
  Future<PlantModel?> getPlantById(String id);
  Future<List<PlantModel>> searchPlants(String query);
}

class PlantLocalDataSourceImpl implements PlantLocalDataSource {
  @override
  Future<List<PlantModel>> getAllPlants() async {
    final jsonString = await rootBundle.loadString('assets/data/plants.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final plants = (jsonData['plants'] as List)
        .map((plant) => PlantModel.fromJson(plant as Map<String, dynamic>))
        .toList();
    return plants;
  }

  @override
  Future<PlantModel?> getPlantById(String id) async {
    final plants = await getAllPlants();
    try {
      return plants.firstWhere((plant) => plant.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<PlantModel>> searchPlants(String query) async {
    final plants = await getAllPlants();
    final lowerQuery = query.toLowerCase();
    return plants
        .where((plant) =>
            plant.name.toLowerCase().contains(lowerQuery) ||
            plant.scientificName.toLowerCase().contains(lowerQuery) ||
            plant.commonNames
                .any((name) => name.toLowerCase().contains(lowerQuery)))
        .toList();
  }
}

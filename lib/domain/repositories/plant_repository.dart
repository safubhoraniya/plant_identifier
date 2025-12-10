import '../entities/plant.dart';

abstract class PlantRepository {
  Future<List<Plant>> getAllPlants();
  Future<Plant?> getPlantById(String id);
  Future<List<Plant>> searchPlants(String query);
}

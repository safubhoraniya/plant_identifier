import '../../domain/entities/plant.dart';
import '../../domain/repositories/plant_repository.dart';
import '../datasources/plant_local_datasource.dart';

class PlantRepositoryImpl implements PlantRepository {
  final PlantLocalDataSource localDataSource;

  PlantRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Plant>> getAllPlants() async {
    return await localDataSource.getAllPlants();
  }

  @override
  Future<Plant?> getPlantById(String id) async {
    return await localDataSource.getPlantById(id);
  }

  @override
  Future<List<Plant>> searchPlants(String query) async {
    return await localDataSource.searchPlants(query);
  }
}

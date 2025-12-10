import '../entities/plant.dart';
import '../repositories/plant_repository.dart';

class GetAllPlantsUseCase {
  final PlantRepository repository;

  GetAllPlantsUseCase({required this.repository});

  Future<List<Plant>> call() async {
    return await repository.getAllPlants();
  }
}

class GetPlantByIdUseCase {
  final PlantRepository repository;

  GetPlantByIdUseCase({required this.repository});

  Future<Plant?> call(String id) async {
    return await repository.getPlantById(id);
  }
}

class SearchPlantsUseCase {
  final PlantRepository repository;

  SearchPlantsUseCase({required this.repository});

  Future<List<Plant>> call(String query) async {
    return await repository.searchPlants(query);
  }
}

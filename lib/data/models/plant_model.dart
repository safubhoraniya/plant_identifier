import '../../domain/entities/plant.dart';

class PlantModel extends Plant {
  const PlantModel({
    required String id,
    required String name,
    required String scientificName,
    required String description,
    required String careLevel,
    required String waterNeeds,
    required String lightRequirements,
    required String temperature,
    required String humidity,
    required List<String> commonNames,
    required List<String> benefits,
    required List<String> careTips,
    required String propagation,
    required String toxicity,
    required String nativeRegion,
    String? imageUrl,
    bool isFavorite = false,
  }) : super(
    id: id,
    name: name,
    scientificName: scientificName,
    description: description,
    careLevel: careLevel,
    waterNeeds: waterNeeds,
    lightRequirements: lightRequirements,
    temperature: temperature,
    humidity: humidity,
    commonNames: commonNames,
    benefits: benefits,
    careTips: careTips,
    propagation: propagation,
    toxicity: toxicity,
    nativeRegion: nativeRegion,
    imageUrl: imageUrl,
    isFavorite: isFavorite,
  );

  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      scientificName: json['scientificName'] as String,
      description: json['description'] as String,
      careLevel: json['careLevel'] as String,
      waterNeeds: json['waterNeeds'] as String,
      lightRequirements: json['lightRequirements'] as String,
      temperature: json['temperature'] as String,
      humidity: json['humidity'] as String,
      commonNames: List<String>.from(json['commonNames'] as List),
      benefits: List<String>.from(json['benefits'] as List),
      careTips: List<String>.from(json['careTips'] as List),
      propagation: json['propagation'] as String,
      toxicity: json['toxicity'] as String,
      nativeRegion: json['nativeRegion'] as String,
      imageUrl: json['imageUrl'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'scientificName': scientificName,
      'description': description,
      'careLevel': careLevel,
      'waterNeeds': waterNeeds,
      'lightRequirements': lightRequirements,
      'temperature': temperature,
      'humidity': humidity,
      'commonNames': commonNames,
      'benefits': benefits,
      'careTips': careTips,
      'propagation': propagation,
      'toxicity': toxicity,
      'nativeRegion': nativeRegion,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }
}

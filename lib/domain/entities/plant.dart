import 'package:equatable/equatable.dart';

class Plant extends Equatable {
  final String id;
  final String name;
  final String scientificName;
  final String description;
  final String careLevel;
  final String waterNeeds;
  final String lightRequirements;
  final String temperature;
  final String humidity;
  final List<String> commonNames;
  final List<String> benefits;
  final List<String> careTips;
  final String propagation;
  final String toxicity;
  final String nativeRegion;
  final String? imageUrl;
  final bool isFavorite;

  const Plant({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.careLevel,
    required this.waterNeeds,
    required this.lightRequirements,
    required this.temperature,
    required this.humidity,
    required this.commonNames,
    required this.benefits,
    required this.careTips,
    required this.propagation,
    required this.toxicity,
    required this.nativeRegion,
    this.imageUrl,
    this.isFavorite = false,
  });

  Plant copyWith({
    String? id,
    String? name,
    String? scientificName,
    String? description,
    String? careLevel,
    String? waterNeeds,
    String? lightRequirements,
    String? temperature,
    String? humidity,
    List<String>? commonNames,
    List<String>? benefits,
    List<String>? careTips,
    String? propagation,
    String? toxicity,
    String? nativeRegion,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      description: description ?? this.description,
      careLevel: careLevel ?? this.careLevel,
      waterNeeds: waterNeeds ?? this.waterNeeds,
      lightRequirements: lightRequirements ?? this.lightRequirements,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      commonNames: commonNames ?? this.commonNames,
      benefits: benefits ?? this.benefits,
      careTips: careTips ?? this.careTips,
      propagation: propagation ?? this.propagation,
      toxicity: toxicity ?? this.toxicity,
      nativeRegion: nativeRegion ?? this.nativeRegion,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        scientificName,
        description,
        careLevel,
        waterNeeds,
        lightRequirements,
        temperature,
        humidity,
        commonNames,
        benefits,
        careTips,
        propagation,
        toxicity,
        nativeRegion,
        imageUrl,
        isFavorite,
      ];
}

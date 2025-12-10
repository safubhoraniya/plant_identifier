part of 'scanner_bloc.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();

  @override
  List<Object?> get props => [];
}

class ScannerInitial extends ScannerState {
  const ScannerInitial();
}

class CameraInitializing extends ScannerState {
  const CameraInitializing();
}

class CameraReady extends ScannerState {
  const CameraReady();
}

class PlantImageCaptured extends ScannerState {
  final String imagePath;

  const PlantImageCaptured(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class DetectingPlant extends ScannerState {
  const DetectingPlant();
}

class PlantDetected extends ScannerState {
  final String detectedPlantId;
  final String detectedPlantName;
  final double confidence;

  const PlantDetected(
    this.detectedPlantId,
    this.detectedPlantName,
    this.confidence,
  );

  @override
  List<Object?> get props => [detectedPlantId, detectedPlantName, confidence];
}

class ScannerError extends ScannerState {
  final String message;

  const ScannerError(this.message);

  @override
  List<Object?> get props => [message];
}

part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object?> get props => [];
}

class InitializeCameraEvent extends ScannerEvent {
  const InitializeCameraEvent();
}

class CapturePlantImageEvent extends ScannerEvent {
  final String imagePath;

  const CapturePlantImageEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class DetectPlantEvent extends ScannerEvent {
  final String imagePath;

  const DetectPlantEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class ResetScannerEvent extends ScannerEvent {
  const ResetScannerEvent();
}

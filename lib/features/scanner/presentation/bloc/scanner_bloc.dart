import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/services/ml_service.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final MLService _mlService;

  ScannerBloc({required MLService mlService})
      : _mlService = mlService,
        super(const ScannerInitial()) {
    on<InitializeCameraEvent>(_onInitializeCamera);
    on<CapturePlantImageEvent>(_onCapturePlantImage);
    on<DetectPlantEvent>(_onDetectPlant);
    on<ResetScannerEvent>(_onResetScanner);
  }

  Future<void> _onInitializeCamera(
    InitializeCameraEvent event,
    Emitter<ScannerState> emit,
  ) async {
    emit(const CameraInitializing());
    try {
      // Camera initialization logic here
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const CameraReady());
    } catch (e) {
      emit(ScannerError('Failed to initialize camera: $e'));
    }
  }

  Future<void> _onCapturePlantImage(
    CapturePlantImageEvent event,
    Emitter<ScannerState> emit,
  ) async {
    try {
      emit(PlantImageCaptured(event.imagePath));
    } catch (e) {
      emit(ScannerError('Failed to capture image: $e'));
    }
  }

  Future<void> _onDetectPlant(
    DetectPlantEvent event,
    Emitter<ScannerState> emit,
  ) async {
    emit(const DetectingPlant());
    try {
      // Read image file from path
      final imageFile = File(event.imagePath);
      final imageBytes = await imageFile.readAsBytes();

      // Use Real ML Service to detect plant
      final result = await _mlService.detectPlant(imageBytes);

      final plantId = result['plantId'] as String;
      final plantName = result['plantName'] as String;
      final confidence = result['confidence'] as double;

      print('🌿 Detection Result: $plantName (Confidence: $confidence)');

      emit(PlantDetected(plantId, plantName, confidence));
    } catch (e) {
      print('❌ Detection Error: $e');
      emit(ScannerError('Failed to detect plant: $e'));
    }
  }

  Future<void> _onResetScanner(
    ResetScannerEvent event,
    Emitter<ScannerState> emit,
  ) async {
    emit(const CameraReady());
  }
}

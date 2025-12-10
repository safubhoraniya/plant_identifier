import 'package:equatable/equatable.dart';

class ScanResult extends Equatable {
  final String plantId;
  final String plantName;
  final double confidence;
  final DateTime timestamp;

  const ScanResult({
    required this.plantId,
    required this.plantName,
    required this.confidence,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [plantId, plantName, confidence, timestamp];
}

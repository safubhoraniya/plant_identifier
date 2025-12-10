import 'package:flutter/material.dart';
import '../../../../data/datasources/plant_local_datasource.dart';
import '../../../../data/models/plant_model.dart';

class ScannerResultScreen extends StatefulWidget {
  final String plantId;
  final String plantName;
  final double confidence;

  const ScannerResultScreen({
    Key? key,
    required this.plantId,
    required this.plantName,
    required this.confidence,
  }) : super(key: key);

  @override
  State<ScannerResultScreen> createState() => _ScannerResultScreenState();
}

class _ScannerResultScreenState extends State<ScannerResultScreen> {
  late Future<PlantModel?> _plantFuture;
  final PlantLocalDataSource _dataSource = PlantLocalDataSourceImpl();

  @override
  void initState() {
    super.initState();
    _plantFuture = _dataSource.getPlantById(widget.plantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Result'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<PlantModel?>(
        future: _plantFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final plant = snapshot.data;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Plant Image
                    if (plant != null && plant.imageUrl != null && plant.imageUrl!.isNotEmpty)
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade100,
                          image: DecorationImage(
                            image: AssetImage(plant.imageUrl!),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {},
                          ),
                        ),
                        child: plant.imageUrl == null
                            ? const Icon(
                                Icons.local_florist,
                                size: 80,
                                color: Colors.green,
                              )
                            : null,
                      )
                    else
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade100,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          size: 80,
                          color: Colors.green,
                        ),
                      ),
                    const SizedBox(height: 30),
                    // Detected Plant Name
                    Text(
                      widget.plantName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Confidence Score
                    Text(
                      'Confidence: ${(widget.confidence * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Confidence Indicator
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: widget.confidence,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation(Colors.green),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Buttons
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/plant-detail',
                            arguments: widget.plantId,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/scanner',
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Scan Another Plant',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home',
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Back to Home',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

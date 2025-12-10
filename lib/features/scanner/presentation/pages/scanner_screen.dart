import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../presentation/bloc/scanner_bloc.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read<ScannerBloc>().add(const InitializeCameraEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Plant'),
        backgroundColor: Colors.green,
      ),
      body: BlocListener<ScannerBloc, ScannerState>(
        listener: (context, state) {
          if (state is PlantDetected) {
            Navigator.of(context).pushNamed(
              '/scanner-result',
              arguments: {
                'plantId': state.detectedPlantId,
                'plantName': state.detectedPlantName,
                'confidence': state.confidence,
              },
            );
          } else if (state is ScannerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<ScannerBloc, ScannerState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state is CameraReady)
                            const Icon(
                              Icons.camera_alt,
                              size: 100,
                              color: Colors.green,
                            )
                          else if (state is DetectingPlant)
                            const Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 20),
                                Text('Detecting plant...'),
                              ],
                            )
                          else if (state is PlantImageCaptured)
                            const Icon(
                              Icons.check_circle,
                              size: 100,
                              color: Colors.green,
                            ),
                          const SizedBox(height: 20),
                          if (state is CameraReady)
                            const Text('Point camera at a plant')
                          else if (state is PlantImageCaptured)
                            const Text('Image captured - analyzing...'),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Capture from Camera
                      ElevatedButton.icon(
                        onPressed: (state is CameraReady)
                            ? () async {
                                final XFile? image =
                                    await _imagePicker.pickImage(
                                  source: ImageSource.camera,
                                );
                                if (image != null && mounted) {
                                  context.read<ScannerBloc>().add(
                                        CapturePlantImageEvent(image.path),
                                      );
                                  context.read<ScannerBloc>().add(
                                        DetectPlantEvent(image.path),
                                      );
                                }
                              }
                            : null,
                        icon: const Icon(Icons.camera_alt,color: Colors.black,),
                        label: const Text('Take Photo',style: TextStyle(color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Upload from Gallery
                      OutlinedButton.icon(
                        onPressed: (state is CameraReady)
                            ? () async {
                                final XFile? image =
                                    await _imagePicker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null && mounted) {
                                  context.read<ScannerBloc>().add(
                                        CapturePlantImageEvent(image.path),
                                      );
                                  context.read<ScannerBloc>().add(
                                        DetectPlantEvent(image.path),
                                      );
                                }
                              }
                            : null,
                        icon: const Icon(Icons.image,color: Colors.green,),
                        label: const Text('Upload from Gallery',style: TextStyle(color: Colors.green),),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

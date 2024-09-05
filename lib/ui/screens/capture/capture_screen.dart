part of '../screen.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  Position? _currentPosition;
  String _locationMessage = "";
  String _altitudeMessage = "Fetching data";
  String _speedMessage = "Fetching data";
  String _dateTimeMessage = "";
  String _detailedAddress = "Fetching data";
  double _compassHeading = 0.0;
  String _compassDirection = "N";
  late Timer _timer;
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  XFile? _imageFile;
  XFile? _videoFile;
  bool _isRecording = false;

  final GlobalKey _repaintKey = GlobalKey(); // Key for RepaintBoundary

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startCompass();
    _startTimer();
    _initializeCamera();
  }

  @override
  void dispose() {
    _timer.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras![0],
          ResolutionPreset.medium,
        );
        await _cameraController?.initialize();
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing camera');
        print(e);
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'Location services are disabled.';
        _altitudeMessage = 'Fetching data';
        _speedMessage = 'Fetching data';
        _dateTimeMessage = _formatDateTime(DateTime.now());
        _detailedAddress = 'Fetching data';
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        setState(() {
          _locationMessage = 'Location permissions are denied.';
          _altitudeMessage = 'Fetching data';
          _speedMessage = 'Fetching data';
          _dateTimeMessage = _formatDateTime(DateTime.now());
          _detailedAddress = 'Fetching data';
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double speed = position.speed;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];
    String detailedAddress =
        '${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

    setState(() {
      _currentPosition = position;
      _locationMessage =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      _altitudeMessage =
          'Altitude: ${position.altitude.toStringAsFixed(5)} meters';
      _speedMessage = 'Speed: ${speed.toStringAsFixed(2)} m/s';
      _detailedAddress = detailedAddress;
    });
  }

  void _startCompass() {
    FlutterCompass.events?.listen((event) {
      setState(() {
        _compassHeading = event.heading ?? 0.0;
        _compassDirection = _getCompassDirection(_compassHeading);
      });
    });
  }

  String _getCompassDirection(double heading) {
    if (heading >= 337.5 || heading < 22.5) return "N";
    if (heading >= 22.5 && heading < 67.5) return "NE";
    if (heading >= 67.5 && heading < 112.5) return "E";
    if (heading >= 112.5 && heading < 157.5) return "SE";
    if (heading >= 157.5 && heading < 202.5) return "S";
    if (heading >= 202.5 && heading < 247.5) return "SW";
    if (heading >= 247.5 && heading < 292.5) return "W";
    return "NW";
  }

  String _formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm:ss');
    return formatter.format(dateTime);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _dateTimeMessage = _formatDateTime(DateTime.now());
      });
    });
  }

  Future<void> _saveMetadata(
      String filename, Map<String, String> metadata) async {
    final directory = await getApplicationDocumentsDirectory();
    final metadataFile = File(path.join(directory.path, '$filename.txt'));

    final metadataContent = metadata.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join('\n');

    await metadataFile.writeAsString(metadataContent);
  }

  Future<void> _captureScreen() async {
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      // Capture the screen as an image
      RenderRepaintBoundary boundary = _repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the image to external storage
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        final file = File('${directory.path}/captured_image.png');
        await file.writeAsBytes(pngBytes);

        setState(() {
          _imageFile = XFile(file.path);
        });

        if (kDebugMode) {
          print('Photo saved at: ${file.path}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error capturing screen');
        print(e);
      }
    }
  }

  Future<void> _recordVideo() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      if (kDebugMode) {
        print('Camera is not initialized.');
      }
      return;
    }

    try {
      if (_isRecording) {
        try {
          await Future.delayed(const Duration(
              seconds: 1)); // Tambahkan delay sebelum stop recording
          final XFile videoFile = await _cameraController!.stopVideoRecording();

          final directory = await getExternalStorageDirectory();

          if (kDebugMode) {
            print('Stopping video recording...');
            print('Video file path: ${videoFile.path}');
            print('Video file size: ${await videoFile.length()} bytes');
          }

          if (directory != null) {
            if (kDebugMode) {
              print('Gagal mengakses direktori penyimpanan.');
            }

            final filename = '${DateTime.now().millisecondsSinceEpoch}.mp4';
            final file = File('${directory.path}/$filename');

            // Save the video file directly
            await videoFile.saveTo(file.path);

            // Check if the file exists and has a size greater than 0
            final savedFile = File(file.path);
            final savedFileSize = await savedFile.length();
            if (kDebugMode) {
              print('Video saved at: ${file.path}');
              print('Saved video file size: $savedFileSize bytes');
            }

            if (savedFileSize > 0) {
              setState(() {
                _videoFile = XFile(file.path);
                _isRecording = false;
              });

              // Save metadata
              await _saveMetadata(filename, {
                'Location': _locationMessage,
                'Altitude': _altitudeMessage,
                'Speed': _speedMessage,
                'DateTime': _dateTimeMessage,
                'Address': _detailedAddress,
              });
            } else {
              if (kDebugMode) {
                print('Video file size is 0, something went wrong.');
              }
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error recording video: $e');
          }
        }
      } else {
        try {
          await _cameraController!.prepareForVideoRecording();
          await _cameraController!.startVideoRecording();
          setState(() {
            _isRecording = true;
          });

          if (kDebugMode) {
            print('Recording started');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error starting video recording: $e');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error recording video: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get User Location'),
      ),
      body: RepaintBoundary(
        key: _repaintKey, // Assign the key to RepaintBoundary
        child: Stack(
          children: [
            // Camera preview as the background
            if (_cameraController != null &&
                _cameraController!.value.isInitialized)
              Positioned.fill(
                child: AspectRatio(
                  aspectRatio: 3 / 4, // Mengatur rasio aspek 4:3
                  child: CameraPreview(_cameraController!),
                ),
              ),

            // Data widgets on top of the camera preview
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_locationMessage,
                      style: const TextStyle(color: Colors.white)),
                  Text(_altitudeMessage,
                      style: const TextStyle(color: Colors.white)),
                  Text(_speedMessage,
                      style: const TextStyle(color: Colors.white)),
                  Text(_dateTimeMessage,
                      style: const TextStyle(color: Colors.white)),
                  Text(_detailedAddress,
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  const Text('Compass'),
                  Text(
                    '${(_compassHeading * (3.1415927 / 180) * -1).toStringAsFixed(2)}, $_compassDirection',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  CompassWidget2(
                    compassHeading: _compassHeading,
                    compassDirection: _compassDirection,
                  ),
                  const SizedBox(height: 20),
                  const Text('Map'),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12,
                            offset: Offset(5, 5),
                          )
                        ]),
                    width: 150,
                    height: 150,
                    padding: const EdgeInsets.all(5.0),
                    child: _currentPosition != null
                        ? FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(_currentPosition!.latitude,
                                  _currentPosition!.longitude),
                              initialZoom: 13,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                              ),
                            ],
                          )
                        : const Center(child: Text('Getting data...')),
                  ),
                  const SizedBox(height: 20),
                  if (_imageFile != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Image.file(
                        File(_imageFile!.path),
                        width: 100,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _captureScreen,
                        child: const Text('Capture Screen'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _recordVideo,
                        child: Text(
                            _isRecording ? 'Stop Recording' : 'Record Video'),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                  if (_videoFile != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Video recorded at: ${_videoFile!.path}'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompassWidget2 extends StatelessWidget {
  final double compassHeading;
  final String compassDirection;

  const CompassWidget2({
    Key? key,
    required this.compassHeading,
    required this.compassDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: (compassHeading * (3.1415927 / 180) * -1),
        child: Icon(
          Icons.navigation,
          size: 100,
          color: Colors.blue,
        ),
      ),
    );
  }
}

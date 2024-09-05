part of '../screen.dart';

class ConfigureScreen extends StatefulWidget {
  const ConfigureScreen({super.key});

  @override
  State<ConfigureScreen> createState() => _ConfigureScreenState();
}

class _ConfigureScreenState extends State<ConfigureScreen> {
  Position? _currentPosition;
  String _locationMessage = "";
  String _altitudeMessage = "Fetching data";
  String _speedMessage = "Fetching data";
  String _dateTimeMessage = "";
  String _detailedAddress = "Fetching data"; // Add this line
  double _compassHeading = 0.0; // To store the compass heading
  String _compassDirection = "N"; // Default direction
  late Timer _timer; // Timer to update the date and time

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startCompass();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
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
        // ignore: deprecated_member_use
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get User Location'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_locationMessage),
            Text(_altitudeMessage),
            Text(_speedMessage),
            Text(_dateTimeMessage),
            Text(_detailedAddress),
            const SizedBox(height: 20),
            const Text('Compass'),
            Text(
              '${(_compassHeading * (3.1415927 / 180) * -1).toStringAsFixed(2)}, $_compassDirection',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            CompassWidget(
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
          ],
        ),
      ),
    );
  }
}

class CompassWidget extends StatelessWidget {
  final double compassHeading;
  final String compassDirection;

  const CompassWidget({
    super.key,
    required this.compassHeading,
    required this.compassDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blueAccent, width: 2),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 0,
            child: Text(
              'N',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            child: Text(
              'S',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const Positioned(
            left: 5,
            child: Text(
              'W',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const Positioned(
            right: 7,
            child: Text(
              'E',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent, width: 2),
                color: Colors.transparent,
              ),
              child: Center(
                child: Transform.rotate(
                  angle: compassHeading * (3.1415927 / 180) * -1,
                  child: const Icon(
                    Icons.navigation,
                    size: 50,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

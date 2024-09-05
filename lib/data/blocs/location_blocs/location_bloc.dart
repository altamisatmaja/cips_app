part of '../bloc.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState()) {
    on<FetchLocationData>(_onFetchLocationData);
  }

  // To store the stream subscription
  StreamSubscription<double>? _compassSubscription;

  Future<void> _onFetchLocationData(
      FetchLocationData event, Emitter<LocationState> emit) async {
    try {
      // Fetch current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // Fetch address from position
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks.isNotEmpty ? placemarks[0] : Placemark();

      String address =
          "${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.subAdministrativeArea ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}";

      // Fetch compass heading
      double? compassHeading;
      _compassSubscription = FlutterCompass.events!.listen((event) {
        compassHeading = event.heading;
      }) as StreamSubscription<double>?;

      // Emit updated state
      emit(state.copyWith(
        position: position,
        address: address,
        compassHeading: compassHeading,
        speed: position.speed,
        altitude: position.altitude,
      ));
    } catch (e) {
      // Handle any errors here
      print('Error fetching location data: $e');
      // Optionally, emit an error state
    } finally {
      // Ensure to cancel the subscription when no longer needed
      _compassSubscription?.cancel();
    }
  }
}

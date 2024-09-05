part of '../bloc.dart';

class LocationState {
  final Position? position;
  final String? address;
  final double? compassHeading;
  final double? speed;
  final double? altitude;

  LocationState({
    this.position,
    this.address,
    this.compassHeading,
    this.speed,
    this.altitude,
  });

  factory LocationState.initial() {
    return LocationState(
      position: null,
      address: null,
      compassHeading: null,
      speed: null,
      altitude: null,
    );
  }

  LocationState copyWith({
    Position? position,
    String? address,
    double? compassHeading,
    double? speed,
    double? altitude,
  }) {
    return LocationState(
      position: position ?? this.position,
      address: address ?? this.address,
      compassHeading: compassHeading ?? this.compassHeading,
      speed: speed ?? this.speed,
      altitude: altitude ?? this.altitude,
    );
  }
}

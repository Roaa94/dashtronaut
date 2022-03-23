import 'package:Dashtronaut/models/location.dart';
import 'package:Dashtronaut/models/position.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Tile extends Equatable {
  final int value;
  final bool tileIsWhiteSpace;
  final Location correctLocation;
  final Location currentLocation;

  const Tile({
    required this.value,
    required this.correctLocation,
    required this.currentLocation,
    this.tileIsWhiteSpace = false,
  });

  bool get isAtCorrectLocation => correctLocation == currentLocation;

  /// Get the tile's position in the Stack widget
  /// based on its width and current location
  Position getPosition(BuildContext context, double tileWidth) {
    return Position(
        top: (currentLocation.y - 1) * tileWidth,
        left: (currentLocation.x - 1) * tileWidth);
  }

  Tile copyWith({
    value,
    width,
    correctLocation,
    currentLocation,
    tileIsWhiteSpace,
  }) {
    return Tile(
      value: value ?? this.value,
      correctLocation: correctLocation ?? this.correctLocation,
      currentLocation: currentLocation ?? this.currentLocation,
      tileIsWhiteSpace: tileIsWhiteSpace ?? this.tileIsWhiteSpace,
    );
  }

  @override
  String toString() {
    return 'Tile(value: $value, correctLocation: $correctLocation, currentLocation: $currentLocation)';
  }

  factory Tile.fromJson(Map<String, dynamic> json) {
    return Tile(
      value: json['value'],
      tileIsWhiteSpace: json['tileIsWhiteSpace'],
      correctLocation: Location.fromJson(json['correctLocation']),
      currentLocation: Location.fromJson(json['currentLocation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'tileIsWhiteSpace': tileIsWhiteSpace,
      'correctLocation': correctLocation.toJson(),
      'currentLocation': currentLocation.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        value,
        tileIsWhiteSpace,
        correctLocation,
        currentLocation,
      ];
}

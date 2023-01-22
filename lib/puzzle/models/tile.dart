import 'dart:convert';

import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/position.dart';
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

  static List<dynamic> toJsonList(List<Tile> scores) =>
      List<dynamic>.from(scores.map((x) => x.toJson()));

  static List<Tile> fromJsonList(dynamic scores) => List<Tile>.from(
    json.decode(json.encode(scores)).map((x) => Tile.fromJson(x)),
  );
}

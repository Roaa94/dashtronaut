import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Vector extends Equatable {
  final double x;
  final double y;
  final double z;

  const Vector(this.x, this.y, this.z);

  factory Vector.zero() => const Vector(0, 0, 0);

  factory Vector.fromGyroscopeEvent(GyroscopeEvent event) => Vector(sin(event.x), sin(event.y), sin(event.z));

  Vector combineWith(Vector _otherVector) => Vector(x + _otherVector.x, y, z);

  @override
  String toString() => 'Vector(${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}, ${z.toStringAsFixed(2)})';

  bool greaterThan(Vector _otherVector) {
    double difference = 0.1;
    return (x - _otherVector.x).abs() > difference && (y - _otherVector.y).abs() > difference && (z - _otherVector.z).abs() > difference;
  }

  Matrix4 get transform => Matrix4.translationValues(x, y, z);

  @override
  List<Object?> get props => [x, y, z];
}

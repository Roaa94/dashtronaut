import 'package:flutter/cupertino.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Vector {
  double x;
  double y;
  double z;

  Vector(this.x, this.y, this.z);

  factory Vector.zero() => Vector(0, 0, 0);

  factory Vector.fromGyroscopeEvent(GyroscopeEvent event) => Vector(event.x, event.y, event.z);

  Vector combineWith(Vector _otherVector) => Vector(x + _otherVector.x, y, z);

  @override
  String toString() => 'Vector(${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}, ${z.toStringAsFixed(2)})';

  bool greaterThan(Vector _otherVector) {
    double difference = 0.5;
    return (x - _otherVector.x).abs() > difference && (y - _otherVector.y).abs() > difference && (z - _otherVector.z).abs() > difference;
  }

  Matrix4 get transform => Matrix4.translationValues(x, y, z);
}

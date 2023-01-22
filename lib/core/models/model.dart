import 'package:equatable/equatable.dart';

abstract class Model extends Equatable {
  const Model();

  Map<String, dynamic> toJson();
}

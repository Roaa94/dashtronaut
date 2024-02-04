import 'dart:developer';

import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';

const solvable3x3Puzzle = [
  Tile(
    value: 1,
    correctLocation: Location(x: 1, y: 1),
    currentLocation: Location(x: 1, y: 3),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 2,
    correctLocation: Location(x: 2, y: 1),
    currentLocation: Location(x: 3, y: 1),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 3,
    correctLocation: Location(x: 3, y: 1),
    currentLocation: Location(x: 3, y: 2),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 4,
    correctLocation: Location(x: 1, y: 2),
    currentLocation: Location(x: 2, y: 2),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 5,
    correctLocation: Location(x: 2, y: 2),
    currentLocation: Location(x: 2, y: 3),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 6,
    correctLocation: Location(x: 3, y: 2),
    currentLocation: Location(x: 1, y: 2),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 7,
    correctLocation: Location(x: 1, y: 3),
    currentLocation: Location(x: 1, y: 1),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 8,
    correctLocation: Location(x: 2, y: 3),
    currentLocation: Location(x: 3, y: 3),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 9,
    correctLocation: Location(x: 3, y: 3),
    currentLocation: Location(x: 2, y: 1),
    tileIsWhiteSpace: true,
  ),
];

const fake3x3Puzzle = Puzzle(n: 3, tiles: solvable3x3Puzzle);

class FakePuzzleStorageRepository extends PuzzleStorageRepository {
  FakePuzzleStorageRepository({
    this.puzzle = fake3x3Puzzle,
  }) : super(FakeStorageService());

  final Puzzle puzzle;

  @override
  Puzzle? get() => puzzle;

  @override
  void update(Map<String, dynamic> data) {
    log('Attempted to update fake puzzle repository with:');
    log(data.toString());
  }
}

class FakeStorageService extends StorageService {
  @override
  Future<void> clear() async {
    log('Clear fake storage attempted...');
  }

  @override
  Future<void> close() async {
    log('Close fake storage attempted...');
  }

  @override
  get(String key) {
    log('Get [$key] from fake storage attempted...');
  }

  @override
  getAll() => log('Get all data from fake storage attempted...');

  @override
  bool has(String key) => false;

  @override
  Future<void> init() async => log('Fake init storage attempted...');

  @override
  Future<void> remove(String key) async {
    log('Fake storage remove [$key] attempted...');
  }

  @override
  Future<void> set(String? key, data) async {
    log('Fake storage set [$key] attempted...');
  }
}

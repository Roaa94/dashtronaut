import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

/// Model for a Puzzle
class Puzzle extends Equatable {
  final int? n;
  final List<Tile> tiles;
  final int movesCount;

  const Puzzle({
    required this.n,
    required this.tiles,
    this.movesCount = 0,
  });

  factory Puzzle.fromJson(Map<String, dynamic> json) {
    return Puzzle(
      tiles: json['tiles'] == null ? [] : Tile.fromJsonList(json['tiles']),
      movesCount: json['movesCount'] ?? 0,
      n: json['n'],
    );
  }

  Puzzle copyWith({
    List<Tile>? tiles,
    int? n,
    int? movesCount,
  }) {
    return Puzzle(
      n: n ?? this.n,
      tiles: tiles ?? this.tiles,
      movesCount: movesCount ?? this.movesCount,
    );
  }

  Map<String, dynamic> toJson() => {
        'tiles': List<dynamic>.from(tiles.map((x) => x.toJson())),
        'movesCount': movesCount,
        'n': n,
      };

  @override
  List<Object?> get props => [n, movesCount, tiles];
}

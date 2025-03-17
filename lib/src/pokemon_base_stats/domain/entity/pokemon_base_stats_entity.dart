import 'package:equatable/equatable.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/utils/pair.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_value_entity.dart';

class PokemonBaseStatsEntity extends Equatable {
  const PokemonBaseStatsEntity({
    required this.pokemon,
    required this.multipliers,
    required this.statsMap,
    required this.minStat,
    required this.summation,
  });

  final Pokemon pokemon;
  final List<Pair<String, double>> multipliers;
  final Map<String, PokemonBaseStatsValueEntity?> statsMap;
  final int minStat;
  final int summation;

  @override
  List<Object?> get props =>
      [pokemon, multipliers, statsMap, minStat, summation];
}

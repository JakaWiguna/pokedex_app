import 'package:flutter/material.dart';
import 'package:pokedex_app/core/common/widgets/stat_line.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_value_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/common/pokemon_base_stats_colors.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/common/pokemon_base_stats_strings.dart';

class PokemonBaseStatsStatList extends StatelessWidget {
  const PokemonBaseStatsStatList({
    required this.stats,
    super.key,
  });

  final PokemonBaseStatsEntity stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stats.statsMap['hp'] != null) ...{
          _buildStat(
            stats.statsMap['hp']!,
            PokemonBaseStatsStrings.hp,
            PokemonBaseStatsColors.hpColor,
            stats.minStat,
          ),
        },
        if (stats.statsMap['attack'] != null) ...{
          _buildStat(
            stats.statsMap['attack']!,
            PokemonBaseStatsStrings.attack,
            PokemonBaseStatsColors.attackColor,
            stats.minStat,
          ),
        },
        if (stats.statsMap['defense'] != null) ...{
          _buildStat(
            stats.statsMap['defense']!,
            PokemonBaseStatsStrings.defense,
            PokemonBaseStatsColors.defenseColor,
            stats.minStat,
          ),
        },
        if (stats.statsMap['special-attack'] != null) ...{
          _buildStat(
            stats.statsMap['special-attack']!,
            PokemonBaseStatsStrings.specialAttack,
            PokemonBaseStatsColors.specialAttackColor,
            stats.minStat,
          ),
        },
        if (stats.statsMap['special-defense'] != null) ...{
          _buildStat(
            stats.statsMap['special-defense']!,
            PokemonBaseStatsStrings.specialDefense,
            PokemonBaseStatsColors.specialDefenseColor,
            stats.minStat,
          ),
        },
        if (stats.statsMap['speed'] != null) ...{
          _buildStat(
            stats.statsMap['speed']!,
            PokemonBaseStatsStrings.speed,
            PokemonBaseStatsColors.speedColor,
            stats.minStat,
          ),
        },
        _buildStatTotalRow(
          PokemonBaseStatsStrings.total,
          PokemonBaseStatsColors.totalColor,
          stats.summation,
          1000,
        ),
      ],
    );
  }

  Widget _buildStat(
    PokemonBaseStatsValueEntity statsValueEntity,
    String title,
    Color color,
    int totalValue,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: StatLine(
        color: color,
        title: title,
        value: statsValueEntity.value,
        totalValue: totalValue,
      ),
    );
  }

  Widget _buildStatTotalRow(
    String title,
    Color color,
    int value,
    int totalValue,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: StatLine(
        color: color,
        title: title,
        value: value,
        totalValue: totalValue,
      ),
    );
  }
}

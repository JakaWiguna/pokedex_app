import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/common/widgets/stat_line.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';
import 'package:pokedex_app/core/res/color.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_value_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/common/pokemon_base_stats_strings.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/cubit/pokemon_base_stats_cubit.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/widgets/pokemon_base_stats_types_list.dart';

class PokemonBaseStatsContent extends StatefulWidget {
  const PokemonBaseStatsContent({
    required this.pokemon,
    super.key,
  });

  final Pokemon pokemon;

  @override
  State<PokemonBaseStatsContent> createState() =>
      _PokemonBaseStatsContentState();
}

class _PokemonBaseStatsContentState extends State<PokemonBaseStatsContent> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stats = (context.watch<PokemonBaseStatsCubit>().state
            as PokemonBaseStatsSuccess)
        .data;

    final textTheme = Theme.of(context).textTheme;
    final sectionTheme = textTheme.titleMedium?.copyWith(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
    final multipliers = stats.multipliers.toList();
    final hasImmune = multipliers.any((element) => element.second == 0.0);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.l,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (stats.statsMap['hp'] != null) ...{
            _buildStat(
              stats.statsMap['hp']!,
              PokemonBaseStatsStrings.hp,
              Colors.red.shade400,
              stats.minStat,
            ),
          },
          if (stats.statsMap['attack'] != null) ...{
            _buildStat(
              stats.statsMap['attack']!,
              PokemonBaseStatsStrings.attack,
              Colors.green.shade400,
              stats.minStat,
            ),
          },
          if (stats.statsMap['defense'] != null) ...{
            _buildStat(
              stats.statsMap['defense']!,
              PokemonBaseStatsStrings.defense,
              Colors.red.shade400,
              stats.minStat,
            ),
          },
          if (stats.statsMap['special-attack'] != null) ...{
            _buildStat(
              stats.statsMap['special-attack']!,
              PokemonBaseStatsStrings.specialAttack,
              Colors.green.shade400,
              stats.minStat,
            ),
          },
          if (stats.statsMap['special-defense'] != null) ...{
            _buildStat(
              stats.statsMap['special-defense']!,
              PokemonBaseStatsStrings.specialDefense,
              Colors.red.shade400,
              stats.minStat,
            ),
          },
          if (stats.statsMap['speed'] != null) ...{
            _buildStat(
              stats.statsMap['speed']!,
              PokemonBaseStatsStrings.speed,
              Colors.green.shade400,
              stats.minStat,
            ),
          },
          _buildStatTotalRow(
            'Total',
            Colors.amber,
            stats.summation,
            1000,
          ),
          const SizedBox(height: AppSpacing.l),
          Text(PokemonBaseStatsStrings.typeEffectiveness, style: sectionTheme),
          const SizedBox(height: AppSpacing.m),
          Text(
            '${PokemonBaseStatsStrings.typeEffectivenessOnType} ${stats.pokemon.name.capitalize()}',
            style: textTheme.bodyLarge
                ?.copyWith(color: ColorRes.textGrey, fontSize: 14),
          ),
          const SizedBox(height: AppSpacing.m),
          PokemonBaseStatsTypesList(
            defenses: stats.multipliers.toList(),
          ),
          if (hasImmune) ...{
            Text(
              PokemonBaseStatsStrings.immune,
              style: textTheme.labelSmall?.copyWith(color: ColorRes.textGrey),
            ),
            const SizedBox(height: AppSpacing.m),
          },
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
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

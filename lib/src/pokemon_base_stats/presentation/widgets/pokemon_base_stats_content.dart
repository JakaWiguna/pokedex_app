import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/cubit/pokemon_base_stats_cubit.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/widgets/pokemon_base_stats_stat_list.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/widgets/pokemon_base_stats_type_effectiveness.dart';

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

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.l,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PokemonBaseStatsStatList(stats: stats),
          const SizedBox(height: AppSpacing.l),
          PokemonBaseStatsTypeEffectiveness(stats: stats),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/common/views/error_page.dart';
import 'package:pokedex_app/core/common/views/loading_page.dart';
import 'package:pokedex_app/src/pokemon/presentation/common/pokemon_type_extension.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/cubit/pokemon_base_stats_cubit.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/widgets/pokemon_base_stats_content.dart';

class PokemonBaseStatsScreen extends StatefulWidget {
  const PokemonBaseStatsScreen({
    required this.pokemon,
    super.key,
  });

  final Pokemon pokemon;

  @override
  State<PokemonBaseStatsScreen> createState() => _PokemonBaseStatsScreenState();
}

class _PokemonBaseStatsScreenState extends State<PokemonBaseStatsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<PokemonBaseStatsCubit>().getStats(widget.pokemon);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PokemonBaseStatsCubit, PokemonBaseStatsState>(
      builder: (context, state) {
        if (state.runtimeType == PokemonBaseStatsSuccess) {
          return PokemonBaseStatsContent(pokemon: widget.pokemon);
        } else if (state.runtimeType == PokemonBaseStatsFailure) {
          return ErrorPage(
            assetSize: 120,
            onTap: () =>
                context.read<PokemonBaseStatsCubit>().getStats(widget.pokemon),
          );
        }
        return LoadingPage(color: widget.pokemon.types.first.color.primary);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

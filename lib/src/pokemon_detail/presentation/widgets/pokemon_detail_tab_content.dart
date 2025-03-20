import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/common/views/page_under_construction.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/views/pokemon_about_screen.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/views/pokemon_base_stats_screen.dart';

class PokemonDetailTabContent extends StatelessWidget {
  const PokemonDetailTabContent({
    required this.tabController,
    required this.pokemon,
    super.key,
  });

  final TabController tabController;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: [
          PokemonAboutScreen(pokemon: pokemon),
          PokemonBaseStatsScreen(pokemon: pokemon),
          const PageUnderConstruction(),
          const PageUnderConstruction(),
        ],
      ),
    );
  }
}

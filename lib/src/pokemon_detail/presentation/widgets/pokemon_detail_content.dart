import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_app_bar.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_background.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_dotted_decoration.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_panel.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_pokeball_decoration.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_pokemon_image.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_pokemon_info.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonDetailContent extends StatelessWidget {
  const PokemonDetailContent({
    required this.screenWidth,
    required this.screenHeight,
    required this.panelMinHeight,
    required this.panelMaxHeight,
    required this.appBarHeight,
    required this.isPortrait,
    required this.safeAreaTop,
    required this.pokemon,
    required this.isFavorite,
    required this.slidePosition,
    required this.onFavoriteToggle,
    required this.panelController,
    required this.tabController,
    super.key,
  });

  final double screenWidth;
  final double screenHeight;
  final double panelMinHeight;
  final double panelMaxHeight;
  final double appBarHeight;
  final bool isPortrait;
  final double safeAreaTop;
  final Pokemon pokemon;
  final bool isFavorite;
  final double slidePosition;
  final VoidCallback onFavoriteToggle;
  final PanelController panelController;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PokemonDetailBackground(pokemon: pokemon),
        PokemonDetailPokeballDecoration(
          screenHeight: screenHeight,
          isPortrait: isPortrait,
          slidePosition: slidePosition,
        ),
        PokemonDetailDottedDecoration(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          isPortrait: isPortrait,
          slidePosition: slidePosition,
        ),
        PokemonDetailAppBar(
          pokemon: pokemon,
          isFavorite: isFavorite,
          onFavoriteToggle: onFavoriteToggle,
          slidePosition: slidePosition,
        ),
        PokemonDetailPokemonInfo(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          appBarHeight: appBarHeight,
          isPortrait: isPortrait,
          pokemon: pokemon,
          slidePosition: slidePosition,
        ),
        PokemonDetailPanel(
          minHeight: panelMinHeight,
          maxHeight: panelMaxHeight,
          panelController: panelController,
          tabController: tabController,
          pokemon: pokemon,
        ),
        PokemonDetailPokemonImage(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          isPortrait: isPortrait,
          pokemon: pokemon,
          slidePosition: slidePosition,
        ),
      ],
    );
  }
}

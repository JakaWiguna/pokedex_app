import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/common/widgets/app_bar.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/common/pokemon_detail_colors.dart';

class PokemonDetailAppBar extends StatelessWidget {
  const PokemonDetailAppBar({
    required this.pokemon,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.slidePosition,
    super.key,
  });

  final Pokemon pokemon;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final double slidePosition;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MovingTitleSliverAppBar(
          systemUiOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          leading: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: PokemonDetailColors.appBarIconColor,
          ),
          trailing: Icon(
            isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            color: isFavorite
                ? Colors.indigo.shade300
                : PokemonDetailColors.favoriteIconColor,
          ),
          onTrailingPressed: onFavoriteToggle,
          title: pokemon.name.capitalize(),
          colorTitle: PokemonDetailColors.pokemonNameColor,
          scrollOffset: 1 - slidePosition,
        ),
      ],
    );
  }
}

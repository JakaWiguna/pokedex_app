import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/common/widgets/badge_type.dart';
import 'package:pokedex_app/core/extensions/int_extension.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';
import 'package:pokedex_app/core/res/media.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon/presentation/common/pokemon_type_extension.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({required this.pokemon, super.key});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemHeight = constraints.maxHeight;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.m),
            color: pokemon.types.first.color.secondary,
            boxShadow: [
              BoxShadow(
                color:
                    pokemon.types.first.color.secondary.withValues(alpha: 0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.m),
            child: Material(
              color: pokemon.types.first.color.secondary,
              child: InkWell(
                onTap: () {},
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildPokeballDecoration(height: itemHeight),
                    _buildPokemon(height: itemHeight),
                    _buildPokemonNumber(width: itemHeight),
                    _buildCardContent(pokemon: pokemon, height: itemHeight),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPokeballDecoration({required double height}) {
    final pokeballSize = height * 0.75;

    return Positioned(
      bottom: -height * 0.13,
      right: -height * 0.03,
      child: Image(
        image: const AssetImage(MediaRes.pokeball),
        width: pokeballSize,
        height: pokeballSize,
        color: Colors.white.withValues(alpha: 0.14),
      ),
    );
  }

  Widget _buildPokemon({required double height}) {
    final pokemonSize = height * 0.70;

    return Positioned(
      bottom: -2,
      right: 2,
      child: SizedBox(
        width: pokemonSize,
        height: pokemonSize,
        child: CachedNetworkImage(
          imageUrl: pokemon.id.thumbnailUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildPokemonNumber({required double width}) {
    final pokemonNumberSize = width * 0.13;
    return Positioned(
      top: 10,
      right: 14,
      child: Text(
        pokemon.id.pokenumber,
        style: TextStyle(
          fontSize: pokemonNumberSize,
          fontWeight: FontWeight.bold,
          color: Colors.black.withValues(alpha: 0.1),
        ),
      ),
    );
  }

  Widget _buildCardContent({required Pokemon pokemon, required double height}) {
    final pokemonNameSize = height * 0.13;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.m,
          AppSpacing.l,
          AppSpacing.m,
          AppSpacing.m,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: pokemon.name,
              child: Text(
                pokemon.name.capitalize(),
                style: TextStyle(
                  fontSize: pokemonNameSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: pokemon.types.asMap().entries.map((entry) {
                final index = entry.key;
                final type = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BadgeType(
                      type: type.type.name,
                      height: height,
                    ),
                    if (index < pokemon.types.length - 1)
                      const SizedBox(height: AppSpacing.xs),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/src/pokemon/presentation/common/pokemon_type_extension.dart';

class PokemonDetailBackground extends StatelessWidget {
  const PokemonDetailBackground({required this.pokemon, super.key});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pokemon.types.first.color.secondary,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

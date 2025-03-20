import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/cubit/pokemon_about_cubit.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/widgets/pokemon_about_basic_info_section.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/widgets/pokemon_about_breeding_section.dart';

class PokemonAboutContent extends StatelessWidget {
  const PokemonAboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    final about =
        (context.watch<PokemonAboutCubit>().state as PokemonAboutSuccess).data;
    final pokemon = about.pokemon;
    final species = about.pokemonSpecies;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PokemonAboutBasicInfoSection(
            pokemon: pokemon,
            species: species,
          ),
          const SizedBox(height: AppSpacing.l),
          PokemonAboutBreedingSection(species: species),
        ],
      ),
    );
  }
}

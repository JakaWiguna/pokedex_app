import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/core/utils/format_utlis.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/common/pokemon_about_strings.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/cubit/pokemon_about_cubit.dart';

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
          if (species != null) ...{
            _infoRow(
              PokemonAboutStrings.species,
              species.genera
                  .firstWhereOrNull(
                    (element) => element.language.name == 'en',
                  )
                  ?.genus,
            ),
          },
          _infoRow(PokemonAboutStrings.height, formatHeight(pokemon.height)),
          _infoRow(PokemonAboutStrings.weight, formatWeight(pokemon.weight)),
          _infoRow(
            PokemonAboutStrings.abilities,
            pokemon.abilities
                .map((e) => e.ability.name.capitalize())
                .join(', '),
          ),
          const SizedBox(height: 16),
          _sectionTitle(PokemonAboutStrings.breeding),
          if (species != null) ...{
            _genderRow(species.genderRate),
          },
          if (species != null) ...{
            _infoRow(
              PokemonAboutStrings.eggGroups,
              species.eggGroups.map((e) => e.name.capitalize()).join(', '),
            ),
          },
          if (species != null) ...{
            _infoRow(
              PokemonAboutStrings.eggCycle,
              species.hatchCounter.toString(),
            ),
          },
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderRow(int genderRate) {
    final malePercentage = 100 - (genderRate * 12.5);
    final femalePercentage = genderRate * 12.5;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              PokemonAboutStrings.gender,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              spacing: AppSpacing.m,
              children: [
                _genderIconWithPercentage(
                  FontAwesomeIcons.mars,
                  Colors.blue,
                  malePercentage,
                ),
                const SizedBox(width: AppSpacing.m),
                _genderIconWithPercentage(
                  FontAwesomeIcons.venus,
                  Colors.pink,
                  femalePercentage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderIconWithPercentage(
    IconData icon,
    Color color,
    double percentage,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 4),
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

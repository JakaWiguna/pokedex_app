import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';
import 'package:pokedex_app/core/utils/format_utlis.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/common/pokemon_about_strings.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/widgets/pokemon_about_info_row.dart';

class PokemonAboutBasicInfoSection extends StatelessWidget {
  const PokemonAboutBasicInfoSection({
    required this.pokemon,
    required this.species,
    super.key,
  });

  final Pokemon pokemon;
  final PokemonSpecies? species;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (species != null) ...{
          PokemonAboutInfoRow(
            label: PokemonAboutStrings.species,
            value: species!.genera
                .firstWhereOrNull(
                  (element) => element.language.name == 'en',
                )
                ?.genus,
          ),
        },
        PokemonAboutInfoRow(
          label: PokemonAboutStrings.height,
          value: formatHeight(pokemon.height),
        ),
        PokemonAboutInfoRow(
          label: PokemonAboutStrings.weight,
          value: formatWeight(pokemon.weight),
        ),
        PokemonAboutInfoRow(
          label: PokemonAboutStrings.abilities,
          value: pokemon.abilities
              .map((e) => e.ability.name.capitalize())
              .join(', '),
        ),
      ],
    );
  }
}

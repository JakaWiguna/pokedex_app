import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/common/pokemon_about_strings.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/widgets/pokemon_about_gender_row.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/widgets/pokemon_about_info_row.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/widgets/pokemon_about_section_title.dart';

class PokemonAboutBreedingSection extends StatelessWidget {
  const PokemonAboutBreedingSection({
    required this.species,
    super.key,
  });

  final PokemonSpecies? species;

  @override
  Widget build(BuildContext context) {
    if (species == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PokemonAboutSectionTitle(title: PokemonAboutStrings.breeding),
        PokemonAboutGenderRow(genderRate: species!.genderRate),
        PokemonAboutInfoRow(
          label: PokemonAboutStrings.eggGroups,
          value: species!.eggGroups.map((e) => e.name.capitalize()).join(', '),
        ),
        PokemonAboutInfoRow(
          label: PokemonAboutStrings.eggCycle,
          value: species!.hatchCounter.toString(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/common/pokemon_detail_colors.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/common/pokemon_detail_strings.dart';

class PokemonDetailTabs extends StatelessWidget {
  const PokemonDetailTabs({
    required this.tabController,
    super.key,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          padding: const EdgeInsets.only(top: AppSpacing.l),
          controller: tabController,
          labelColor: PokemonDetailColors.tabLabelColor,
          dividerColor: Colors.transparent,
          unselectedLabelColor: PokemonDetailColors.tabUnselectedLabelColor,
          indicatorColor: PokemonDetailColors.indicatorColor,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2,
              color: PokemonDetailColors.indicatorColor,
            ),
          ),
          tabs: const [
            Tab(child: FittedBox(child: Text(PokemonDetailStrings.aboutTab))),
            Tab(
              child: FittedBox(child: Text(PokemonDetailStrings.baseStatsTab)),
            ),
            Tab(
              child: FittedBox(child: Text(PokemonDetailStrings.evolutionTab)),
            ),
            Tab(child: FittedBox(child: Text(PokemonDetailStrings.movesTab))),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: Divider(
            thickness: 0.5,
            height: 1,
            color: PokemonDetailColors.dividerColor,
          ),
        ),
      ],
    );
  }
}

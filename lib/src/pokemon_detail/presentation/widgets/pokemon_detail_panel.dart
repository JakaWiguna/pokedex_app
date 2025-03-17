import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/common/views/page_under_construction.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/views/pokemon_about_screen.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/views/pokemon_base_stats_screen.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonDetailPanel extends StatelessWidget {
  const PokemonDetailPanel({
    required this.minHeight,
    required this.maxHeight,
    required this.panelController,
    required this.tabController,
    required this.pokemon,
    super.key,
  });

  final double minHeight;
  final double maxHeight;
  final PanelController panelController;
  final TabController tabController;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: panelController,
      minHeight: minHeight,
      maxHeight: maxHeight,
      boxShadow: null,
      borderRadius:
          const BorderRadius.vertical(top: Radius.circular(AppSpacing.l)),
      panelBuilder: (sc) => _pokemonDetails(tabController),
      onPanelSlide: (position) =>
          context.read<PokemonDetailCubit>().updateSlidePosition(position),
    );
  }

  Widget _pokemonDetails(TabController tabController) {
    return Column(
      children: [
        TabBar(
          padding: const EdgeInsets.only(top: AppSpacing.l),
          controller: tabController,
          labelColor: Colors.black,
          dividerColor: Colors.transparent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.indigo.shade300,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2,
              color: Colors.indigo.shade300,
            ),
          ),
          tabs: const [
            Tab(child: FittedBox(child: Text('About'))),
            Tab(child: FittedBox(child: Text('Base Stats'))),
            Tab(child: FittedBox(child: Text('Evolution'))),
            Tab(child: FittedBox(child: Text('Moves'))),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: Divider(
            thickness: 0.5,
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              PokemonAboutScreen(pokemon: pokemon),
              PokemonBaseStatsScreen(pokemon: pokemon),
              const PageUnderConstruction(),
              const PageUnderConstruction(),
            ],
          ),
        ),
      ],
    );
  }
}

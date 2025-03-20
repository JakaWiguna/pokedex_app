import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_tab_content.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_tabs.dart';
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
      panelBuilder: (sc) => _buildPanelContent(),
      onPanelSlide: (position) =>
          context.read<PokemonDetailCubit>().updateSlidePosition(position),
    );
  }

  Widget _buildPanelContent() {
    return Column(
      children: [
        PokemonDetailTabs(tabController: tabController),
        PokemonDetailTabContent(
          tabController: tabController,
          pokemon: pokemon,
        ),
      ],
    );
  }
}

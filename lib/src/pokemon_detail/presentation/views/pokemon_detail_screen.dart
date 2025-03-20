import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/core/common/views/error_page.dart';
import 'package:pokedex_app/core/common/views/loading_page.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/widgets/pokemon_detail_content.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({required this.id, super.key});

  final int id;

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen>
    with SingleTickerProviderStateMixin {
  final PanelController _panelController = PanelController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<PokemonDetailCubit>()
      ..init()
      ..getPokemon(widget.id);
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final safeAreaTop = mediaQuery.padding.top;
    final appBarHeight = AppBar().preferredSize.height;

    final panelMinHeight = screenHeight * 0.54;
    final panelMaxHeight = screenHeight - appBarHeight - safeAreaTop;

    return Scaffold(
      body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final status = state.status;
          final pokemon = state.result;

          if (status == PokemonDetailStateStatus.loading) {
            return _buildLoading();
          } else if (status == PokemonDetailStateStatus.failure) {
            return _buildError();
          } else if (status == PokemonDetailStateStatus.initial) {
            return _buildInit();
          }

          return PokemonDetailContent(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            panelMinHeight: panelMinHeight,
            panelMaxHeight: panelMaxHeight,
            appBarHeight: appBarHeight,
            isPortrait: isPortrait,
            safeAreaTop: safeAreaTop,
            pokemon: pokemon,
            isFavorite: state.isFavorite,
            slidePosition: state.slidePosition,
            onFavoriteToggle: () =>
                context.read<PokemonDetailCubit>().toggleFavorite(),
            panelController: _panelController,
            tabController: _tabController,
          );
        },
      ),
    );
  }

  Widget _buildInit() => const SizedBox.shrink();

  Widget _buildLoading() => const LoadingPage();

  Widget _buildError() => ErrorPage(
        onTap: () => context.read<PokemonDetailCubit>()..getPokemon(widget.id),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_app/core/common/views/loading_page.dart';
import 'package:pokedex_app/core/common/widgets/app_bar.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon/presentation/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/src/pokemon/presentation/common/pokemon_strings.dart';
import 'package:pokedex_app/src/pokemon/presentation/widgets/pokemon_card.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollListener);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<PokemonBloc>().state;
    final status = state.status;
    final orientation = MediaQuery.of(context).orientation;

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          slivers: [
            MovingTitleSliverAppBar(
              trailing: const Icon(
                FontAwesomeIcons.list,
                color: Colors.black,
              ),
              onTrailingPressed: () => {},
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.l,
                vertical: AppSpacing.m,
              ),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (orientation == Orientation.portrait) ? 2 : 4,
                  childAspectRatio:
                      (orientation == Orientation.portrait) ? 1.3 : 1.6,
                  crossAxisSpacing: AppSpacing.s,
                  mainAxisSpacing: AppSpacing.s,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final pokemon = state.result[index];
                    return PokemonCard(pokemon: pokemon);
                  },
                  childCount: state.result.length,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, __) {
                  final Widget tailWidget;
                  if (!state.firstPage &&
                      status == PokemonStateStatus.loading) {
                    tailWidget = const Padding(
                      padding: EdgeInsets.all(AppSpacing.s),
                      child: LoadingPage(),
                    );
                  } else if (!state.firstPage &&
                      status == PokemonStateStatus.failure) {
                    tailWidget = Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.m,
                        horizontal: AppSpacing.l,
                      ),
                      child: Column(
                        children: [
                          Text(
                            PokemonStrings.paginationErrorTitle,
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: AppSpacing.m),
                          Text(
                            PokemonStrings.paginationError,
                            style: textTheme.bodyMedium?.copyWith(),
                          ),
                          const SizedBox(height: AppSpacing.l),
                          FilledButton(
                            onPressed: () => context
                                .read<PokemonBloc>()
                                .add(const PokemonsRequestEvent()),
                            child: const Text(PokemonStrings.tryAgain),
                          ),
                        ],
                      ),
                    );
                  } else {
                    tailWidget = const SizedBox.shrink();
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.xl),
                    child: tailWidget,
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        );
      },
    );
  }

  void _onScrollListener() {
    if (_isBottomReached) {
      _requestPokemons();
    }
  }

  bool get _isBottomReached {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _requestPokemons() {
    context.read<PokemonBloc>().add(const PokemonsRequestEvent());
  }
}

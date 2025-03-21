import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_app/core/common/views/error_page.dart';
import 'package:pokedex_app/core/common/views/loading_page.dart';
import 'package:pokedex_app/core/common/widgets/scaffold.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/src/pokemon/presentation/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/src/pokemon/presentation/common/pokemon_colors.dart';
import 'package:pokedex_app/src/pokemon/presentation/widgets/pokemon_list.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonBloc>().add(const PokemonsRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaBottom = MediaQuery.paddingOf(context).bottom;
    return PokeballScaffold(
      body: BlocBuilder<PokemonBloc, PokemonState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final status = state.status;
          if (state.firstPage) {
            if (status == PokemonStateStatus.loading) {
              return _buildLoading();
            } else if (status == PokemonStateStatus.failure) {
              return _buildError();
            } else if (status == PokemonStateStatus.initial) {
              return _buildInit();
            }
          }
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: _refreshPokemons,
                child: const PokemonList(),
              ),
              Positioned(
                right: AppSpacing.l,
                bottom: AppSpacing.l + safeAreaBottom,
                child: FloatingActionButton(
                  foregroundColor: PokemonColors.cardTextColor,
                  backgroundColor: Colors.indigo.shade300,
                  onPressed: () {},
                  shape: const CircleBorder(),
                  child: const Icon(FontAwesomeIcons.sliders),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInit() => const SizedBox.shrink();

  Widget _buildLoading() => const LoadingPage();

  Widget _buildError() => ErrorPage(
        onTap: () =>
            context.read<PokemonBloc>()..add(const PokemonsRequestEvent()),
      );

  Future<void> _refreshPokemons() async {
    context.read<PokemonBloc>().add(const PokemonsPullRefreshEvent());
  }
}

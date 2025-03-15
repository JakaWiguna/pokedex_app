import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_app/core/common/views/error_page.dart';
import 'package:pokedex_app/core/common/views/loading_page.dart';
import 'package:pokedex_app/core/common/widgets/scaffold.dart';
import 'package:pokedex_app/src/pokemon/presentation/bloc/pokemon_bloc.dart';
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
              return const LoadingPage();
            } else if (status == PokemonStateStatus.failure) {
              return _buildError();
            } else if (status == PokemonStateStatus.initial) {
              return const SizedBox.shrink();
            }
          }
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: _refreshPokemons,
                child: const PokemonList(),
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding:
                    EdgeInsets.only(right: 26, bottom: 26 + safeAreaBottom),
                child: FloatingActionButton(
                  foregroundColor: Colors.white,
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

  Widget _buildError() => ErrorPage(
        onTap: () =>
            context.read<PokemonBloc>()..add(const PokemonsRequestEvent()),
      );

  Future<void> _refreshPokemons() async {
    context.read<PokemonBloc>().add(const PokemonsPullRefreshEvent());
  }
}

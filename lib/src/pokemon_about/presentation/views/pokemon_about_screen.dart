import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/common/views/error_page.dart';
import 'package:pokedex_app/core/common/views/loading_page.dart';
import 'package:pokedex_app/src/pokemon/presentation/common/pokemon_type_extension.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/cubit/pokemon_about_cubit.dart';
import 'package:pokedex_app/src/pokemon_about/widgets/pokemon_about_content.dart';

class PokemonAboutScreen extends StatefulWidget {
  const PokemonAboutScreen({required this.pokemon, super.key});

  final Pokemon pokemon;

  @override
  State<PokemonAboutScreen> createState() => _PokemonAboutScreenState();
}

class _PokemonAboutScreenState extends State<PokemonAboutScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<PokemonAboutCubit>().requestData(widget.pokemon);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PokemonAboutCubit, PokemonAboutState>(
      builder: (context, state) {
        if (state.runtimeType == PokemonAboutSuccess) {
          return const PokemonAboutContent();
        } else if (state.runtimeType == PokemonAboutFailure) {
          return ErrorPage(
            assetSize: 120,
            onTap: () =>
                context.read<PokemonAboutCubit>()..requestData(widget.pokemon),
          );
        }
        return LoadingPage(color: widget.pokemon.types.first.color.primary);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

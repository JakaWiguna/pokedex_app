import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_app/src/pokemon/presentation/views/pokemon_screen.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/views/pokemon_detail_screen.dart';

abstract class Routes {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'pokemons',
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: const PokemonScreen(),
        ),
        routes: [
          GoRoute(
            path: 'detail/:id',
            name: 'detail',
            pageBuilder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '1') ?? 1;

              return CupertinoPage(
                key: state.pageKey,
                child: PokemonDetailScreen(id: id),
              );
            },
          ),
        ],
      ),
    ],
  );
}

import 'package:go_router/go_router.dart';
import 'package:pokedex_app/src/pokemon/presentation/views/pokemon_screen.dart';

abstract class Routes {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'pokemons',
        builder: (_, __) => const PokemonScreen(),
        //   routes: [
        //     GoRoute(
        //       path: 'detail/:id',
        //       name: 'detail',
        //       builder: (_, state) {
        //         late int id;
        //         try {
        //           id = int.parse(state.pathParameters['id'] ?? '1');
        //         } catch (_) {
        //           id = 1;
        //         }
        //         return DetailPage(id: id);
        //       },
        //     ),
        //   ],
      ),
    ],
  );
}

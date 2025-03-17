import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/core/services/injection.dart';
import 'package:pokedex_app/core/services/routes.dart';
import 'package:pokedex_app/core/themes/app_theme_data.dart';
import 'package:pokedex_app/src/pokemon/presentation/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/cubit/pokemon_about_cubit.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/cubit/pokemon_base_stats_cubit.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<PokemonBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<PokemonDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<PokemonAboutCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<PokemonBaseStatsCubit>(),
        ),
      ],
      child: MaterialApp.router(
        theme: AppThemeData.pokedexTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: Routes.router,
      ),
    );
  }
}

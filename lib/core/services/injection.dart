import 'package:get_it/get_it.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/src/pokemon/data/repository/pokemon_repository_impl.dart';
import 'package:pokedex_app/src/pokemon/domain/repository/pokemon_repository.dart';
import 'package:pokedex_app/src/pokemon/domain/usecase/get_pokemons_usecase.dart';
import 'package:pokedex_app/src/pokemon/presentation/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/src/pokemon_about/data/repository/pokemon_about_repository_impl.dart';
import 'package:pokedex_app/src/pokemon_about/domain/repository/pokemon_about_repository.dart';
import 'package:pokedex_app/src/pokemon_about/domain/usecase/get_pokemon_about_usecase.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/cubit/pokemon_about_cubit.dart';
import 'package:pokedex_app/src/pokemon_base_stats/data/repository/pokemon_base_stats_repository_impl.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/repository/pokemon_base_stats_repository.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/usecase/get_pokemon_base_stats_usecase.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/cubit/pokemon_base_stats_cubit.dart';
import 'package:pokedex_app/src/pokemon_detail/data/repository/pokemon_detail_repository_impl.dart';
import 'package:pokedex_app/src/pokemon_detail/domain/repository/pokemon_detail_repository.dart';
import 'package:pokedex_app/src/pokemon_detail/domain/usecase/get_pokemon_usecase.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initPokemon();
}

Future<void> _initPokemon() async {
  sl
    ..registerFactory(() => PokemonBloc(sl()))
    ..registerLazySingleton(() => GetPokemonsUseCase(sl()))
    ..registerLazySingleton<PokemonRepository>(
      () => PokemonRepositoryImpl(sl()),
    )
    ..registerFactory(() => PokemonDetailCubit(sl()))
    ..registerLazySingleton(() => GetPokemonUseCase(sl()))
    ..registerLazySingleton<PokemonDetailRepository>(
      () => PokemonDetailRepositoryImpl(sl()),
    )
    ..registerFactory(() => PokemonAboutCubit(sl()))
    ..registerLazySingleton(() => GetPokemonAboutUseCase(sl()))
    ..registerLazySingleton<PokemonAboutRepository>(
      () => PokemonAboutRepositoryImpl(sl()),
    )
    ..registerFactory(() => PokemonBaseStatsCubit(sl()))
    ..registerLazySingleton(() => GetPokemonBaseStatsUseCase(sl()))
    ..registerLazySingleton<PokemonBaseStatsRepository>(
      () => PokemonBaseStatsRepositoryImpl(sl()),
    )
    ..registerLazySingleton(Pokedex.new);
}

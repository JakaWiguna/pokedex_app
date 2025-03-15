import 'package:get_it/get_it.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/src/pokemon/data/repository/pokemon_repository_impl.dart';
import 'package:pokedex_app/src/pokemon/domain/repository/pokemon_repository.dart';
import 'package:pokedex_app/src/pokemon/domain/usecase/get_pokemons_usecase.dart';
import 'package:pokedex_app/src/pokemon/presentation/bloc/pokemon_bloc.dart';

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
    ..registerLazySingleton(Pokedex.new);
}

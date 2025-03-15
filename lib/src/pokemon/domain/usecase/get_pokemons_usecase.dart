import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/usecases/use_cases.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon/domain/repository/pokemon_repository.dart';

class GetPokemonsUseCase
    extends UseCaseWithParams<List<Pokemon>, GetPokemonParams> {
  const GetPokemonsUseCase(this._repo);

  final PokemonRepository _repo;

  @override
  ResultFuture<List<Pokemon>> call(GetPokemonParams params) =>
      _repo.getPokemons(params.limit, params.offset);
}

class GetPokemonParams {
  GetPokemonParams({required this.limit, required this.offset});

  final int limit;
  final int offset;
}

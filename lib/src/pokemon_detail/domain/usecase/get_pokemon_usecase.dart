import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/usecases/use_cases.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon_detail/domain/repository/pokemon_detail_repository.dart';

class GetPokemonUseCase
    extends UseCaseWithParams<Pokemon, GetPokemonDetailParams> {
  const GetPokemonUseCase(this._repo);

  final PokemonDetailRepository _repo;

  @override
  ResultFuture<Pokemon> call(GetPokemonDetailParams params) =>
      _repo.getPokemon(params.id);
}

class GetPokemonDetailParams {
  GetPokemonDetailParams({required this.id});

  final int id;
}

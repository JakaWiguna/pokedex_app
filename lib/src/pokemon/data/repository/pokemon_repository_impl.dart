import 'package:dartz/dartz.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/exceptions.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl(this._pokedex);

  final Pokedex _pokedex;

  @override
  ResultFuture<List<Pokemon>> getPokemons(int limit, int offset) async {
    try {
      final resourcePage = await _pokedex.pokemon.getPage(
        limit: limit,
        offset: offset,
      );

      final pokemons = await Future.wait(
        resourcePage.results.map((e) => _pokedex.pokemon.getByUrl(e.url)),
      );
      return Right(pokemons);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}

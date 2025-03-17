import 'package:dartz/dartz.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/exceptions.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl(this._client);

  final Pokedex _client;

  @override
  ResultFuture<List<Pokemon>> getPokemons(int limit, int offset) async {
    try {
      final resourcePage = await _client.pokemon.getPage(
        limit: limit,
        offset: offset,
      );

      final pokemons = await Future.wait(
        resourcePage.results.map((e) async {
          try {
            return await _client.pokemon.getByUrl(e.url);
          } catch (e) {
            return null;
          }
        }),
      );

      final validPokemons = pokemons.whereType<Pokemon>().toList();

      return Right(validPokemons);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Unexpected error: $e', statusCode: 500),
      );
    }
  }
}

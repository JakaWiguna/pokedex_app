import 'package:dartz/dartz.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/exceptions.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon_about/domain/entity/pokemon_about_entity.dart';
import 'package:pokedex_app/src/pokemon_about/domain/repository/pokemon_about_repository.dart';

class PokemonAboutRepositoryImpl extends PokemonAboutRepository {
  const PokemonAboutRepositoryImpl(this._client);
  final Pokedex _client;
  @override
  ResultFuture<PokemonAboutEntity> getPokemonAbout(Pokemon pokemon) async {
    try {
      final species = await _client.pokemonSpecies.get(id: pokemon.id);
      return Right(
        PokemonAboutEntity(pokemon: pokemon, pokemonSpecies: species),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Unexpected error: $e', statusCode: 500),
      );
    }
  }
}

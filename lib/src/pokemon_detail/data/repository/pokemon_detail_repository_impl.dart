import 'package:dartz/dartz.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/exceptions.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon_detail/domain/repository/pokemon_detail_repository.dart';

class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  const PokemonDetailRepositoryImpl(this._pokedex);

  final Pokedex _pokedex;

  @override
  ResultFuture<Pokemon> getPokemon(int id) async {
    try {
      final result = await _pokedex.pokemon.get(id: id);
      return Right(result);
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

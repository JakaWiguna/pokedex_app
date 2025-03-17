import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/usecases/use_cases.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon_about/domain/entity/pokemon_about_entity.dart';
import 'package:pokedex_app/src/pokemon_about/domain/repository/pokemon_about_repository.dart';

class GetPokemonAboutUseCase
    extends UseCaseWithParams<PokemonAboutEntity, GetPokemonAboutParams> {
  const GetPokemonAboutUseCase(this._repo);

  final PokemonAboutRepository _repo;

  @override
  ResultFuture<PokemonAboutEntity> call(GetPokemonAboutParams params) =>
      _repo.getPokemonAbout(params.pokemon);
}

class GetPokemonAboutParams {
  GetPokemonAboutParams({required this.pokemon});

  final Pokemon pokemon;
}

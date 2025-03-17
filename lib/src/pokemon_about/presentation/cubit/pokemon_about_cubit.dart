import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/src/pokemon_about/domain/entity/pokemon_about_entity.dart';
import 'package:pokedex_app/src/pokemon_about/domain/usecase/get_pokemon_about_usecase.dart';

part 'pokemon_about_state.dart';

class PokemonAboutCubit extends Cubit<PokemonAboutState> {
  PokemonAboutCubit(this._useCase) : super(PokemonAboutInitial());

  final GetPokemonAboutUseCase _useCase;

  Future<void> requestData(Pokemon pokemon) async {
    emit(PokemonAboutLoading());
    try {
      final result =
          await _useCase.call(GetPokemonAboutParams(pokemon: pokemon));
      result.fold(
        (failure) => emit(PokemonAboutFailure()),
        (pokemon) => emit(PokemonAboutSuccess(pokemon)),
      );
    } catch (_) {
      emit(PokemonAboutFailure());
    }
  }
}

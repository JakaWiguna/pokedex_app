import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/src/pokemon_detail/domain/usecase/get_pokemon_usecase.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  PokemonDetailCubit(this._useCase) : super(const PokemonDetailState());

  final GetPokemonUseCase _useCase;

  Future<void> init() async {
    emit(const PokemonDetailState());
  }

  Future<void> getPokemon(int id) async {
    try {
      emit(state.copyWith(status: PokemonDetailStateStatus.loading));

      final result = await _useCase.call(GetPokemonDetailParams(id: id));

      result.fold(
        (failure) => emit(
          state.copyWith(
            status: PokemonDetailStateStatus.failure,
            errorMessage: failure.errorMessage,
          ),
        ),
        (pokemon) => emit(
          state.copyWith(
            status: PokemonDetailStateStatus.success,
            result: pokemon,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PokemonDetailStateStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void toggleFavorite() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  void updateSlidePosition(double position) {
    emit(state.copyWith(slidePosition: position));
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/utils/event_transformation.dart';
import 'package:pokedex_app/src/pokemon/domain/usecase/get_pokemons_usecase.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc(this._useCase) : super(const PokemonState()) {
    on<PokemonsRequestEvent>(
      _onGetPokemons,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
    on<PokemonsPullRefreshEvent>(
      _onRefreshPokemons,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
  }

  final GetPokemonsUseCase _useCase;

  Future<void> _onGetPokemons(
    PokemonsRequestEvent event,
    Emitter<PokemonState> emit,
  ) async {
    if (state.status == PokemonStateStatus.finished &&
        state.status != PokemonStateStatus.failure &&
        state.status != PokemonStateStatus.loading) {
      return;
    }

    emit(state.copyWith(status: PokemonStateStatus.loading));

    final result = await _useCase.call(
      GetPokemonParams(limit: event.limit, offset: state.result.length),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PokemonStateStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (pokemons) => emit(
        state.copyWith(
          status: pokemons.isNotEmpty
              ? PokemonStateStatus.success
              : PokemonStateStatus.finished,
          result: pokemons,
        ),
      ),
    );
  }

  Future<void> _onRefreshPokemons(
    PokemonsPullRefreshEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(const PokemonState());

    emit(state.copyWith(status: PokemonStateStatus.loading));

    final result = await _useCase.call(
      GetPokemonParams(limit: event.limit, offset: event.offset),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PokemonStateStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (pokemons) => emit(
        state.copyWith(
          status: pokemons.isNotEmpty
              ? PokemonStateStatus.success
              : PokemonStateStatus.finished,
          result: pokemons,
        ),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/usecase/get_pokemon_base_stats_usecase.dart';

part 'pokemon_base_stats_state.dart';

class PokemonBaseStatsCubit extends Cubit<PokemonBaseStatsState> {
  PokemonBaseStatsCubit(this._useCase) : super(PokemonBaseStatsInitial());
  final GetPokemonBaseStatsUseCase _useCase;

  Future<void> getStats(Pokemon pokemon) async {
    emit(PokemonBaseStatsLoading());
    try {
      final result =
          await _useCase.call(GetPokemonBaseStatsParams(pokemon: pokemon));
      result.fold(
        (failure) => emit(PokemonBaseStatsFailure()),
        (pokemon) => emit(PokemonBaseStatsSuccess(pokemon)),
      );
    } catch (_) {
      emit(PokemonBaseStatsFailure());
    }
  }
}

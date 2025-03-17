part of 'pokemon_base_stats_cubit.dart';

sealed class PokemonBaseStatsState extends Equatable {
  const PokemonBaseStatsState();

  @override
  List<Object> get props => [];
}

final class PokemonBaseStatsInitial extends PokemonBaseStatsState {}

final class PokemonBaseStatsLoading extends PokemonBaseStatsState {}

final class PokemonBaseStatsFailure extends PokemonBaseStatsState {}

final class PokemonBaseStatsSuccess extends PokemonBaseStatsState {
  const PokemonBaseStatsSuccess(this.data);

  final PokemonBaseStatsEntity data;
}

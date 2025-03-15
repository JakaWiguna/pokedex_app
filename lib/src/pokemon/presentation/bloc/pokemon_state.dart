part of 'pokemon_bloc.dart';

enum PokemonStateStatus {
  initial,
  loading,
  finished,
  success,
  failure,
}

class PokemonState extends Equatable {
  const PokemonState({
    this.status = PokemonStateStatus.initial,
    this.result = const <Pokemon>[],
    this.errorMessage = '',
  });

  PokemonState copyWith({
    PokemonStateStatus? status,
    List<Pokemon>? result,
    String? errorMessage,
  }) {
    return PokemonState(
      status: status ?? this.status,
      result: this.result + (result ?? []),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  final PokemonStateStatus status;
  final String errorMessage;
  final List<Pokemon> result;

  bool get firstPage => result.isEmpty;

  @override
  List<Object> get props => [status, result, errorMessage];
}

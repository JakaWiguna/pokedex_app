part of 'pokemon_detail_cubit.dart';

enum PokemonDetailStateStatus {
  initial,
  loading,
  success,
  failure,
}

class PokemonDetailState extends Equatable {
  const PokemonDetailState({
    this.status = PokemonDetailStateStatus.initial,
    this.result = const Pokemon(
      0,
      'pokemon',
      0,
      0,
      false,
      0,
      0,
      [],
      [],
      [],
      [],
      '',
      [],
      [],
      PokemonSprites(
        '',
        '',
        null,
        null,
        '',
        '',
        null,
        null,
      ),
      NamedAPIResource('species', ''),
      [],
      [],
    ),
    this.errorMessage = '',
    this.isFavorite = false,
    this.slidePosition = 0,
  });

  final PokemonDetailStateStatus status;
  final Pokemon result;
  final String errorMessage;
  final bool isFavorite;
  final double slidePosition;

  PokemonDetailState copyWith({
    PokemonDetailStateStatus? status,
    Pokemon? result,
    String? errorMessage,
    bool? isFavorite,
    double? slidePosition,
  }) {
    return PokemonDetailState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
      isFavorite: isFavorite ?? this.isFavorite,
      slidePosition: slidePosition ?? this.slidePosition,
    );
  }

  @override
  List<Object> get props =>
      [status, result, errorMessage, isFavorite, slidePosition];
}

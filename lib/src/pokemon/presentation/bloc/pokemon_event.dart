part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();
}

class PokemonsRequestEvent extends PokemonEvent {
  const PokemonsRequestEvent({
    this.limit = 20,
  });

  final int limit;

  @override
  List<Object?> get props => [limit];
}

class PokemonsPullRefreshEvent extends PokemonEvent {
  const PokemonsPullRefreshEvent({
    this.offset = 0,
    this.limit = 20,
  });

  final int limit;
  final int offset;

  @override
  List<Object?> get props => [limit, offset];
}

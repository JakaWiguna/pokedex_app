part of 'pokemon_about_cubit.dart';

sealed class PokemonAboutState extends Equatable {
  const PokemonAboutState();

  @override
  List<Object> get props => [];
}

final class PokemonAboutInitial extends PokemonAboutState {}

final class PokemonAboutLoading extends PokemonAboutState {}

class PokemonAboutSuccess extends PokemonAboutState {
  const PokemonAboutSuccess(this.data);

  final PokemonAboutEntity data;
}

final class PokemonAboutFailure extends PokemonAboutState {}

import 'package:equatable/equatable.dart';
import 'package:pokedex/pokedex.dart';

class PokemonAboutEntity extends Equatable {
  const PokemonAboutEntity({
    required this.pokemon,
    required this.pokemonSpecies,
  });

  final Pokemon pokemon;
  final PokemonSpecies? pokemonSpecies;

  @override
  List<Object?> get props => [pokemon, pokemonSpecies];
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/exceptions.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon_about/data/repository/pokemon_about_repository_impl.dart';
import 'package:pokedex_app/src/pokemon_about/domain/entity/pokemon_about_entity.dart';

class MockPokedex extends Mock implements Pokedex {}

class MockPokemonSpeciesEndpoint extends Mock
    implements NamedEndpoint<PokemonSpecies> {}

void main() {
  late PokemonAboutRepositoryImpl repository;
  late MockPokedex mockPokedex;
  late MockPokemonSpeciesEndpoint mockPokemonSpeciesEndpoint;

  setUp(() {
    mockPokedex = MockPokedex();
    mockPokemonSpeciesEndpoint = MockPokemonSpeciesEndpoint();
    repository = PokemonAboutRepositoryImpl(mockPokedex);

    when(() => mockPokedex.pokemonSpecies)
        .thenReturn(mockPokemonSpeciesEndpoint);
  });

  const testPokemon = Pokemon(
    1,
    'bulbasaur',
    100,
    10,
    true,
    10,
    1,
    [],
    [],
    [],
    [],
    '',
    [],
    [],
    PokemonSprites('', '', null, null, '', '', null, null),
    NamedAPIResource('species1', ''),
    [],
    [],
  );

  const testPokemonSpecies = PokemonSpecies(
    1,
    'bulbasaur',
    1, // order
    1, // genderRate
    45, // captureRate
    70, // baseHappiness
    false, // isBaby
    false, // isLegendary
    false, // isMythical
    10, // hatchCounter
    false, // hasGenderdifferences
    true, // formsSwitchable
    NamedAPIResource('medium-slow', 'https://pokeapi.co/growth-rate/1'),
    [], // pokedexNumbers
    [
      NamedAPIResource('monster', 'https://pokeapi.co/egg-group/1'),
    ], // eggGroups
    NamedAPIResource('green', 'https://pokeapi.co/pokemon-color/1'), // color
    NamedAPIResource(
      'quadruped',
      'https://pokeapi.co/pokemon-shape/1',
    ), // shape
    null, // evolvesFromSpecies
    APIResource('https://pokeapi.co/evolution-chain/1'), // evolutionChain
    NamedAPIResource(
      'grassland',
      'https://pokeapi.co/pokemon-habitat/1',
    ), // habitat
    NamedAPIResource(
      'generation-i',
      'https://pokeapi.co/generation/1',
    ), // generation
    [], // names
    [], // palParkEncounters
    [], // flavorTextEntries
    [], // formDescriptions
    [], // genera
    [], // varieties
  );

  group('getPokemonAbout', () {
    test('should return PokemonAboutEntity when API call is successful',
        () async {
      // Arrange
      when(() => mockPokemonSpeciesEndpoint.get(id: testPokemon.id))
          .thenAnswer((_) async => testPokemonSpecies);

      // Act
      final result = await repository.getPokemonAbout(testPokemon);

      // Assert
      expect(result, isA<Right<Failure, PokemonAboutEntity>>());
      expect(
        result.getOrElse(() => throw Exception()).pokemonSpecies,
        equals(testPokemonSpecies),
      );
      verify(() => mockPokemonSpeciesEndpoint.get(id: testPokemon.id))
          .called(1);
    });

    test('should return ServerFailure when a ServerException occurs', () async {
      // Arrange
      when(() => mockPokemonSpeciesEndpoint.get(id: testPokemon.id)).thenThrow(
        const ServerException(message: 'Server error', statusCode: '500'),
      );

      // Act
      final result = await repository.getPokemonAbout(testPokemon);

      // Assert
      expect(result, isA<Left<Failure, PokemonAboutEntity>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      expect(
        result.fold((l) => (l as ServerFailure).message, (r) => null),
        equals('Server error'),
      );
      verify(() => mockPokemonSpeciesEndpoint.get(id: testPokemon.id))
          .called(1);
    });

    test('should return CacheFailure when a CacheException occurs', () async {
      // Arrange
      when(() => mockPokemonSpeciesEndpoint.get(id: testPokemon.id)).thenThrow(
        const CacheException(message: 'Cache error', statusCode: 404),
      );

      // Act
      final result = await repository.getPokemonAbout(testPokemon);

      // Assert
      expect(result, isA<Left<Failure, PokemonAboutEntity>>());
      expect(result.fold((l) => l, (r) => null), isA<CacheFailure>());
      expect(
        result.fold((l) => (l as CacheFailure).message, (r) => null),
        equals('Cache error'),
      );
      verify(() => mockPokemonSpeciesEndpoint.get(id: testPokemon.id))
          .called(1);
    });

    test('should return ServerFailure when an unexpected error occurs',
        () async {
      // Arrange
      when(() => mockPokemonSpeciesEndpoint.get(id: testPokemon.id))
          .thenThrow(Exception('Unexpected error'));

      // Act
      final result = await repository.getPokemonAbout(testPokemon);

      // Assert
      expect(result, isA<Left<Failure, PokemonAboutEntity>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      expect(
        result.fold((l) => (l as ServerFailure).message, (r) => null),
        equals('Unexpected error: Exception: Unexpected error'),
      );
      verify(() => mockPokemonSpeciesEndpoint.get(id: testPokemon.id))
          .called(1);
    });
  });
}

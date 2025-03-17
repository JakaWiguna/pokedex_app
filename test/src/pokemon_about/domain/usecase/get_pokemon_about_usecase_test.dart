import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon_about/domain/entity/pokemon_about_entity.dart';
import 'package:pokedex_app/src/pokemon_about/domain/repository/pokemon_about_repository.dart';
import 'package:pokedex_app/src/pokemon_about/domain/usecase/get_pokemon_about_usecase.dart';

class MockPokemonAboutRepository extends Mock
    implements PokemonAboutRepository {}

void main() {
  late GetPokemonAboutUseCase useCase;
  late MockPokemonAboutRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(
      const Pokemon(
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
        NamedAPIResource('species1', ''),
        [],
        [],
      ),
    );
  });

  setUp(() {
    mockRepository = MockPokemonAboutRepository();
    useCase = GetPokemonAboutUseCase(mockRepository);
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

  const testPokemonAboutEntity = PokemonAboutEntity(
    pokemon: testPokemon,
    pokemonSpecies: testPokemonSpecies,
  );

  group('GetPokemonAboutUseCase', () {
    test('should return PokemonAboutEntity when repository call is successful',
        () async {
      // Arrange
      when(() => mockRepository.getPokemonAbout(any()))
          .thenAnswer((_) async => const Right(testPokemonAboutEntity));

      // Act
      final result = await useCase(GetPokemonAboutParams(pokemon: testPokemon));

      // Assert
      expect(
        result,
        equals(
          const Right<Failure, PokemonAboutEntity>(
            testPokemonAboutEntity,
          ),
        ),
      );
      verify(() => mockRepository.getPokemonAbout(testPokemon)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure when repository call fails', () async {
      // Arrange
      final failure = ServerFailure(message: 'Server error', statusCode: 500);
      when(() => mockRepository.getPokemonAbout(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(GetPokemonAboutParams(pokemon: testPokemon));

      // Assert
      expect(result, equals(Left<Failure, PokemonAboutEntity>(failure)));
      verify(() => mockRepository.getPokemonAbout(testPokemon)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

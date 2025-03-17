import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/exceptions.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon/data/repository/pokemon_repository_impl.dart';

class MockPokedex extends Mock implements Pokedex {}

class MockPokemonEndpoint extends Mock implements NamedEndpoint<Pokemon> {}

void main() {
  late PokemonRepositoryImpl repository;
  late MockPokedex mockPokedex;
  late MockPokemonEndpoint mockPokemonEndpoint;

  setUp(() {
    mockPokedex = MockPokedex();
    mockPokemonEndpoint = MockPokemonEndpoint();
    repository = PokemonRepositoryImpl(mockPokedex);

    when(() => mockPokedex.pokemon).thenReturn(mockPokemonEndpoint);
  });

  group('getPokemons', () {
    const limit = 10;
    const offset = 0;

    test('should return a list of Pokemon when the call is successful',
        () async {
      // Arrange
      final resourcePage = NamedAPIResourceList(
        100,
        null,
        null,
        List.generate(
          limit,
          (index) => NamedAPIResource(
            'pokemon$index',
            'https://pokeapi.co/api/v2/pokemon/$index/',
          ),
        ),
      );

      final pokemons = List.generate(
        limit,
        (index) => Pokemon(
          index,
          'pokemon$index',
          100,
          10,
          true,
          10,
          index,
          [],
          [],
          [],
          [],
          '',
          [],
          [],
          const PokemonSprites(
            '',
            '',
            null,
            null,
            '',
            '',
            null,
            null,
          ),
          NamedAPIResource('species$index', ''),
          [],
          [],
        ),
      );

      when(() => mockPokemonEndpoint.getPage(limit: limit))
          .thenAnswer((_) async => resourcePage);

      for (var i = 0; i < limit; i++) {
        when(() => mockPokemonEndpoint.getByUrl(resourcePage.results[i].url))
            .thenAnswer((_) async => pokemons[i]);
      }

      // Act
      final result = await repository.getPokemons(limit, offset);

      // Assert
      expect(result, isA<Right<Failure, List<Pokemon>>>());
      expect(result.getOrElse(() => []), equals(pokemons));
      verify(() => mockPokemonEndpoint.getPage(limit: limit)).called(1);
      for (var i = 0; i < limit; i++) {
        verify(() => mockPokemonEndpoint.getByUrl(resourcePage.results[i].url))
            .called(1);
      }
      verifyNoMoreInteractions(mockPokemonEndpoint);
    });

    test('should return a ServerFailure when the call fails', () async {
      // Arrange
      when(() => mockPokemonEndpoint.getPage(limit: limit)).thenThrow(
        const ServerException(message: 'Server error', statusCode: '500'),
      );

      // Act
      final result = await repository.getPokemons(limit, offset);

      // Assert
      expect(result, isA<Left<Failure, List<Pokemon>>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      verify(() => mockPokemonEndpoint.getPage(limit: limit)).called(1);
      verifyNoMoreInteractions(mockPokemonEndpoint);
    });

    test('should filter out null Pokemon when some API calls fail', () async {
      // Arrange
      const resourcePage = NamedAPIResourceList(
        100,
        null,
        null,
        [
          NamedAPIResource('bulbasaur', 'https://pokeapi.co/api/v2/pokemon/1/'),
          NamedAPIResource('missingno', 'https://pokeapi.co/api/v2/pokemon/0/'),
        ],
      );

      const bulbasaur = Pokemon(
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

      when(() => mockPokemonEndpoint.getPage(limit: limit))
          .thenAnswer((_) async => resourcePage);

      when(
        () => mockPokemonEndpoint
            .getByUrl('https://pokeapi.co/api/v2/pokemon/1/'),
      ).thenAnswer((_) async => bulbasaur);

      when(
        () => mockPokemonEndpoint
            .getByUrl('https://pokeapi.co/api/v2/pokemon/0/'),
      ).thenThrow(Exception()); // Simulasi error saat fetch

      // Act
      final result = await repository.getPokemons(limit, offset);

      // Assert
      expect(result, isA<Right<Failure, List<Pokemon>>>());
      expect(
        result.getOrElse(() => []),
        equals([bulbasaur]),
      ); // Cek hanya bulbasaur yang tersisa
      verify(() => mockPokemonEndpoint.getByUrl(any())).called(2);
    });

    test('should return a ServerFailure when an unexpected error occurs',
        () async {
      // Arrange
      when(() => mockPokemonEndpoint.getPage(limit: limit))
          .thenThrow(Exception('Unexpected error'));

      // Act
      final result = await repository.getPokemons(limit, offset);

      // Assert
      expect(result, isA<Left<Failure, List<Pokemon>>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      expect(
        result.fold((l) => l as ServerFailure, (r) => null)!.message,
        equals('Unexpected error: Exception: Unexpected error'),
      );
      verify(() => mockPokemonEndpoint.getPage(limit: limit)).called(1);
    });
  });
}

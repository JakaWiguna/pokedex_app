import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/exceptions.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon_base_stats/data/repository/pokemon_base_stats_repository_impl.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/repository/pokemon_base_stats_repository.dart';

class MockPokedex extends Mock implements Pokedex {}

class MockPokemonTypeEndpoint extends Mock implements NamedEndpoint<Type> {}

void main() {
  late PokemonBaseStatsRepository repository;
  late MockPokedex mockPokedex;
  late MockPokemonTypeEndpoint mockPokemonTypeEndpoint;

  setUp(() {
    mockPokedex = MockPokedex();
    mockPokemonTypeEndpoint = MockPokemonTypeEndpoint();
    repository = PokemonBaseStatsRepositoryImpl(mockPokedex);

    when(() => mockPokedex.types).thenReturn(mockPokemonTypeEndpoint);
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
    [
      PokemonStat(
        NamedAPIResource('hp', 'https://pokeapi.co/api/v2/stat/1/'),
        0,
        45,
      ),
      PokemonStat(
        NamedAPIResource('attack', 'https://pokeapi.co/api/v2/stat/1/'),
        0,
        49,
      ),
    ],
    [
      PokemonType(
        // Menambahkan type
        0,
        NamedAPIResource('grass', 'https://pokeapi.co/api/v2/type/1/'),
      ),
    ],
  );

  const testType = Type(
    1,
    'grass',
    TypeRelations(
      [],
      [],
      [],
      [],
      [],
      [],
    ),
    [],
    [],
    NamedAPIResource('generation-i', ''),
    null,
    [],
    [],
    [],
  );

  group('getBaseStats', () {
    test('should return PokemonBaseStatsEntity when API call is successful',
        () async {
      // Arrange
      when(() => mockPokemonTypeEndpoint.getAll()).thenAnswer(
        (_) async => const NamedAPIResourceList(
          18,
          null,
          null,
          [NamedAPIResource('grass', 'https://pokeapi.co/type/1/')],
        ),
      );

      when(() => mockPokemonTypeEndpoint.getByUrl(any()))
          .thenAnswer((_) async => testType);

      // Act
      final result = await repository.getBaseStats(testPokemon);

      // Assert
      expect(result, isA<Right<Failure, PokemonBaseStatsEntity>>());
      verify(() => mockPokemonTypeEndpoint.getAll()).called(1);
      verify(() => mockPokemonTypeEndpoint.getByUrl(any())).called(1);
    });

    test('should return ServerFailure when a ServerException occurs', () async {
      // Arrange
      when(() => mockPokemonTypeEndpoint.getAll()).thenThrow(
        const ServerException(message: 'Server error', statusCode: '500'),
      );

      // Act
      final result = await repository.getBaseStats(testPokemon);

      // Assert
      expect(result, isA<Left<Failure, PokemonBaseStatsEntity>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      verify(() => mockPokemonTypeEndpoint.getAll()).called(1);
    });

    test('should return CacheFailure when a CacheException occurs', () async {
      // Arrange
      when(() => mockPokemonTypeEndpoint.getAll()).thenThrow(
        const CacheException(message: 'Cache error', statusCode: 404),
      );

      // Act
      final result = await repository.getBaseStats(testPokemon);

      // Assert
      expect(result, isA<Left<Failure, PokemonBaseStatsEntity>>());
      expect(result.fold((l) => l, (r) => null), isA<CacheFailure>());
      verify(() => mockPokemonTypeEndpoint.getAll()).called(1);
    });

    test('should return ServerFailure when an unexpected error occurs',
        () async {
      // Arrange
      when(() => mockPokemonTypeEndpoint.getAll())
          .thenThrow(Exception('Unexpected error'));

      // Act
      final result = await repository.getBaseStats(testPokemon);

      // Assert
      expect(result, isA<Left<Failure, PokemonBaseStatsEntity>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      verify(() => mockPokemonTypeEndpoint.getAll()).called(1);
    });
  });
}

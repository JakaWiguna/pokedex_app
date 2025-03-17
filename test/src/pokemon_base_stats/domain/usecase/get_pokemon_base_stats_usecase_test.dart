import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/repository/pokemon_base_stats_repository.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/usecase/get_pokemon_base_stats_usecase.dart';

class MockPokemonBaseStatsRepository extends Mock
    implements PokemonBaseStatsRepository {}

void main() {
  late GetPokemonBaseStatsUseCase useCase;
  late MockPokemonBaseStatsRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonBaseStatsRepository();
    useCase = GetPokemonBaseStatsUseCase(mockRepository);
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

  const testEntity = PokemonBaseStatsEntity(
    pokemon: testPokemon,
    statsMap: {},
    minStat: 10,
    summation: 100,
    multipliers: [],
  );

  test(
      'should return PokemonBaseStatsEntity when repository call is successful',
      () async {
    // Arrange
    when(() => mockRepository.getBaseStats(testPokemon))
        .thenAnswer((_) async => const Right(testEntity));

    // Act
    final result =
        await useCase(GetPokemonBaseStatsParams(pokemon: testPokemon));

    // Assert
    expect(
      result,
      equals(const Right<Failure, PokemonBaseStatsEntity>(testEntity)),
    );
    verify(() => mockRepository.getBaseStats(testPokemon)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when repository call fails', () async {
    // Arrange
    when(() => mockRepository.getBaseStats(testPokemon)).thenAnswer(
      (_) async =>
          Left(ServerFailure(message: 'Server error', statusCode: 500)),
    );

    // Act
    final result =
        await useCase(GetPokemonBaseStatsParams(pokemon: testPokemon));

    // Assert
    expect(result, isA<Left<Failure, PokemonBaseStatsEntity>>());
    verify(() => mockRepository.getBaseStats(testPokemon)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

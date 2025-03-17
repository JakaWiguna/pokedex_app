import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/usecase/get_pokemon_base_stats_usecase.dart';
import 'package:pokedex_app/src/pokemon_base_stats/presentation/cubit/pokemon_base_stats_cubit.dart';

class MockGetPokemonBaseStatsUseCase extends Mock
    implements GetPokemonBaseStatsUseCase {}

void main() {
  late PokemonBaseStatsCubit cubit;
  late MockGetPokemonBaseStatsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetPokemonBaseStatsUseCase();
    cubit = PokemonBaseStatsCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
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

  setUpAll(() {
    registerFallbackValue(GetPokemonBaseStatsParams(pokemon: testPokemon));
  });

  const testStatsEntity = PokemonBaseStatsEntity(
    pokemon: testPokemon,
    statsMap: {},
    minStat: 10,
    summation: 100,
    multipliers: [],
  );

  group('getStats', () {
    test('initial state should be PokemonBaseStatsInitial', () {
      expect(cubit.state, PokemonBaseStatsInitial());
    });

    blocTest<PokemonBaseStatsCubit, PokemonBaseStatsState>(
      'should emit [PokemonBaseStatsLoading, PokemonBaseStatsSuccess] when '
      'API call is successful',
      build: () {
        when(() => mockUseCase.call(any()))
            .thenAnswer((_) async => const Right(testStatsEntity));
        return cubit;
      },
      act: (cubit) => cubit.getStats(testPokemon),
      expect: () => [
        PokemonBaseStatsLoading(),
        const PokemonBaseStatsSuccess(testStatsEntity),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(any())).called(1);
      },
    );

    blocTest<PokemonBaseStatsCubit, PokemonBaseStatsState>(
      'should emit [PokemonBaseStatsLoading, PokemonBaseStatsFailure] when '
      'API call fails',
      build: () {
        when(() => mockUseCase.call(any())).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Error', statusCode: '500')),
        );
        return cubit;
      },
      act: (cubit) => cubit.getStats(testPokemon),
      expect: () => [
        PokemonBaseStatsLoading(),
        PokemonBaseStatsFailure(),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(any())).called(1);
      },
    );

    blocTest<PokemonBaseStatsCubit, PokemonBaseStatsState>(
      'should emit [PokemonBaseStatsLoading, PokemonBaseStatsFailure] when '
      'an unexpected error occurs',
      build: () {
        when(() => mockUseCase.call(any()))
            .thenThrow(Exception('Unexpected error'));
        return cubit;
      },
      act: (cubit) => cubit.getStats(testPokemon),
      expect: () => [
        PokemonBaseStatsLoading(),
        PokemonBaseStatsFailure(),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(any())).called(1);
      },
    );
  });
}

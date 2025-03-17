// Unit Test file for pokemon_detail_cubit.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon_detail/domain/usecase/get_pokemon_usecase.dart';
import 'package:pokedex_app/src/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';

class MockGetPokemonUseCase extends Mock implements GetPokemonUseCase {}

void main() {
  late PokemonDetailCubit cubit;
  late MockGetPokemonUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetPokemonUseCase();
    cubit = PokemonDetailCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  const testPokemon = Pokemon(
    1, // id
    'bulbasaur', // name
    64, // baseExperience
    7, // height
    true, // isDefault
    1, // order
    69, // weight
    [], // abilities
    [], // forms
    [], // gameIndices
    [], // heldItems
    '', // locationAreaEncounters
    [], // moves
    [], // pastTypes
    PokemonSprites(
      '', // frontDefault
      '', // frontShiny
      null, // frontFemale
      null, // frontShinyFemale
      '', // backDefault
      '', // backShiny
      null, // backFemale
      null, // backShinyFemale
    ), // sprites
    NamedAPIResource('bulbasaur', ''), // species
    [], // stats
    [], // types
  );

  setUpAll(() {
    registerFallbackValue(GetPokemonDetailParams(id: 1));
  });

  group('getPokemon', () {
    test('initial state should be PokemonDetailState.initial()', () {
      expect(cubit.state, equals(const PokemonDetailState()));
    });

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should emit [loading, success] when API call is successful',
      build: () {
        when(() => mockUseCase.call(any<GetPokemonDetailParams>()))
            .thenAnswer((_) async => const Right(testPokemon));
        return cubit;
      },
      act: (cubit) => cubit.getPokemon(1),
      expect: () => [
        const PokemonDetailState(status: PokemonDetailStateStatus.loading),
        const PokemonDetailState(
          status: PokemonDetailStateStatus.success,
          result: testPokemon,
        ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(any<GetPokemonDetailParams>())).called(1);
      },
    );

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should emit [loading, failure] when API call fails',
      build: () {
        when(() => mockUseCase.call(any<GetPokemonDetailParams>())).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Error', statusCode: '500')),
        );
        return cubit;
      },
      act: (cubit) => cubit.getPokemon(1),
      expect: () => [
        const PokemonDetailState(status: PokemonDetailStateStatus.loading),
        const PokemonDetailState(
          status: PokemonDetailStateStatus.failure,
          errorMessage: '500: Error',
        ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(any<GetPokemonDetailParams>())).called(1);
      },
    );

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should emit [loading, failure] when an unexpected error occurs',
      build: () {
        when(() => mockUseCase.call(any<GetPokemonDetailParams>()))
            .thenThrow(Exception('Unexpected error'));
        return cubit;
      },
      act: (cubit) => cubit.getPokemon(1),
      expect: () => [
        const PokemonDetailState(status: PokemonDetailStateStatus.loading),
        const PokemonDetailState(
          status: PokemonDetailStateStatus.failure,
          errorMessage: 'Exception: Unexpected error',
        ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(any<GetPokemonDetailParams>())).called(1);
      },
    );
  });

  group('toggleFavorite', () {
    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should toggle isFavorite from false to true',
      build: () => cubit,
      act: (cubit) => cubit.toggleFavorite(),
      expect: () => [
        const PokemonDetailState(isFavorite: true),
      ],
    );

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should toggle isFavorite from true to false',
      build: () {
        cubit.emit(const PokemonDetailState(isFavorite: true));
        return cubit;
      },
      act: (cubit) => cubit.toggleFavorite(),
      expect: () => [
        const PokemonDetailState(),
      ],
    );
  });

  group('updateSlidePosition', () {
    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'should update slidePosition',
      build: () => cubit,
      act: (cubit) => cubit.updateSlidePosition(0.5),
      expect: () => [
        const PokemonDetailState(slidePosition: 0.5),
      ],
    );
  });
}

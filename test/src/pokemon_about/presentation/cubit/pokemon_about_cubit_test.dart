import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon_about/domain/entity/pokemon_about_entity.dart';
import 'package:pokedex_app/src/pokemon_about/domain/usecase/get_pokemon_about_usecase.dart';
import 'package:pokedex_app/src/pokemon_about/presentation/cubit/pokemon_about_cubit.dart';

class MockGetPokemonAboutUseCase extends Mock
    implements GetPokemonAboutUseCase {}

void main() {
  late PokemonAboutCubit cubit;
  late MockGetPokemonAboutUseCase mockUseCase;

  setUpAll(() {
    registerFallbackValue(
      GetPokemonAboutParams(
        pokemon: const Pokemon(
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
      ),
    );
  });

  setUp(() {
    mockUseCase = MockGetPokemonAboutUseCase();
    cubit = PokemonAboutCubit(mockUseCase);
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
    1,
    1,
    45,
    70,
    false,
    false,
    false,
    10,
    false,
    true,
    NamedAPIResource('medium-slow', 'https://pokeapi.co/growth-rate/1'),
    [],
    [NamedAPIResource('monster', 'https://pokeapi.co/egg-group/1')],
    NamedAPIResource('green', 'https://pokeapi.co/pokemon-color/1'),
    NamedAPIResource('quadruped', 'https://pokeapi.co/pokemon-shape/1'),
    null,
    APIResource('https://pokeapi.co/evolution-chain/1'),
    NamedAPIResource('grassland', 'https://pokeapi.co/pokemon-habitat/1'),
    NamedAPIResource('generation-i', 'https://pokeapi.co/generation/1'),
    [],
    [],
    [],
    [],
    [],
    [],
  );

  const testPokemonAboutEntity = PokemonAboutEntity(
    pokemon: testPokemon,
    pokemonSpecies: testPokemonSpecies,
  );

  group('PokemonAboutCubit', () {
    test('initial state should be PokemonAboutInitial', () {
      expect(cubit.state, equals(PokemonAboutInitial()));
    });

    blocTest<PokemonAboutCubit, PokemonAboutState>(
      'emits [PokemonAboutLoading, PokemonAboutSuccess] when '
      'data is fetched successfully',
      build: () {
        when(() => mockUseCase(any()))
            .thenAnswer((_) async => const Right(testPokemonAboutEntity));
        return cubit;
      },
      act: (cubit) => cubit.requestData(testPokemon),
      expect: () => [
        PokemonAboutLoading(),
        const PokemonAboutSuccess(testPokemonAboutEntity),
      ],
      verify: (_) {
        verify(() => mockUseCase(any())).called(1);
      },
    );

    blocTest<PokemonAboutCubit, PokemonAboutState>(
      'emits [PokemonAboutLoading, PokemonAboutFailure] when '
      'repository call fails',
      build: () {
        when(() => mockUseCase(any())).thenAnswer(
          (_) async => Left(ServerFailure(message: 'Error', statusCode: 500)),
        );
        return cubit;
      },
      act: (cubit) => cubit.requestData(testPokemon),
      expect: () => [
        PokemonAboutLoading(),
        PokemonAboutFailure(),
      ],
      verify: (_) {
        verify(() => mockUseCase(any())).called(1);
      },
    );

    blocTest<PokemonAboutCubit, PokemonAboutState>(
      'emits [PokemonAboutLoading, PokemonAboutFailure] when '
      'an exception occurs',
      build: () {
        when(() => mockUseCase(any())).thenThrow(Exception('Unexpected error'));
        return cubit;
      },
      act: (cubit) => cubit.requestData(testPokemon),
      expect: () => [
        PokemonAboutLoading(),
        PokemonAboutFailure(),
      ],
      verify: (_) {
        verify(() => mockUseCase(any())).called(1);
      },
    );
  });
}

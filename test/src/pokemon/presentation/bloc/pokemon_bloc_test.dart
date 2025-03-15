import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/exceptions.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon/domain/usecase/get_pokemons_usecase.dart';
import 'package:pokedex_app/src/pokemon/presentation/bloc/pokemon_bloc.dart';

class MockGetPokemonsUseCase extends Mock implements GetPokemonsUseCase {}

class FakeGetPokemonParams extends Fake implements GetPokemonParams {}

void main() {
  late PokemonBloc pokemonBloc;
  late MockGetPokemonsUseCase mockUseCase;

  setUpAll(() {
    registerFallbackValue(FakeGetPokemonParams());
  });

  setUp(() {
    mockUseCase = MockGetPokemonsUseCase();
    pokemonBloc = PokemonBloc(mockUseCase);
  });

  tearDown(() {
    pokemonBloc.close();
  });

  final params = GetPokemonParams(limit: 20, offset: 0);

  final pokemons = List.generate(
    params.limit,
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

  group('PokemonBloc', () {
    test('initial state should be PokemonState()', () {
      expect(pokemonBloc.state, const PokemonState());
    });

    group('PokemonsRequestEvent', () {
      blocTest<PokemonBloc, PokemonState>(
        'emits [loading, success] when PokemonsRequestEvent is '
        'added and use case returns data',
        build: () {
          when(() => mockUseCase.call(any()))
              .thenAnswer((_) async => Right(pokemons));
          return pokemonBloc;
        },
        act: (bloc) => bloc.add(const PokemonsRequestEvent()),
        expect: () => [
          const PokemonState(status: PokemonStateStatus.loading),
          PokemonState(
            status: PokemonStateStatus.success,
            result: pokemons,
          ),
        ],
        verify: (_) {
          verify(() => mockUseCase.call(any())).called(1);
        },
      );

      blocTest<PokemonBloc, PokemonState>(
        'emits [loading, failure] when fetching fails',
        build: () {
          when(() => mockUseCase.call(any())).thenAnswer(
            (_) async => Left(
              ServerFailure(message: 'Server error', statusCode: '500'),
            ),
          );
          return pokemonBloc;
        },
        act: (bloc) => bloc.add(const PokemonsRequestEvent(limit: 10)),
        expect: () => [
          const PokemonState(status: PokemonStateStatus.loading),
          const PokemonState(
            status: PokemonStateStatus.failure,
            errorMessage: '500: Server error',
          ),
        ],
        verify: (_) {
          verify(() => mockUseCase.call(any())).called(1);
        },
      );

      blocTest<PokemonBloc, PokemonState>(
        'emits [loading, failure] when an unexpected exception occurs',
        build: () {
          when(() => mockUseCase.call(any())).thenThrow(
            const ServerException(
              message: 'Unexpected Error',
              statusCode: '500',
            ),
          );
          return pokemonBloc;
        },
        act: (bloc) => bloc.add(const PokemonsRequestEvent(limit: 10)),
        expect: () => [
          const PokemonState(status: PokemonStateStatus.loading),
          const PokemonState(
            status: PokemonStateStatus.failure,
            errorMessage: 'Unexpected Error',
          ),
        ],
        verify: (_) {
          verify(() => mockUseCase.call(any())).called(1);
        },
      );
    });

    group('PokemonsPullRefreshEvent', () {
      blocTest<PokemonBloc, PokemonState>(
        'emits [initial, loading, success] when refreshed successfully',
        build: () {
          when(() => mockUseCase.call(any()))
              .thenAnswer((_) async => Right(pokemons));
          return pokemonBloc;
        },
        act: (bloc) => bloc.add(const PokemonsPullRefreshEvent(limit: 10)),
        expect: () => [
          const PokemonState(), // Reset state
          const PokemonState(status: PokemonStateStatus.loading),
          PokemonState(
            status: PokemonStateStatus.success,
            result: pokemons,
          ),
        ],
        verify: (_) {
          verify(() => mockUseCase.call(any())).called(1);
        },
      );

      blocTest<PokemonBloc, PokemonState>(
        'emits [initial, loading, failure] when refresh fails',
        build: () {
          when(() => mockUseCase.call(any())).thenAnswer(
            (_) async => Left(
              ServerFailure(message: 'Server error', statusCode: '500'),
            ),
          );
          return pokemonBloc;
        },
        act: (bloc) => bloc.add(const PokemonsPullRefreshEvent(limit: 10)),
        expect: () => [
          const PokemonState(),
          const PokemonState(status: PokemonStateStatus.loading),
          const PokemonState(
            status: PokemonStateStatus.failure,
            errorMessage: '500: Server error',
          ),
        ],
        verify: (_) {
          verify(() => mockUseCase.call(any())).called(1);
        },
      );
    });
  });

  blocTest<PokemonBloc, PokemonState>(
    'emits [loading, failure] when an unexpected exception occurs',
    build: () {
      when(() => mockUseCase.call(any())).thenThrow(
        const ServerException(
          message: 'Unexpected Error',
          statusCode: '500',
        ),
      );
      return pokemonBloc;
    },
    act: (bloc) => bloc.add(const PokemonsPullRefreshEvent(limit: 10)),
    expect: () => [
      const PokemonState(),
      const PokemonState(status: PokemonStateStatus.loading),
      const PokemonState(
        status: PokemonStateStatus.failure,
        errorMessage: 'Unexpected Erro',
      ),
    ],
    verify: (_) {
      verify(() => mockUseCase.call(any())).called(1);
    },
  );
}

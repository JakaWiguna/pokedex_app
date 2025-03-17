// Unit Test file for get_pokemon_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon_detail/domain/repository/pokemon_detail_repository.dart';
import 'package:pokedex_app/src/pokemon_detail/domain/usecase/get_pokemon_usecase.dart';

class MockPokemonDetailRepository extends Mock
    implements PokemonDetailRepository {}

void main() {
  late GetPokemonUseCase useCase;
  late MockPokemonDetailRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonDetailRepository();
    useCase = GetPokemonUseCase(mockRepository);
  });

  const tId = 1;
  const tPokemon = Pokemon(
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

  group('GetPokemonUseCase', () {
    test(
      'should get Pokemon from the repository',
      () async {
        // arrange
        when(() => mockRepository.getPokemon(tId))
            .thenAnswer((_) async => const Right(tPokemon));

        // act
        final result = await useCase(GetPokemonDetailParams(id: tId));

        // assert
        expect(result, equals(const Right(tPokemon)));
        verify(() => mockRepository.getPokemon(tId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return ServerFailure when repository returns ServerFailure',
      () async {
        // arrange
        when(() => mockRepository.getPokemon(tId)).thenAnswer(
          (_) async =>
              Left(ServerFailure(message: 'Server error', statusCode: '500')),
        );

        // act
        final result = await useCase(GetPokemonDetailParams(id: tId));

        // assert
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, equals('Server error'));
            expect(failure.statusCode, equals('500'));
          },
          (pokemon) => fail('should not return Pokemon'),
        );
        verify(() => mockRepository.getPokemon(tId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return CacheFailure when repository returns CacheFailure',
      () async {
        // arrange
        when(() => mockRepository.getPokemon(tId)).thenAnswer(
          (_) async =>
              Left(CacheFailure(message: 'Cache error', statusCode: 404)),
        );

        // act
        final result = await useCase(GetPokemonDetailParams(id: tId));

        // assert
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, equals('Cache error'));
            expect(failure.statusCode, equals(404));
          },
          (pokemon) => fail('should not return Pokemon'),
        );
        verify(() => mockRepository.getPokemon(tId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}

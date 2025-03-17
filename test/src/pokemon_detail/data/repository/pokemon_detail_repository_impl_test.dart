import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/exceptions.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon_detail/data/repository/pokemon_detail_repository_impl.dart';

class MockPokedex extends Mock implements Pokedex {}

class MockPokemonEndpoint extends Mock implements NamedEndpoint<Pokemon> {}

void main() {
  late PokemonDetailRepositoryImpl repository;
  late MockPokedex mockPokedex;
  late MockPokemonEndpoint mockPokemonEndpoint;

  setUp(() {
    mockPokedex = MockPokedex();
    mockPokemonEndpoint = MockPokemonEndpoint();
    when(() => mockPokedex.pokemon).thenReturn(mockPokemonEndpoint);
    repository = PokemonDetailRepositoryImpl(mockPokedex);
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

  group('getPokemon', () {
    test(
      'should return Pokemon when the call to remote data source is successful',
      () async {
        // arrange
        when(() => mockPokemonEndpoint.get(id: tId))
            .thenAnswer((_) async => tPokemon);

        // act
        final result = await repository.getPokemon(tId);

        // assert
        expect(result, equals(const Right<Failure, Pokemon>(tPokemon)));
        verify(() => mockPokemonEndpoint.get(id: tId)).called(1);
        verifyNoMoreInteractions(mockPokemonEndpoint);
      },
    );

    test(
      'should return ServerFailure when the call to remote data source fails',
      () async {
        // arrange
        when(() => mockPokemonEndpoint.get(id: tId)).thenThrow(
          const ServerException(message: 'Server error', statusCode: '500'),
        );

        // act
        final result = await repository.getPokemon(tId);

        // assert
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, equals('Server error'));
            expect(failure.statusCode, equals('500'));
          },
          (pokemon) => fail('should not return Pokemon'),
        );
        verify(() => mockPokemonEndpoint.get(id: tId)).called(1);
        verifyNoMoreInteractions(mockPokemonEndpoint);
      },
    );

    test(
      'should return CacheFailure when the call to remote data source fails with CacheException',
      () async {
        // arrange
        when(() => mockPokemonEndpoint.get(id: tId)).thenThrow(
          const CacheException(message: 'Cache error', statusCode: 404),
        );

        // act
        final result = await repository.getPokemon(tId);

        // assert
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, equals('Cache error'));
            expect(failure.statusCode, equals(404));
          },
          (pokemon) => fail('should not return Pokemon'),
        );
        verify(() => mockPokemonEndpoint.get(id: tId)).called(1);
        verifyNoMoreInteractions(mockPokemonEndpoint);
      },
    );

    test(
      'should return ServerFailure when unexpected error occurs',
      () async {
        // arrange
        when(() => mockPokemonEndpoint.get(id: tId)).thenThrow(Exception());

        // act
        final result = await repository.getPokemon(tId);

        // assert
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, equals('Unexpected error: Exception'));
            expect(failure.statusCode, equals(500));
          },
          (pokemon) => fail('should not return Pokemon'),
        );
        verify(() => mockPokemonEndpoint.get(id: tId)).called(1);
        verifyNoMoreInteractions(mockPokemonEndpoint);
      },
    );
  });
}

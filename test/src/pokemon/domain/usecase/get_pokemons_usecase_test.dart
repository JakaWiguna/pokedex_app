import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/src/pokemon/domain/repository/pokemon_repository.dart';
import 'package:pokedex_app/src/pokemon/domain/usecase/get_pokemons_usecase.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late GetPokemonsUseCase useCase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    useCase = GetPokemonsUseCase(mockRepository);
  });

  final params = GetPokemonParams(limit: 10, offset: 0);

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
  group('GetPokemonsUseCase', () {
    test(
        'should return a list of Pokemon when '
        'the repository call is successful', () async {
      // Arrange
      when(() => mockRepository.getPokemons(params.limit, params.offset))
          .thenAnswer((_) async => Right(pokemons));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, equals(Right<dynamic, List<Pokemon>>(pokemons)));
      verify(() => mockRepository.getPokemons(params.limit, params.offset))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a ServerFailure when the repository call fails',
        () async {
      // Arrange
      final failure = ServerFailure(message: 'Server error', statusCode: '500');
      when(() => mockRepository.getPokemons(params.limit, params.offset))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, equals(Left<ServerFailure, dynamic>(failure)));
      verify(() => mockRepository.getPokemons(params.limit, params.offset))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

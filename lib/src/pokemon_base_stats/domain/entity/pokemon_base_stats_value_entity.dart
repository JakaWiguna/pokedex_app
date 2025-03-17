import 'package:equatable/equatable.dart';

class PokemonBaseStatsValueEntity extends Equatable {
  const PokemonBaseStatsValueEntity({
    required this.value,
    required this.minValue,
    required this.maxValue,
  });

  final int value;
  final int minValue;
  final int maxValue;

  @override
  List<Object> get props => [value, minValue, maxValue];
}

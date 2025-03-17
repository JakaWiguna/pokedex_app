import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/core/common/widgets/badge_type.dart';
import 'package:pokedex_app/core/extensions/double_extensions.dart';
import 'package:pokedex_app/core/res/color.dart';
import 'package:pokedex_app/core/utils/constants.dart';
import 'package:pokedex_app/core/utils/pair.dart';

class PokemonBaseStatsTypesList extends StatelessWidget {
  const PokemonBaseStatsTypesList({
    required this.defenses,
    super.key,
  });

  final List<Pair<String, double>> defenses;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(color: ColorRes.textGrey);
    return LayoutBuilder(
      builder: (context, constraints) {
        final slices = defenses.slices(constraints.maxWidth ~/ 46);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...slices.map(
              (types) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.m),
                child: Row(
                  children: [
                    ...types.map(
                      (type) => Padding(
                        padding: const EdgeInsets.only(
                          right: AppSpacing.s,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BadgeType.circular(
                              type: type.first,
                              diameter: 34,
                              diameterPadding: 6,
                            ),
                            Text(
                              type.second.toEffectivenessFactor(),
                              style: textTheme,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokedex_app/core/common/widgets/stat_chart.dart';
import 'package:pokedex_app/core/res/color.dart';

class StatLine extends StatelessWidget {
  const StatLine({
    required this.color,
    required this.title,
    required this.value,
    required this.totalValue,
    super.key,
  });

  final Color color;
  final String title;
  final int value;
  final int totalValue;

  @override
  Widget build(BuildContext context) {
    final adjustedValue = value > totalValue ? totalValue : value;
    final adjustedTotal = value > totalValue ? value : totalValue;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: textTheme.labelLarge?.copyWith(color: ColorRes.textGrey),
            ),
          ),
        ),
        Expanded(
          child: Text(
            adjustedValue.toString(),
            style: textTheme.labelLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child:
                StatChart(factor: adjustedValue / adjustedTotal, color: color),
          ),
        ),
      ],
    );
  }
}

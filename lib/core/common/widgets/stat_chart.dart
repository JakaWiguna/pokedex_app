import 'package:flutter/material.dart';
import 'package:pokedex_app/core/utils/constants.dart';

class StatChart extends StatefulWidget {
  const StatChart({
    required this.factor,
    required this.color,
    super.key,
  });

  final double factor;
  final Color color;

  @override
  State<StatChart> createState() => _StatChartState();
}

class _StatChartState extends State<StatChart> {
  var _animated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          _animated = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: AppSpacing.xs,
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color: Colors.grey.withValues(alpha: 0.1),
            ),
          ),
        ),
        Container(
          height: AppSpacing.xs,
          alignment: Alignment.centerLeft,
          child: AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 300),
            widthFactor: _animated ? widget.factor : 0.0,
            heightFactor: 1,
            child: Container(
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: widget.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

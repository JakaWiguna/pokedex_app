import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_app/core/res/media.dart';
import 'package:pokedex_app/core/utils/constants.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    required this.onTap,
    super.key,
    this.textColor = Colors.black,
    this.hideAsset = false,
    this.assetSize = 200.0,
  });

  final VoidCallback? onTap;
  final Color textColor;
  final bool hideAsset;
  final double assetSize;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final information =
        Random().nextBool() ? _ErrorPage.snorlax() : _ErrorPage.magikarp();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!hideAsset) ...{
              SizedBox(
                height: assetSize,
                child: information.asset,
              ),
              const SizedBox(height: AppSpacing.m),
            },
            Text(
              information.title,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: AppSpacing.s),
            Text(
              information.subtitle,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(color: textColor),
            ),
            const SizedBox(height: AppSpacing.m),
            Container(
              constraints: const BoxConstraints(minWidth: 200),
              child: FilledButton(
                onPressed: onTap,
                child: Text(information.tryAgain),
              ),
            ),
          ],
        ),
      ),
    ).animate().fade().scale();
  }
}

class _ErrorPage {
  _ErrorPage({
    required this.title,
    required this.subtitle,
    required this.tryAgain,
    required this.asset,
  });

  factory _ErrorPage.magikarp() => _ErrorPage(
        title: 'Oh no! Magikarp slipped off the hook! 🎣🐟',
        subtitle: 'Better luck next time, Trainer! Use Rod to catch it later.',
        tryAgain: 'Use Rod',
        asset: Image.asset(
          MediaRes.magikarp,
        ),
      );

  factory _ErrorPage.snorlax() => _ErrorPage(
        title: 'Looks like Snorlax is blocking the way! 💤',
        subtitle: 'Use Poké Flutter to catch it later.',
        tryAgain: 'Use Poké Flutter',
        asset: SvgPicture.asset(
          MediaRes.snorlax,
        ),
      );

  final String title;
  final String subtitle;
  final String tryAgain;
  final Widget asset;
}

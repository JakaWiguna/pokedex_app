import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex_app/core/res/color.dart';
import 'package:pokedex_app/core/res/media.dart';

class PokeballScaffold extends Scaffold {
  PokeballScaffold({
    super.key,
    super.appBar,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    super.persistentFooterButtons,
    super.drawer,
    super.onDrawerChanged,
    super.endDrawer,
    super.onEndDrawerChanged,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.backgroundColor,
    super.resizeToAvoidBottomInset,
    super.primary,
    super.drawerDragStartBehavior,
    super.extendBody,
    super.extendBodyBehindAppBar,
    super.drawerScrimColor,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture,
    super.endDrawerEnableOpenDragGesture,
    super.restorationId,
    super.persistentFooterAlignment,
    Widget? body,
  }) : super(
          body: Stack(
            fit: StackFit.expand,
            children: [
              const PositionedPokeball(),
              if (body != null) body,
            ],
          ),
        );
}

class PositionedPokeball extends StatelessWidget {
  const PositionedPokeball({
    super.key,
    this.widthFraction = 0.664,
    this.maxSize = 250,
  });
  final double widthFraction;
  final double maxSize;

  @override
  Widget build(BuildContext context) {
    final safeAreaTop = MediaQuery.paddingOf(context).top;
    final pokeballSize =
        min(MediaQuery.sizeOf(context).width * widthFraction, maxSize);
    const iconButtonPadding = EdgeInsets.symmetric(horizontal: 28);
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin =
        -(pokeballSize / 2 - safeAreaTop - kToolbarHeight / 2);
    final pokeballRightMargin =
        -(pokeballSize / 2 - iconButtonPadding.right - iconSize / 2);

    return Positioned(
      top: pokeballTopMargin,
      right: pokeballRightMargin,
      child: Image(
        image: const AssetImage(MediaRes.pokeball),
        width: pokeballSize,
        height: pokeballSize,
        color: ColorRes.textBlack.withValues(alpha: 0.05),
      ),
    );
  }
}

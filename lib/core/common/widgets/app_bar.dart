import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_app/core/utils/constants.dart';

class MovingTitleSliverAppBar extends StatelessWidget {
  const MovingTitleSliverAppBar({
    required this.systemUiOverlayStyle,
    this.colorTitle = Colors.black,
    super.key,
    this.title = 'Pokedex',
    this.expandedHeight = kToolbarHeight + 48,
    this.expandedFontSize = 30,
    this.leading = const Icon(
      FontAwesomeIcons.arrowLeft,
      color: Colors.black,
    ),
    this.trailing,
    this.onTrailingPressed,
    this.scrollOffset,
  });
  final String title;
  final Color? colorTitle;
  final double expandedHeight;
  final double expandedFontSize;
  final Widget leading;
  final Widget? trailing;
  final VoidCallback? onTrailingPressed;
  final double? scrollOffset;
  final SystemUiOverlayStyle systemUiOverlayStyle;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: systemUiOverlayStyle,
      expandedHeight: expandedHeight,
      pinned: true,
      backgroundColor: Colors.transparent,
      leading: _AppBarBackButton(icon: leading),
      leadingWidth: 75,
      actions: [
        if (trailing != null)
          _AppBarButton(
            onPressed: onTrailingPressed,
            icon: trailing!,
          ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final safeAreaTop = MediaQuery.paddingOf(context).top;
          final minHeight = safeAreaTop + kToolbarHeight;
          final maxHeight = expandedHeight + safeAreaTop;
          final percent = scrollOffset ??
              (constraints.maxHeight - minHeight) / (maxHeight - minHeight);

          const startX = 28;
          const endX = startX + AppSpacing.s;
          final dx = startX + endX - endX * percent;

          const startY = 80;
          final endY = minHeight / 2;
          final dy = startY + (endY - startY) * (1 - percent);

          return ColoredBox(
            color: scrollOffset == null
                ? Colors.white.withValues(alpha: 1 - percent)
                : Colors.transparent,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                  top: dy,
                  left: dx,
                  bottom: 12,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24 + (expandedFontSize - 24) * percent,
                      fontWeight: FontWeight.bold,
                      color: colorTitle,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AppBarBackButton extends StatelessWidget {
  const _AppBarBackButton({
    required this.icon,
  });
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: IconButton(
        icon: icon,
        onPressed: () {
          if (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          }
        },
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  const _AppBarButton({required this.icon, this.onPressed});
  final Widget icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}

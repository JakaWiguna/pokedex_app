// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_app/core/utils/constants.dart';

class MovingTitleSliverAppBar extends StatelessWidget {
  const MovingTitleSliverAppBar({
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
  });
  final String title;
  final double expandedHeight;
  final double expandedFontSize;
  final Widget leading;
  final Widget? trailing;
  final VoidCallback? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
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
          final percent =
              (constraints.maxHeight - minHeight) / (maxHeight - minHeight);

          const startX = 28;
          const endX = startX + AppSpacing.s;
          final dx = startX + endX - endX * percent;

          return ColoredBox(
            color: Colors.white.withValues(alpha: 1 - percent),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                  left: dx,
                  bottom: 12,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24 + (expandedFontSize - 24) * percent,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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

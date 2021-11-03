import 'package:flutter/material.dart';

import 'widgets.dart';

class BaseScaffold extends StatefulWidget {
  final bool isLeading;
  final bool isAppbar;
  final bool hasBack;
  final String? title;
  final Color? backgroundColor;
  final VoidCallback? onLeading;
  final bool? resizeToAvoidBottomInset;
  final FloatingActionButton? floatingActionButton;

  final Widget child;
  final Widget? leading;
  final List<Widget>? actions;

  final Color? appBarColor;
  final bool hasNavBar;

  const BaseScaffold({
    Key? key,
    this.backgroundColor,
    required this.child,
    this.isLeading = true,
    this.hasBack = false,
    this.title,
    this.actions,
    this.onLeading,
    this.isAppbar = true,
    this.leading,
    this.resizeToAvoidBottomInset,
    this.floatingActionButton,
    this.appBarColor,
    this.hasNavBar = false,
  }) : super(key: key);

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: widget.isAppbar
          ? AppBar(
              elevation: 0.0,
              centerTitle: true,
              backgroundColor: widget.appBarColor,
              leading: widget.isLeading
                  ? widget.leading ??
                      BackButton(onPressed: widget.onLeading ?? () => Navigator.of(context).maybePop())
                  : const SizedBox(),
              title: Transform.translate(
                offset: const Offset(0.0, 1.0),
                child: Texts(
                  widget.title ?? "",
                  fontSize: 15.0,
                ),
              ),
              actions: widget.actions,
            )
          : null,
      body: widget.child,
      // bottomNavigationBar: widget.hasNavBar ? const PMOCurvedNavigationBar() : null,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}

/*
class PMOCurvedNavigationBar extends StatelessWidget {
  const PMOCurvedNavigationBar({Key? key}) : super(key: key);
  static final List<CommonModel> list = [
    CommonModel(image: Assets.svgWallet, index: 0),
    CommonModel(image: Assets.svgContacts, index: 1),
    CommonModel(image: Assets.svgMarketplace, index: 2),
    CommonModel(image: Assets.svgConversation, index: 3),
    CommonModel(image: Assets.svgSettings, index: 4),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<BottomNavCubit>().state;

    return CurvedNavigationBarWidget(
      index: currentIndex,
      backgroundColor: Palette.transparent,
      buttonBackgroundColor: Palette.accentColor,
      height: navBarHeight,
      items: list
          .map(
            (e) => SvgPicture.asset(
              e.image!,
              color: e.index == currentIndex ? Colors.white : Theme.of(context).textTheme.bodyText2?.color,
            ),
          )
          .toList(),
      onTap: (index) => context.read<BottomNavCubit>().setIndex(index),
    );
  }
}
*/

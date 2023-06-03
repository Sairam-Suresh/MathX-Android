import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.outerTab, {super.key, required this.children});

  final String outerTab;
  final Map<dynamic, Widget> children;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.children.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          tabs: widget.children.keys
              .map((e) => Tab(
                      child: AutoSizeText(
                    e.toString(),
                    maxLines: 1,
                    minFontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  )))
              .toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.children.values.toList(),
          ),
        ),
      ],
    );
  }
}

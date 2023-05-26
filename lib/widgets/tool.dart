import 'package:flutter/material.dart';

class Tool extends StatefulWidget {
  Tool({Key? key, this.displayOptions, this.tabs, this.builder})
      : super(key: key);

  late List<Widget>? displayOptions;
  late Map<String, Widget>? tabs;
  late Widget Function(String tab)? builder;

  @override
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<Tool> {
  String activeTab = "";
  @override
  void initState() {
    activeTab = widget.tabs?.keys.first ?? "";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.displayOptions != null && widget.tabs != null
        ? DefaultTabController(
            length: widget.tabs!.values.toList().length,
            child: Scaffold(
              appBar: AppBar(
                title: Text("amongs"),
                bottom: TabBar(
                  tabs: widget.tabs!.keys
                      .map((key) => Tab(
                            child: widget.tabs![key],
                          ))
                      .toList(),
                  onTap: (index) {
                    setState(() {
                      activeTab = widget.tabs!.keys.toList()[index];
                    });
                  },
                ),
              ),
              body: TabBarView(
                children: List<Widget>.generate(
                    widget.tabs!.values.length,
                    (index) =>
                        widget.builder
                            ?.call(widget.tabs!.keys.toList()[index]) ??
                        Container()),
              ),
            ))
        : widget.builder?.call(activeTab) ?? Container();
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          tabs: const <Widget>[
            Tab(text: 'Overview'),
            Tab(text: 'Specifications'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Center(child: Text('${widget.outerTab}: Overview tab')),
              ),
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Center(
                    child: Text('${widget.outerTab}: Specifications tab')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

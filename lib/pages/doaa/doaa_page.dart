import 'package:flutter/material.dart';
import 'package:salam/global/components.dart';
import 'package:salam/pages/doaa/doaa_chosen.dart';
import 'package:salam/pages/doaa/doaa_nabwy.dart';
import 'package:salam/pages/doaa/doaa_quran.dart';
import 'package:salam/global/theme.dart';

class DoaaPage extends StatefulWidget {
  @override
  _DoaaPageState createState() => _DoaaPageState();
}

class _DoaaPageState extends State<DoaaPage> with TickerProviderStateMixin {
  final controller = PageController(initialPage: 0);
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    Components.colorss.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TabBar(
              indicatorWeight: 0,
              unselectedLabelColor: color2,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                color: color2.withOpacity(0.5),
                borderRadius: BorderRadius.circular(50),
              ),
              controller: tabController,
              tabs: <Widget>[
                _tabContainer("أدعية قرآنية"),
                _tabContainer("أدعية نبوية"),
                _tabContainer("أدعية مختارة"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                DoaaQuran(),
                DoaaNabawy(),
                DoaaChosen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _tabContainer(String text) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(text),
        alignment: Alignment.center,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salam/global/components.dart';
import 'package:salam/pages/doaa/doaa_page.dart';
import 'package:salam/pages/home/home.dart';
import 'package:salam/pages/qiblah/qiblah_page.dart';
import 'package:salam/pages/quran/quran_page.dart';
import 'package:salam/pages/quran/quran_surah_list.dart';
import 'package:salam/pages/zekr/zekr_page.dart';
import 'package:salam/global/theme.dart';
import 'package:theme_provider/theme_provider.dart';
import 'animated_bottom_bar.dart';

class BottomBarNavigation extends StatefulWidget {
  final List<BarItem> barItems = [
    BarItem(
      text: "قرآن",
      iconData: FontAwesomeIcons.quran,
      color: color1,
    ),
    BarItem(
      text: "ادعية",
      iconData: FontAwesomeIcons.prayingHands,
      color: color2,
    ),
    BarItem(
      text: "",
      iconData: Icons.home,
      color: color3,
      width: 0.0,
    ),
    BarItem(
      text: "أذكار",
      iconData: FontAwesomeIcons.pray,
      color: color4,
    ),
    BarItem(
      text: "بوصلة",
      iconData: FontAwesomeIcons.compass,
      color: color5,
    ),
  ];

  @override
  _BottomBarNavigationState createState() => _BottomBarNavigationState();
}

class _BottomBarNavigationState extends State<BottomBarNavigation> {
  int selectedBarIndex = 2;
  final _pagesOptions = [
    QuranSurahList(),
    DoaaPage(),
    Home(),
    ZekrPage(),
    QiblahPage(),
  ];

  String pathPDF = "";

  bool isSelected = true;

  @override
  void initState(){
    super.initState();
    Components.fromAsset('assets/pdfs/quran.pdf', 'quran.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
    setData();
  }

  /*<---------------- Load Saved Quran Page -------------------->*/

  setData() {
    Components.loadPageNumber().then((value) {
      setState(() {
        Components.savPagePrefs = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "سلام",
          style: TextStyle(
              color: (ThemeProvider.themeOf(context).data == lightThemee)
                  ? widget.barItems[selectedBarIndex].color
                  : Colors.white,
              fontSize: 15.0,
              fontFamily: 'hadith'),
        ),
        centerTitle: true,
        actions: <Widget>[
          /*<-------------------  Change Theme Icon  --------------------->*/

          _iconBtn(
            icon: (ThemeProvider.themeOf(context).data == lightThemee)
                ? FontAwesomeIcons.solidMoon
                : FontAwesomeIcons.moon,
            onPressed: ThemeProvider.controllerOf(context).nextTheme,
          ),
        ],
        /*<-------------------  Bookmark Icon  --------------------->*/
        leading: _iconBtn(
          icon: Icons.bookmark,
          tooltip: "المحفوظات",
          onPressed: () {
            if (Components.savPagePrefs == null) {
              Fluttertoast.showToast(msg: "لا يوجد علامات محفوظة");
            } else {
              Navigator.of(context).push(
                Components.pageTransition(
                  QuranPage(
                    path: pathPDF,
                    currentPageNumber: Components.savPagePrefs,
                  ),
                ),
              );
            }
          },
        ),
      ),
      body: _pagesOptions[selectedBarIndex],
      bottomNavigationBar: AnimatedBottomBar(
          barItems: widget.barItems,
          animationDuration: const Duration(milliseconds: 150),
          barStyle: BarStyle(fontSize: 13.0, iconSize: 22.0),
          onBarTap: (index) {
            setState(() {
              selectedBarIndex = index;
            });
          }),
    );
  }
   _iconBtn({IconData icon, Function onPressed, String tooltip}) {
    return IconButton(
      tooltip: tooltip,
      icon: Icon(
        icon,
        color: widget.barItems[selectedBarIndex].color,
      ),
      onPressed: onPressed,
      splashColor: widget.barItems[selectedBarIndex].color,
    );
  }
}

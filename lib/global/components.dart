import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salam/pages/quran/quran_page.dart';
import 'carousel_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Components {
  static List<Color> colors = [
    Colors.deepOrange[800],
    Colors.deepPurple[700],
    Colors.lightBlue[900],
    Colors.blue[800],
    Colors.red[800],
    Colors.purple[800],
    Colors.indigo[900],
    Colors.pink[800],
    Colors.green[700],
    Colors.cyan[800],
    Colors.deepPurpleAccent[700],
    Colors.blueAccent[700],
  ];

  /*<-----------------------------  Global Alert Dialog  ---------------------------------->*/

  static showGlobalDialog({String text, BuildContext context}) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: Text(text, style: Theme.of(context).textTheme.bodyText1),
    );
  }

  /*<-----------------------------  Container Model Colors List  ---------------------------------->*/

  static containerModelList(int length) {
    return List.generate(
      length,
      (i) => ContainerModel(
        color: colorss[i],
      ),
    );
  }

  /*<-----------------------------  Colors List  ---------------------------------->*/

  static List<Color> colorss =
      colors.reversed.expand((i) => [i, i, i, i, i]).toList();

  /*<-----------------------------  Shared Preferences  ---------------------------------->*/

  static int savPagePrefs;
  static SharedPreferences prefs;

  static Future<bool> savePageNumber(int pageNum) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.setInt("pageNumber", pageNum);
  }

  static Future<int> loadPageNumber() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getInt("pageNumber");
  }

  /*<-----------------------------  Load PDF  ---------------------------------->*/

  static Future<File> fromAsset(String asset, String filename) async {
    Completer<File> completer = Completer();
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      // var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  /*<----------------------------  Page Transition Function  --------------------------------->*/

  static pageTransition(Widget child) {
    return PageTransition(
      child: child,
      type: PageTransitionType.rightToLeftWithFade,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  static navigateToQuranPage(
      {BuildContext context, String path, int currentPageNum}) {
    return Navigator.of(context).push(
      pageTransition(
        QuranPage(
          path: path,
          currentPageNumber: currentPageNum,
        ),
      ),
    );
  }

  static globalMaterialBtn({BuildContext context, String text, Function onPressed, Color color}) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      onPressed: onPressed,
      child: Text(text, style: Theme.of(context).textTheme.button),
      color: color,
      shape: StadiumBorder(),
    );
  }
}

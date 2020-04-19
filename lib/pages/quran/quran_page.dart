import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fullpdfview/flutter_fullpdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salam/global/components.dart';
import 'package:theme_provider/theme_provider.dart';

class QuranPage extends StatefulWidget {
  final int currentPageNumber;
  final String path;
  const QuranPage({Key key, this.currentPageNumber, this.path})
      : super(key: key);

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  int pages = 0;
  bool isReady = false;
  String errorMessage = '';
  GlobalKey pdfKey = GlobalKey();
  DateTime backButtonPressedTime;

  @override
  Widget build(BuildContext context) {
    final Completer<PDFViewController> _controller =
        Completer<PDFViewController>();
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                color: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
                child: PDFView(
                  key: pdfKey,
                  filePath: widget.path,
                  fitEachPage: true,
                  fitPolicy: FitPolicy.BOTH,
                  enableSwipe: true,
                  autoSpacing: true,
                  pageFling: true,
                  defaultPage: widget.currentPageNumber - 1,
                  pageSnap: true,
                  backgroundColor: bgcolors.WHITE,
                  onRender: (_pages) {
                    setState(() {
                      pages = _pages;
                      isReady = true;
                    });
                  },
                  onError: (error) {
                    setState(() {
                      errorMessage = error.toString();
                    });
                  },
                  onPageError: (page, error) {
                    setState(() {
                      errorMessage = '$page: ${error.toString()}';
                    });
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                ),
              ),
              errorMessage.isEmpty
                  ? !isReady
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container()
                  : Center(child: Text(errorMessage)),
              /*<------------------------------  FAB Quran Page For Saving Page  ----------------------------------->*/
              Align(
                alignment: Alignment.bottomRight,
                child: FutureBuilder(
                    future: _controller.future,
                    builder: (context, snapshot) {
                      return FloatingActionButton.extended(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
                        ),
                        backgroundColor:Colors.white,
                        foregroundColor: Theme.of(context).primaryColor,
                        label: Text(
                          "اضافة علامة",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        icon: Icon(Icons.bookmark_border),
                        onPressed: () async {
                          Components.savePageNumber(
                                  await snapshot.data.getCurrentPage() + 1)
                              .then((value) {
                            showDialog(
                              context: context,
                              builder: (context) => Components.showGlobalDialog(
                                context: context,
                                text:
                                    "تم اضافة علامة الى الصفحة للرجوع اليها لاحقا",
                              ),
                            );
                          });
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*<------------------------------  On BackButton Pressed Function  ----------------------------------->*/

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime) > Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      Fluttertoast.showToast(msg: "اضغط مرة اخرى للرجوع");
      return false;
    }
    setState(() async {
      Components.savPagePrefs = await Components.loadPageNumber();
      Fluttertoast.cancel();
      Navigator.pop(context, true);
    });

    return true;
  }
}

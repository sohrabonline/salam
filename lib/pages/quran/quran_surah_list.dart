import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salam/global/components.dart';
import 'package:salam/global/theme.dart';
import 'package:salam/pages/quran/quran_page.dart';

class QuranSurahList extends StatefulWidget {
  @override
  _QuranSurahListState createState() => _QuranSurahListState();
}

class _QuranSurahListState extends State<QuranSurahList> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    Components.fromAsset('assets/pdfs/quran.pdf', 'quran.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/pdfs/quran_list.json'),
        builder: (context, snapshot) {
          var data = json.decode(snapshot.data.toString());
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text("q",
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontFamily: 'islamic', color: color1)),
                  );
                }
                if (index == 115) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ListTile(),
                  );
                } else {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.indigo[700],
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ListTile(
                      title: Text(
                        data[index - 1]["name"],
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                      trailing: Text(
                        data[index - 1]["page_number"].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                      leading: Text(
                        "$index",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          Components.pageTransition(
                            QuranPage(
                              path: pathPDF,
                              currentPageNumber: data[index - 1]["page_number"],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

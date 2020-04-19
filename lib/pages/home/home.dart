import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hijri/umm_alqura_calendar.dart';
import 'package:intl/intl.dart';
import 'package:salam/global/theme.dart';
import 'package:theme_provider/theme_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*<---------------------------  Date Variables  ------------------------------->*/
  final time = DateTime.now();

  final hijriDate = ummAlquraCalendar.now()..currentLocale = 'ar';

  var rnd;

  @override
  void initState(){
    super.initState();
    rnd = Random().nextInt(44);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        alignment: Alignment.center,
        /*<----------------------------- Date Widgets --------------------------------->*/
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*<---------------------  Hijri Date  -------------------------->*/

                  Text(hijriDate.toFormat("dd / mm / yyyy"),
                      style: Theme.of(context).textTheme.headline3),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 15)),

                  /*<---------------------  Arabic Month & Day  -------------------------->*/
                  Text(
                    hijriDate.toFormat("*--- DDDD ---* *--- MMMM ---*"),
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        fontFamily: 'lotus',
                        color:
                            // (ThemeProvider.themeOf(context).data ==
                            // lightThemee)
                            // ?
                            color3
                        // : Colors.white,
                        ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 15)),
/*<---------------------  Gregorian Date  -------------------------->*/
                  Text(DateFormat("*--- dd / MM / yyyy ---*").format(time),
                      style: Theme.of(context).textTheme.headline5),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (ThemeProvider.themeOf(context).data == lightThemee)
                      ? Colors.white
                      : Color(0xFF131424),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString("assets/pdfs/hadith.json"),
                    builder: (context, snapshot) {
                      var data = json.decode(snapshot.data.toString());
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        return Text(
                          data[rnd]["hadith"],
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(height: 1.5, fontSize: 17),
                          textAlign: TextAlign.center,
                        );
                      }
                    }),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: color3,
                borderRadius: BorderRadius.circular(25),
              ),

              child: Text("*--- هل صليت على النبى اليوم ؟؟ ---*", style: Theme.of(context).textTheme.button,),
            ),
          ],
        ),
      ),
    );
  }
}

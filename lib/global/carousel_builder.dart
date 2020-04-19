import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:salam/global/components.dart';
import 'package:theme_provider/theme_provider.dart';

import 'theme.dart';

class CarouselBuilder extends StatefulWidget {
  final String jsonFile;
  final List containerModelList;
  final String text;
  final Axis axis;

  const CarouselBuilder(
      {Key key, this.jsonFile, this.containerModelList, this.text, this.axis})
      : super(key: key);

  @override
  _CarouselBuilderState createState() => _CarouselBuilderState();
}

class _CarouselBuilderState extends State<CarouselBuilder> {
  @override
  void initState() {
    widget.containerModelList.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listModel = widget.containerModelList;
    var bgtheme = ThemeProvider.themeOf(context)
        .data
        .scaffoldBackgroundColor
        .withOpacity(0.6);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString(widget.jsonFile),
          builder: (context, snapshot) {
            var data = json.decode(snapshot.data.toString());
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return CarouselSlider.builder(
                enableInfiniteScroll: false,
                height: MediaQuery.of(context).size.height * 0.8,
                scrollDirection: widget.axis,
                autoPlay: false,
                enlargeCenterPage: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var dataName = data[index]["name"];
                  var dataNote = data[index]["note"];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: listModel[index].color,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 5),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text(
                              dataName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                    height: 1.5,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        (widget.text == "zekr")
                            ?
                            /*<----------------------------------  Zekr Page Second Child  ------------------------------------->*/
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      FloatingButton(
                                        mini: true,
                                        size: 24,
                                        icon: Icons.notification_important,
                                        foregroundColor: listModel[index].color,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                Components.showGlobalDialog(
                                              context: context,
                                              text: dataNote,
                                            ),
                                          );
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: bgtheme,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Text(
                                            "${listModel[index].counter}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                  color: (ThemeProvider.themeOf(
                                                                  context)
                                                              .data ==
                                                          lightThemee)
                                                      ? listModel[index].color
                                                      : Colors.white,
                                                  fontFamily: 'sanSerif',
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      FloatingButton(
                                        mini: false,
                                        icon: Icons.add,
                                        foregroundColor: listModel[index].color,
                                        onPressed: () {
                                          this.setState(() {
                                            listModel[index].counter += 1;
                                            print(listModel[index].counter);
                                          });
                                        },
                                      ),
                                      FloatingButton(
                                        mini: false,
                                        icon: Icons.refresh,
                                        foregroundColor: listModel[index].color,
                                        onPressed: () {
                                          setState(() {
                                            listModel[index].counter = 0;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            :
                            /*<----------------------------------  Doaa Page Second Child  ------------------------------------->*/
                            (widget.text == "doaa_chosen")
                                ? Padding(padding: const EdgeInsets.all(0))
                                : (widget.text == "doaa_quran")
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        alignment: Alignment.center,



                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor
                                                .withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(50)),



                                        child: Text(
                                          dataNote,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                color: (ThemeProvider.themeOf(
                                                                context)
                                                            .data ==
                                                        lightThemee)
                                                    ? listModel[index].color
                                                    : Colors.white,
                                              ),
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.centerRight,
                                        child: FloatingButton(
                                          mini: true,
                                          size: 24,
                                          icon: Icons.notification_important,
                                          foregroundColor:
                                              listModel[index].color,
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  Components.showGlobalDialog(
                                                context: context,
                                                text: dataNote,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class ContainerModel {
  final Color color;
  int counter;

  ContainerModel({this.color, this.counter = 0});
}

/*<--------------------------------  Button  -------------------------------------->*/

class FloatingButton extends StatelessWidget {
  final Color foregroundColor;
  final Function onPressed;
  final IconData icon;
  final bool mini;
  final double size;

  const FloatingButton(
      {Key key,
      this.foregroundColor,
      this.onPressed,
      this.icon,
      this.mini,
      this.size = 30});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: CircleBorder(),
      color:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
      onPressed: onPressed,
      padding: (!mini) ? const EdgeInsets.all(12.0): const EdgeInsets.all(10.0),
      child: Icon(
        icon,
        size: size,
        color: foregroundColor,
      ),
      elevation: 0,
    );
  }
}

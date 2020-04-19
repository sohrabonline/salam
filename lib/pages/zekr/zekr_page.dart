import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salam/global/carousel_builder.dart';
import 'package:salam/global/components.dart';

class ZekrPage extends StatefulWidget {
  @override
  _ZekrPageState createState() => _ZekrPageState();
}

class _ZekrPageState extends State<ZekrPage> {

  @override
  Widget build(BuildContext context) {
    return CarouselBuilder(
      text: "zekr",
      axis: Axis.horizontal,
      jsonFile: "assets/pdfs/zekr.json",
      containerModelList: Components.containerModelList(17),
    );
  }
}

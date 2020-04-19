import 'package:flutter/material.dart';
import 'package:salam/global/components.dart';
import 'package:salam/global/carousel_builder.dart';

class DoaaQuran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselBuilder(
      text: "doaa_quran",
      axis: Axis.vertical,
      jsonFile: "assets/pdfs/doaa_quran.json",
      containerModelList: Components.containerModelList(51),
    );
  }
}
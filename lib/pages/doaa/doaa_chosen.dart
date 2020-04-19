import 'package:flutter/material.dart';
import 'package:salam/global/components.dart';
import 'package:salam/global/carousel_builder.dart';

class DoaaChosen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselBuilder(
      text: "doaa_chosen",
      axis: Axis.vertical,
      jsonFile: "assets/pdfs/doaa_chosen.json",
      containerModelList: Components.containerModelList(30),
    );
  }
}
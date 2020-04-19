import 'package:flutter/material.dart';
import 'package:salam/global/components.dart';
import 'package:salam/global/carousel_builder.dart';

class DoaaNabawy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselBuilder(
      text: "doaa_nabwy",
      axis: Axis.vertical,
      jsonFile: "assets/pdfs/doaa_nabwy.json",
      containerModelList: Components.containerModelList(35),
    );
  }
}
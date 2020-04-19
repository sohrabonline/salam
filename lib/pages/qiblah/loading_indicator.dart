import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widget = CircularProgressIndicator();
    return Container(
      alignment: Alignment.center,
      child: widget,
    );
  }
}

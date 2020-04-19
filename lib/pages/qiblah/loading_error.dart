
import 'package:flutter/material.dart';
import 'package:salam/global/components.dart';
import 'package:salam/global/theme.dart';

class LocationErrorWidget extends StatelessWidget {
  final String error;
  final Function callback;

  const LocationErrorWidget({Key key, this.error, this.callback})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final box = SizedBox(height: 32);
    final errorColor = Color(0xffb00020);

    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_off,
              size: 150,
              color: errorColor,
            ),
            box,
            Text(
              error,
              style: Theme.of(context).textTheme.headline6.copyWith(color: errorColor),
            ),
            box,
            Components.globalMaterialBtn(
              context: context,
              color: color5,
              text: "حاول مرة اخرى",
              onPressed: () {
                if (callback != null) callback();
              },
            )
          ],
        ),
      ),
    );
  }
}


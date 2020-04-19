import 'dart:async';
import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salam/global/theme.dart';
import 'package:theme_provider/theme_provider.dart';

import 'loading_error.dart';
import 'loading_indicator.dart';

class QiblahCompass extends StatefulWidget {
  @override
  _QiblahCompassState createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: stream,
          builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return LoadingIndicator();
            if (snapshot.data.enabled == true) {
              switch (snapshot.data.status) {
                case GeolocationStatus.granted:
                  return QiblahCompassWidget();

                case GeolocationStatus.denied:
                  return LocationErrorWidget(
                    error: "تم رفض اذن خدمة تحديد الموقع",
                    callback: _checkLocationStatus,
                  );
                case GeolocationStatus.disabled:
                  return LocationErrorWidget(
                    error: "تم تعطيل خدمة تحديد الموقع",
                    callback: _checkLocationStatus,
                  );
                case GeolocationStatus.unknown:
                  return LocationErrorWidget(
                    error: "حدث خطأ فى تحديد الموقع",
                    callback: _checkLocationStatus,
                  );
                default:
                  return Container();
              }
            } else {
              return LocationErrorWidget(
                error: "يرجى تفعيل خدمة تحديد الموقع",
                callback: _checkLocationStatus,
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == GeolocationStatus.denied) {
      await FlutterQiblah.requestPermission();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }

  @override
  void dispose() {
    _locationStreamController.close();
    // FlutterQiblah().dispose();
    super.dispose();
  }
}

class QiblahCompassWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _compassSvg = SvgPicture.asset((ThemeProvider.themeOf(context).data == lightThemee) ? 'assets/compasslight.svg' : 'assets/compassdark.svg');
  final _needleSvg = SvgPicture.asset(
    (ThemeProvider.themeOf(context).data == lightThemee) ? 'assets/needlelight.svg' : 'assets/needledark.svg',
    fit: BoxFit.contain,
    height: 330,
    alignment: Alignment.center,
  );


    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LoadingIndicator();

        final qiblahDirection = snapshot.data;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: ((qiblahDirection.direction ?? 0) * (pi / 180) * -1),
                child: _compassSvg,
                alignment: Alignment.center,
              ),
              Transform.rotate(
                angle: ((qiblahDirection.qiblah ?? 0) * (pi / 180) * -1),
                child: _needleSvg,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "${qiblahDirection.offset.toStringAsFixed(3)}°",
                  style: TextStyle(
                      color: color5, fontWeight: FontWeight.bold, fontFamily: 'lotus'),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "{ قَدْ نَرَىٰ تَقَلُّبَ وَجْهِكَ فِي السَّمَاءِ ۖ فَلَنُوَلِّيَنَّكَ قِبْلَةً تَرْضَاهَا ۚ فَوَلِّ وَجْهَكَ شَطْرَ الْمَسْجِدِ الْحَرَامِ ۚ وَحَيْثُ مَا كُنْتُمْ فَوَلُّوا وُجُوهَكُمْ شَطْرَهُ ۗ }",
                  style: TextStyle(
                      color: color5, fontWeight: FontWeight.bold, fontFamily: 'lotus'),
                      textAlign: TextAlign.center,
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}

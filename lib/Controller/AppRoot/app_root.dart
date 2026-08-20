import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_app/Services/Routes/router.gr.dart';
import 'package:sample_app/Services/Theme/app_theme.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _event = EventChannel('flutter.native/merchantdeeplink');
  late StreamSubscription _deeplinkSubscription;

  @override
  void initState() {
    super.initState();

    AutoRouter.of(context).push(const Home());

    _deeplinkSubscription =
        _event.receiveBroadcastStream().listen(_parseDeeplinkUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _deeplinkSubscription.cancel();
  }

  void _parseDeeplinkUrl(url) {
    if (url != null) {
      debugPrint('MerchantApp request uri: $url');
      var uri = Uri.parse(url);
      String opType = uri.queryParameters['opType'].toString();
      if (opType.contains('SALE')) {
        AutoRouter.of(context).push(CartDetail(data: uri.queryParameters));
      } else {
        AutoRouter.of(context).push(Blank(data: uri.queryParameters));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.fiuuBlue, Color(0xFF001E52)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/images/standard-fiuu-logo.png',
                  width: 200.0,
                ),
              ),
              const SizedBox(height: 16.0),
              const SizedBox(
                width: 22.0,
                height: 22.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

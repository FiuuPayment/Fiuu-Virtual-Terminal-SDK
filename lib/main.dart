import 'package:flutter/material.dart';

import 'Services/Routes/router.gr.dart';

void main() {
  runApp(const AppRootMain());
}

class AppRootMain extends StatefulWidget {
  const AppRootMain({Key? key}) : super(key: key);

  @override
  _AppRootMainState createState() => _AppRootMainState();
}

class _AppRootMainState extends State<AppRootMain> {
  final _rootRouter = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Fiuu VT App2App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _rootRouter.delegate(),
      routeInformationParser: _rootRouter.defaultRouteParser(),
    );
  }
}

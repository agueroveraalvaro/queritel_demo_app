import 'package:flutter/material.dart';
import 'package:queritel_demo_app/src/pages/home_page.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget _defaultHome = HomePage();

  runApp(
      GetMaterialApp(
        title: 'Queritel Demo APP',
        debugShowCheckedModeBanner: false,
        home: _defaultHome,
        theme: ThemeData(
          primaryColor: Colors.orange,
          accentColor: Colors.red,
        ),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomePage(),
        },
      )
  );
}

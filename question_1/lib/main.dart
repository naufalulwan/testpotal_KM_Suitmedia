import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/main_provider.dart';
import 'views/first_screen.dart';
import 'views/second_screen.dart';
import 'views/third_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => MainProvider())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Question 1',
        home: FirstScreen(),
        initialRoute: '/first',
        routes: {
          '/first': (context) => FirstScreen(),
          '/second': (context) => SecondScreen(),
          '/third': (context) => ThirdScreen(),
        },
      ),
    );
  }
}

import 'package:flutter_master_extensions/flutter_master_extensions.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/login": (_) => const LoginScreen()},
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Padding(
        padding: 8.0.toPadding,
        child: const HomeScreen(),
      ),
    );
  }
}

class Routes {
  static const login = "/login";
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    '${[1, 2, 3, 4].mapList((f) => f.toDouble())}'.toLog;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(height: 100, width: 100)
              .withRoundCorners(backgroundColor: Colors.grey)
              .withShadow()
              .onTap(
                () async {
                  final result = await context.pushNamed(Routes.login);
                  '$result'.toLog;
                },
              )
              .withTooltip('just a tooltip')
              .onLongPress(() => 'long press'.toLog)
        ],
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: MaterialButton(
          child: const Text('Go Back'),
          onPressed: () => context.pop(),
        ),
      ),
    );
  }
}

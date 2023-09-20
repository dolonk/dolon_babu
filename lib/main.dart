/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'icon/icon_provider.dart';
import 'icon/icon_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IconProvider(),
      child: const MaterialApp(
        title: 'Icon App',
        home: IconScreen(),
      ),
    );
  }
}*/




import 'package:dolon_babu/background_image/database_helper.dart';
import 'package:dolon_babu/background_image/show_background_imaeg_screen.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundImageDatabaseHelper.database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: ShowBackgroundImageScreenState(),
      ),
    );
  }
}

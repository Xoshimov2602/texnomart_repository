import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:texnomart/di/di.dart';
import 'package:texnomart/presentation/screens/holder/holder_screen.dart';
import 'package:yandex_maps_mapkit_lite/init.dart' as init;

import 'data/hive/hive_helper.dart';
import 'main/bloc/main_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  await init.initMapkit(
      apiKey: 'a005a187-1aeb-43e0-b17b-3fba1751c187'
  );
  setup();
  runApp(BlocProvider(
    create: (context) => MainBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HolderScreen(),
    );
  }
}
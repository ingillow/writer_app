import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writer_app/controller/books_draft_controller.dart';
import 'package:writer_app/controller/settings_app_controller.dart';
import 'package:writer_app/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsAppController>(create: (context) => SettingsAppController()),
        ChangeNotifierProvider<BooksDraftController>(create: (context) => BooksDraftController())
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
          useMaterial3: true,
        ),
      ),
    );
  }
}

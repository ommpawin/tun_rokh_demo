import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tun_rokh_demo/screens/create_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:tun_rokh_demo/model/current_question_store.dart';
import 'package:tun_rokh_demo/export_screen_file.dart';

void main() {
  // runApp(MainApp("th_thai"));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    MainApp(
      fontFamily: "Prompt",
      languageUsing: "th_thai",
      appVersion: "1.0.1 DEMO",
      appLanguageUsingVersion: "1.0",
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({
    required this.fontFamily,
    required this.languageUsing,
    required this.appVersion,
    required this.appLanguageUsingVersion,
  });
  final String fontFamily;
  final String languageUsing;
  final String appVersion;
  final String appLanguageUsingVersion;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentQuestionStore>(create: (_) => CurrentQuestionStore()),
      ],
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: fontFamily),
        child: MaterialApp(
          title: 'ทันโรค',
          themeMode: ThemeMode.light,
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            canvasColor: Colors.blueGrey,
            splashColor: Colors.transparent,
            highlightColor: Colors.grey[100],
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: fontFamily,
          ),
          initialRoute: LandingSC.nameScreen,
          debugShowCheckedModeBanner: false,
          routes: {
            LandingSC.nameScreen: (context) => LandingSC(
                  appVersion: appVersion,
                  appLanguageId: languageUsing,
                  appLanguageVersion: appLanguageUsingVersion,
                ),
          },
        ),
      ),
    );
  }
}

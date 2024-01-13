import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sheti_next/translations/codegen_loader.g.dart';
import 'package:sheti_next/zebra/screen/farming/HomeScreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('mr'),
        Locale('ka')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp()
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShetiNext',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          primarySwatch: Colors.lightGreen,
          canvasColor: Colors.white,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            color: Colors.green,
              titleTextStyle : TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20),
            shadowColor: Colors.black.withOpacity(0.5),
            elevation: 20,


          )
        ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
        home: HomeScreen(),//DropdownSample()//

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
      ),
      body: Center(child: Container()),
    );
  }
}

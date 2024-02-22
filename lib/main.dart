import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:workmanager/workmanager.dart';


import 'src/ui/styles/pillkaboo_theme.dart';
import 'src/core/internationalization.dart';
import 'src/nav/nav.dart';
import 'src/data/local/shared_preference/app_state.dart';
import 'src/app/background_service.dart';
import 'src/app/app_lifecycle_reactor.dart';
import 'src/data/local/database/barcode_db_helper.dart';
import 'src/data/local/database/ingredients_db_helper.dart';
import 'src/data/local/database/processed_file_db_helper.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    checkAndUpdateData();
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addObserver(AppLifecycleReactor());
  usePathUrlStrategy();

  await PillKaBooTheme.initialize();

  // Initialize databases
  await BarcodeDBHelper.database;
  await IngredientsDBHelper.database;
  await ProcessedFileDBHelper.initializeDB();

  // request permission
  await Permission.camera.request();

  final appState = PKBAppState();
  await appState.initializePersistedState();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // TODO: set to false in production 
  );

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));

  Workmanager().registerPeriodicTask(
    "1",
    "periodicUpdateTask",
    frequency: const Duration(hours: 24*7),
  );

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = PillKaBooTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);

    Future.delayed(const Duration(milliseconds: 1000),
            () => setState(() => _appStateNotifier.stopShowingSplashImage()));
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
    _themeMode = mode;
    PillKaBooTheme.saveThemeMode(mode);
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PillKaBoo',
      localizationsDelegates: const [
        PKBLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('ko'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:test_project/generated/l10n.dart';
import 'package:test_project/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await S.load(const Locale('en'));

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleUnfocus(context),
      child: MaterialApp(
        title: S.current.numberTrivai,
        theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.green.shade800,
            onPrimary: Colors.black,
            secondary: Colors.green,
            onSecondary: Colors.indigo,
            error: Colors.red,
            onError: Colors.red.shade200,
            background: Colors.white,
            onBackground: Colors.grey,
            surface: Colors.lime,
            onSurface: Colors.lime.shade200,
          ),
        ),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const NumberTriviaPage(),
      ),
    );
  }
}

void _handleUnfocus(BuildContext context) {
  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

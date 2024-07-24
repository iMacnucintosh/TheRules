import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:therules/src/providers/shared_preferences_provider.dart';
import 'package:therules/src/providers/theme_provider.dart';
import 'package:therules/src/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const TheRules(),
    ),
  );
}

class TheRules extends ConsumerWidget {
  const TheRules({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final accentColor = ref.watch(accentColorProvider);

    return MaterialApp(
      title: 'TheRules',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: accentColor,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.grey[200]),
            foregroundColor: MaterialStatePropertyAll(Colors.grey[700]),
            textStyle: const MaterialStatePropertyAll(
              TextStyle(fontSize: 16),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            side: MaterialStatePropertyAll(
              BorderSide(
                width: 1.5,
                color: accentColor,
              ),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: accentColor,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.grey[800]),
            foregroundColor: MaterialStatePropertyAll(Colors.grey[200]),
            textStyle: const MaterialStatePropertyAll(
              TextStyle(fontSize: 16),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            side: MaterialStatePropertyAll(
              BorderSide(
                width: 1.5,
                color: accentColor,
              ),
            ),
          ),
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const Home(),
    );
  }
}

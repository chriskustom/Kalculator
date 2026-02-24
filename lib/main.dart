import 'package:flutter/material.dart';
import 'package:kalculator/kalculator/kalculator_page.dart';
import 'package:kalculator/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final darkMode = prefs.getBool('darkMode') ?? false;

  runApp(MyApp(isDarkMode: darkMode));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.dark(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.values.byName(isDarkMode ? 'dark' : 'light'),
      home: const MyHomePage(),
    );
  }

  Future<bool> getThemePref() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    return isDarkMode;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Kalculator'),
        actions: [
          PopupMenuButton<InkWell>(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                PopupMenuItem<InkWell>(
                  child: InkWell(
                    onTap: () => {},
                    child: Row(
                      mainAxisAlignment: .start,
                      children: [
                        Icon(Icons.settings),
                        const SizedBox(width: 8),
                        Text('Settings'),
                      ],
                    ),
                  ),
                ),
              ].toList();
            },
          ),
        ],
      ),
      body: KalculatorPage(),
    );
  }
}

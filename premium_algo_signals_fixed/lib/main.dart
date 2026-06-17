import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/signal_history_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/setup_guide_screen.dart';
import 'providers/signal_provider.dart';
import 'services/admob_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdMobService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignalProvider(),
      child: MaterialApp(
        title: 'Premium Algo Signals',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xFFC70849),
          scaffoldBackgroundColor: const Color(0xFF0A0A0A),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFC70849),
            secondary: Color(0xFF00DBFF),
            surface: Color(0xFF1A1A1A),
          ),
        ),
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/history': (context) => const SignalHistoryScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/guide': (context) => const SetupGuideScreen(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'appointments_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // In-memory lists for demo purposes (not persistent)
  final ValueNotifier<List<Map<String, dynamic>>> appointments = ValueNotifier([]);
  final ValueNotifier<List<Map<String, String>>> users = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppointmentBuddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFECE6DA), // Beige background
        primaryColor: Color(0xFF859A6A), // Olive green
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF859A6A),        // Olive
          secondary: Color(0xFF617073),      // Soft slate
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF859A6A), // Olive
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF859A6A), // Olive
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF617073) // Soft slate
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF859A6A)),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      routes: {
        '/': (context) => LoginPage(users: users),
        '/register': (context) => RegisterPage(users: users),
        '/home': (context) => HomePage(appointments: appointments),
        '/appointments': (context) => AppointmentsPage(appointments: appointments),
      },
    );
  }
}
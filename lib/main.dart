import 'package:mu3een_dashboard/controllers/user_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash/splash_screen.dart';
import 'controllers/menu_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserBloc()),
      ChangeNotifierProvider(create: (_) => MenuController()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mu3een',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: primaryColor,
              primary: primaryColor,
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            padding: const EdgeInsets.all(20),
          ),
        ),
      ),
      routes: {
        "/": (context) => const SplashScreen(),
      },
    );
  }
}

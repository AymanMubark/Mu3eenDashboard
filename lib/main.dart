import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mu3een_dashboard/controllers/user_bloc.dart';
import 'package:mu3een_dashboard/screens/login/login_screen.dart';
import 'package:mu3een_dashboard/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'controllers/menu_controller.dart';

const Color mainColor = Color(0xff00AD78);

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
              secondary: mainColor,
              primary: mainColor,
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
        "/": (context) => LoginScreen(),
        "/Main": (context) => MainScreen(),
      },
    );
  }
}

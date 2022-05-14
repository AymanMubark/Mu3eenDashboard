import 'package:mu3een_dashboard/screens/login/login_screen.dart';
import 'package:mu3een_dashboard/controllers/user_bloc.dart';
import 'package:mu3een_dashboard/widgets/svg_widget.dart';
import '../../services/local_storage_service.dart';
import 'package:mu3een_dashboard/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<UserBloc>().adminUser = null;
    dynamic user = await LocalStorageService().getUser;
    if (user != null) {
      context.read<UserBloc>().initUser(user, context);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const MainScreen()), (_) => true);
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SVGWidget(
          "logo",
          color: Colors.white,
        ),
      ),
    );
  }
}

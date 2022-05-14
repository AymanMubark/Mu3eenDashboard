import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mu3een_dashboard/screens/admins/admins_screen.dart';
import 'package:mu3een_dashboard/screens/admins/update_profile_screen.dart';
import 'package:mu3een_dashboard/screens/rewords/rewards_screen.dart';
import 'package:mu3een_dashboard/screens/volunteers/volunteers_screen.dart';
import 'package:provider/provider.dart';

import '../../../controllers/menu_controller.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../institution/institutions_screen.dart';
import '../../social_events/social_events_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              context.read<MenuController>().currentPage =
                  const DashboardScreen();
            },
          ),
          DrawerListTile(
            title: "Users",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              context.read<MenuController>().currentPage = const AdminsScreen();
            },
          ),
          DrawerListTile(
            title: "Events",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              context.read<MenuController>().currentPage =
                  const SocialEventsScreen();
            },
          ),
          DrawerListTile(
            title: "Institutions",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              context.read<MenuController>().currentPage =
                  const InstitutionsScreen();
            },
          ),
          DrawerListTile(
            title: "Volunteers",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              context.read<MenuController>().currentPage =
                  const VolunteersScreen();
            },
          ),
          DrawerListTile(
            title: "Rewards",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              context.read<MenuController>().currentPage =
                  const RewardsScreen();
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              context.read<MenuController>().currentPage =
                  const UpdateProfileScreen();
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}

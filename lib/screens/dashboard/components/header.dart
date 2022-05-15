import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controllers/menu_controller.dart';
import '../../../controllers/user_bloc.dart';
import '../../../responsive.dart';
import '../../../widgets/my_image.dart';
import '../../../widgets/svg_widget.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({
    Key? key,
    this.title = "Dashboard",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        if (context.read<UserBloc>().adminUser != null) ProfileCard(),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: primaryColor,
            backgroundImage: context.watch<UserBloc>().admin!.imageUrl != null
                ? NetworkImage(context.watch<UserBloc>().admin!.imageUrl!)
                : null,
            child: context.watch<UserBloc>().admin!.imageUrl != null
                ? null
                : const SVGWidget("logo"),
            radius: 20,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("${context.watch<UserBloc>().admin!.name}"),
            ),
          PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Text("Logout"),
                      onTap: () {
                        context.read<UserBloc>().applogout(context);
                      },
                    ),
                  ],
              child: const Icon(Icons.keyboard_arrow_down)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constants.dart';

class SocialEventTypeCardWidget extends StatelessWidget {
  const SocialEventTypeCardWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.amountOfFiles,
  }) : super(key: key);

  final String title;
  final int amountOfFiles;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: color,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Text("$amountOfFiles")
        ],
      ),
    );
  }
}

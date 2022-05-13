import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class SVGWidget extends StatelessWidget {
  final String name;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit boxFit;
  const SVGWidget(this.name,
      {Key? key,
      this.boxFit = BoxFit.contain,
      this.height,
      this.width,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      getSVGPath(name),
      height: height,
      width: width,
      color: color,
      fit: boxFit,
    );
  }
}

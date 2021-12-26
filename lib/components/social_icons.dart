import 'package:flutter/material.dart';
import 'package:queuems/utility/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIcon extends StatelessWidget {
  final String svgPic;
  final VoidCallback press;
  const SocialIcon({
    required this.svgPic,
    required this.press,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: kprimaryColor),
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: press,
            child: SvgPicture.asset(
              svgPic,
              height: 20,
              width: 20,
            ),
          ),
        ),
      ],
    );
  }
}

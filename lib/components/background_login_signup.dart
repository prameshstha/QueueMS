import 'package:flutter/material.dart';
import 'package:queuems/utility/constant.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
                height: size.height,
                width: double.infinity,
                child: Stack(children: [
                  Container(
                    height: size.height * 0.55,
                    decoration: const BoxDecoration(
                        color: kprimaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                  ),

                  //parameter 'child' from body
                  child,
                ])),
          ],
        ),
      ),
    );
  }
}

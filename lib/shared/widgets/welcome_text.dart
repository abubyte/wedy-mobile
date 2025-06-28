import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Wedy.",
          style: TextStyle(
            color: Color(0xff614C39),
            fontFamily: "SFProHeavy",
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),

        Text(
          "Xush kelibsiz!",
          style: TextStyle(color: Color(0xffC3A183), fontWeight: FontWeight.w700, fontSize: 22),
        ),
      ],
    );
  }
}

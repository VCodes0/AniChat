import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double buttonHeight = size.height * 0.06;
    double iconSize = buttonHeight * 0.5;
    double fontSize = size.width * 0.04;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: SizedBox(
          height: buttonHeight.clamp(45.0, 60.0),
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/google.png',
              height: iconSize.clamp(20.0, 28.0),
            ),
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Continue with Google',
                style: TextStyle(
                  fontSize: fontSize.clamp(14.0, 18.0),
                  color: CupertinoColors.black,
                ),
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: CupertinoColors.systemGrey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

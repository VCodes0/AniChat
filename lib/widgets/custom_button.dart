import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CustomButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    if (Platform.isIOS) {
      return SizedBox(
        width: double.infinity,
        height: mq.height * 0.07,
        child: CupertinoButton(
          color: CupertinoColors.systemBlue,
          borderRadius: BorderRadius.circular(12),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(
              fontSize: mq.width * 0.045,
              color: CupertinoColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else {
      return Material(
        color: CupertinoColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            height: mq.height * 0.07,
            decoration: BoxDecoration(
              color: CupertinoColors.systemBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text,
              style: TextStyle(
                fontSize: mq.width * 0.045,
                color: CupertinoColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }
  }
}

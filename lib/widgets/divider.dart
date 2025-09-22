import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: CupertinoColors.black)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('or'),
        ),
        Expanded(child: Divider(color: CupertinoColors.black)),
      ],
    );
  }
}

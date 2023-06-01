import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppealCard extends HookConsumerWidget {
  const AppealCard({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 180,
      width: 360,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff3f3f3f),
            offset: Offset(2, 2),
            blurRadius: 5,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          backgroundColor: const Color(0xfff5f5f5),
        ),
        onPressed: () {},
        child: Container(),
      ),
    );
  }
}

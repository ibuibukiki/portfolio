import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScreenPictures extends HookConsumerWidget {
  const ScreenPictures({
    required this.index,
    required this.pictureList,
    Key? key,
  }) : super(key: key);
  final ValueNotifier<int> index;
  final List<Widget> pictureList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget pictureButton(ValueNotifier<int> index, int id) {
      return Container(
        height: 16,
        width: 16,
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: index.value == id
                ? const Color(0xff3f3f3f)
                : const Color(0xfff5f5f5),
            shape: const CircleBorder(),
          ),
          child: const SizedBox(),
          onPressed: () {
            index.value = id;
          },
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // スクリーンの例を前に戻すボタン
        Container(
          margin: const EdgeInsets.only(bottom: 100),
          child: IconButton(
            icon: const Icon(
              Icons.navigate_before_rounded,
              size: 60,
            ),
            color: const Color(0xff252525),
            onPressed: () {
              index.value--;
              if (index.value == -1) {
                index.value = 3;
              }
            },
          ),
        ),
        const SizedBox(width: 40),
        // スクリーン
        Column(
          children: [
            const SizedBox(height: 60),
            Container(
              height: 400,
              width: 200,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff3f3f3f),
                    offset: Offset(2, 2),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: pictureList[index.value],
            ),
            const SizedBox(height: 24),
            // インジケータ―
            Row(
              children: [
                pictureButton(index, 0),
                pictureButton(index, 1),
                pictureButton(index, 2),
                pictureButton(index, 3),
              ],
            ),
          ],
        ),
        // スクリーンの例を次に進めるボタン
        Container(
          margin: const EdgeInsets.only(bottom: 100),
          child: IconButton(
            icon: const Icon(
              Icons.navigate_next_rounded,
              size: 60,
            ),
            color: const Color(0xff252525),
            onPressed: () {
              index.value++;
              if (index.value == 4) {
                index.value = 0;
              }
            },
          ),
        ),
      ],
    );
  }
}

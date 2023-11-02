import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../component/screen_pictures.dart';
import '../component/appeal_card.dart';

class OkoScreen extends HookConsumerWidget {
  const OkoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final index = useState(0);
    final pictureList = [
      Image.asset('assets/img/oko_calendar.png', height: 600),
      Image.asset('assets/img/oko_home.png', height: 600),
      Image.asset('assets/img/oko_input.png', height: 600),
      Image.asset('assets/img/oko_output.png', height: 600),
    ];

    final textList1 = [
      "電卓のキーボードを実装",
      "デフォルトのキーボードを採用せず,\n電卓用のキーボードを自作",
      "・入力した計算式を表示",
      "・数字を入力するたびに答えを計算",
    ];

    final textList2 = [
      "エフェクトの実装",
      "連続でタップした時に\n予期せぬ動作がおこらないように工夫",
      "・タップした部分が浮き出るように表示",
      "・ウインドウをタップした位置の反対側に表示",
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: null,
        toolbarHeight: 0,
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: const Color(0xffdcdcdc),
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 40,
                  ),
                  color: const Color(0xff252525),
                  onPressed: () {
                    Navigator.of(context).pop(0);
                  },
                ),
                ScreenPictures(
                  index: index,
                  pictureList: pictureList,
                ),
                const SizedBox(width: 60),
                SizedBox(
                  height: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        "カレンダーで管理できるお小遣い帳",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        "毎日の出費・収入をカレンダーに入力！\nカテゴリごとにまとめてお金を管理しよう",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Android版 リリース済み",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "使用した言語 : Dart\n使用したフレームワーク : Flutter",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "特に力を入れた部分",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          AppealCard(
                            path: "oko_keyboard.mp4",
                            textList: textList1,
                          ),
                          const SizedBox(width: 24),
                          AppealCard(
                            path: "oko_detail.mp4",
                            textList: textList2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

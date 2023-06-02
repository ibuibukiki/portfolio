import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../component/screen_pictures.dart';
import '../component/appeal_card.dart';

class BaseballScreen extends HookConsumerWidget {
  const BaseballScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final index = useState(0);
    final pictureList = [
      Image.asset('assets/img/baseball_score.png', height: 600),
      Image.asset('assets/img/baseball_rule.png', height: 600),
      Image.asset('assets/img/baseball_share1.png', height: 600),
      Image.asset('assets/img/baseball_share2.png', height: 600),
    ];

    final textList1 = [
      "画面の向きによってレイアウトを変更",
      "画面を回転させることで,\n縦横それぞれで画面を表示",
      "・得点板が全て表示される横画面を実装",
      "・関係ないボタンを隠した全画面表示を実装",
    ];

    final textList2 = [
      "サーバーとの通信を実装",
      "試合コードを共有することで\nリアルタイムで試合状況を共有",
      "・WebSocket通信を実装",
      "・サーバーから受信した内容をすぐに反映",
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
                        "リアルタイムで野球のスコアを共有",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        "野球の試合結果をリアルタイムで共有！\nいつでもどこでも試合の進み具合を確認しよう",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Android版 リリース準備中",
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
                            path: "baseball_direction.mp4",
                            textList: textList1,
                          ),
                          const SizedBox(width: 24),
                          AppealCard(
                            path: "baseball_share.mp4",
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

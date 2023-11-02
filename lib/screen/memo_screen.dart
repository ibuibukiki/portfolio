import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../component/screen_pictures.dart';
import '../component/appeal_card.dart';

class MemoScreen extends HookConsumerWidget {
  const MemoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final index = useState(0);
    final pictureList = [
      Image.asset('assets/img/memo_home.png', height: 600),
      Image.asset('assets/img/memo_select.png', height: 600),
      Image.asset('assets/img/memo_search.png', height: 600),
      Image.asset('assets/img/memo_new.png', height: 600),
    ];

    final textList1 = [
      "フォルダの階層構造を実装",
      "階層構造が成り立つように\nデータベースを設計",
      "・木構造の要領で階層構造を作成",
      "・枝をたどることでパンくずリストを作成",
    ];

    final textList2 = [
      "編集機能を実装",
      "コマンド Z , コマンド Y の\n役割を持つボタンを実装",
      "・入力した内容をログとして持っておく",
      "・ボタンの操作に従ってログを移動",
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
                        "フォルダ分けできるメモ帳",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        "フォルダ整理も簡単！\nカテゴリごとにまとめてメモ帳を管理しよう",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Android・ios リリース済み",
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
                            path: "memo_directory.mp4",
                            textList: textList1,
                          ),
                          const SizedBox(width: 24),
                          AppealCard(
                            path: "memo_edit.mp4",
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

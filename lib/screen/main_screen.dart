import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'oko_screen.dart';
import 'memo_screen.dart';
import 'baseball_screen.dart';
import 'sensor_screen.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final isMouseHover = useState("");

    Widget appCard(String appName, String imgPath) {
      return Container(
        height: 360,
        width: 260,
        margin: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xfff5f5f5),
          boxShadow: [
            BoxShadow(
              color: Color(0xff3f3f3f),
              offset: Offset(2, 2),
              blurRadius: 5,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: InkWell(
          onHover: (isHover) {
            if (isHover) {
              isMouseHover.value = appName;
            } else {
              isMouseHover.value = "";
            }
          },
          onTap: () {
            if (imgPath.contains("oko")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OkoScreen(),
                ),
              );
            } else if (imgPath.contains("memo")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MemoScreen(),
                ),
              );
            } else if (imgPath.contains("baseball")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BaseballScreen(),
                ),
              );
            } else if (imgPath.contains("sensor")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SensorScreen(),
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
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
                  child: Image.asset('assets/img/$imgPath', height: 320),
                ),
                Container(
                  height: 360,
                  width: 260,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      stops: [
                        0.3,
                        0.6,
                        0.9,
                      ],
                      colors: [
                        Color(0x00262626),
                        Color(0x3f262626),
                        Color(0xca262626),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      appName,
                      style: TextStyle(
                        fontSize: isMouseHover.value == appName ? 20 : 18,
                        fontWeight: isMouseHover.value == appName
                            ? FontWeight.w900
                            : FontWeight.w600,
                        color: const Color(0xfff5f5f5),
                      ),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: null,
        toolbarHeight: 0,
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.only(left: 24, top: 24),
        color: const Color(0xffdcdcdc),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "ibuibukiki Portfolio",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 60),
              const Text(
                "過去に作成したアプリ一覧",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: screenWidth,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appCard("カレンダーで管理できる\nお小遣い帳", "oko_calendar.png"),
                      appCard("フォルダ分けできる\nメモ帳", "memo_home.png"),
                      appCard("リアルタイムで\n野球の試合結果を共有", "baseball_score.png"),
                      appCard("慣性センサのデータを\nリアルタイムで表示", "sensor_home.png"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

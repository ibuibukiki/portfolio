import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

class AppealCard extends HookConsumerWidget {
  const AppealCard({
    required this.path,
    required this.textList,
    Key? key,
  }) : super(key: key);
  final String path;
  final List<String> textList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMouseHover = useState(false);
    final videoController =
        useState(VideoPlayerController.asset('assets/img/$path'));

    useEffect(() {
      videoController.value.initialize();
      return null;
    }, []);

    return Container(
      height: 180,
      width: 360,
      decoration: BoxDecoration(
        color: isMouseHover.value
            ? const Color(0xf0f5f5f5)
            : const Color(0xfff5f5f5),
        boxShadow: const [
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
          isMouseHover.value = isHover;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textList[0].contains("画面の向き")
                    ? "画面の向きによって\nレイアウトを変更"
                    : textList[0],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 2,
                width: textList[0].contains("画面の向き")
                    ? 280
                    : textList[0].length * 24.0 + 8.0,
                color: const Color(0xffdcdcdc),
              ),
              const SizedBox(height: 2),
              Container(
                height: 2,
                width: textList[0].contains("画面の向き")
                    ? 280
                    : textList[0].length * 24.0 + 8.0,
                color: const Color(0xffdcdcdc),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        onTap: () {
          showDialog<void>(
              context: context,
              builder: (_) {
                // クリックしたら表示される
                return AlertDialog(
                  title: SizedBox(
                    width: 600,
                    child: Row(
                      children: [
                        Text(
                          textList[0], //"電卓のキーボードを実装",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop(0);
                          },
                        ),
                      ],
                    ),
                  ),
                  content: Container(
                    height: 400,
                    width: 720,
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            Container(
                              height: 360,
                              width:
                                  path.contains("oko") || path.contains("memo")
                                      ? 180
                                      : 200,
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
                              child: AspectRatio(
                                aspectRatio:
                                    videoController.value.value.aspectRatio,
                                // 動画を表示
                                child: VideoPlayer(videoController.value),
                              ),
                            ),
                            const SizedBox(width: 50),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textList[
                                      1], //"デフォルトのキーボードを採用せず,\n電卓用のキーボードを自作",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 60),
                                Text(
                                  textList[2], //"・入力した途中式を表示",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  textList[3], //"・数字を入力するたびに答えを計算",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    videoController.value.value.isPlaying
                                        ? const Text(
                                            "プレビューを停止",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        : const Text(
                                            "プレビューを再生",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                    const SizedBox(width: 20),
                                    videoController.value.value.isPlaying
                                        ? IconButton(
                                            onPressed: () {
                                              // 動画を停止
                                              videoController.value.pause();
                                            },
                                            icon: const Icon(Icons.pause),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              // 動画を再生
                                              videoController.value.play();
                                            },
                                            icon: const Icon(Icons.play_arrow),
                                          ),
                                  ],
                                ),
                                const SizedBox(height: 60),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

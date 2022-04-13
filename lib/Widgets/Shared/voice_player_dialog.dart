import 'package:audioplayers/audioplayers.dart';
import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/get/get_rx/src/rx_types/rx_types.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/material.dart';

class VoicePlayerDialog extends StatefulWidget {
  final CustomFileModel? file;
  final String? url;
  final bool? fromDashboard;

  const VoicePlayerDialog({
    Key? key,
    this.file,
    this.fromDashboard,
    this.url,
  }) : super(key: key);

  @override
  State<VoicePlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VoicePlayerDialog> {
  // final player = AudioPlayer();

  bool isPlay = false;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration totalDuration = Duration.zero;
  Duration position = Duration.zero;

  // String? myUrl;

  @override
  void initState() {
    palyAudio();
    super.initState();
  }

  //
  // Future<void> initPlayer()async{
  //   controller = VideoPlayerController.network(widget.url!);
  //   await Future.wait([controller.initialize()]);
  //   chewieController = ChewieController(
  //     videoPlayerController: controller,
  //     autoPlay: true,
  //     looping: true,
  //     materialProgressColors: ChewieProgressColors(
  //       playedColor: Colors.red
  //     )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ViewUtils.boxShadow(
            blurRadius: 12.0,
            spreadRadius: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.close(1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorUtils.mainRed,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  if (widget.file?.name is String)
                    Text(
                      widget.file?.name ?? "",
                      style: const TextStyle(
                        color: ColorUtils.black,
                        fontSize: 16.0,
                      ),
                    ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: Get.width,
                  height: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: () {
                                // audioPlayer
                                //     .play(
                                //   widget.file!.url!.replaceAll('http', 'https'),
                                //   volume: 1.0,
                                // );
                                palyAudio();
                                print(widget.file!.url!);
                              }),
                          IconButton(
                              icon: const Icon(Icons.pause),
                              onPressed: () {
                                audioPlayer.pause();
                              }),
                          IconButton(
                            icon: const Icon(Icons.stop),
                            onPressed: () {
                              audioPlayer.stop();
                            },
                          ),
                        ],
                      ),

                      Slider(
                        activeColor: const Color(0xfff00d9be),
                        value: position.inMilliseconds.toDouble(),
                        min: 0,
                        max: totalDuration.inMilliseconds.toDouble() + 10,
                        onChanged: (value) {
                          audioPlayer
                              .seek(Duration(milliseconds: value.toInt()));
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width * .05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTimeString(totalDuration),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              getTimeString(position),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Slider(
                      //   value: 0.0,
                      //   onChanged: (double value) async {
                      //     // int result = await audioPlayer.seek(
                      //     //   Duration(
                      //     //     milliseconds: value.toInt(),
                      //     //   ),
                      //     // );
                      //     // return audioPlayer.seek((value / 1000).roundToDouble());
                      //   },
                      //   min: 0.0,
                      //   max: maxL,
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getTimeString(Duration time) {
    final int hour = time.inSeconds ~/ 60;
    final int minutes = time.inSeconds % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }

  palyAudio() async {
    await audioPlayer.play(
      widget.file!.url!.replaceAll('http', 'https'),
      volume: 1.0,
    );

    audioPlayer.onAudioPositionChanged.listen((pos) {
     if(mounted){
       setState(() {
         position = pos;
       });
     }
    });

    audioPlayer.onDurationChanged.listen((dur) {
      totalDuration = dur;
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      audioPlayer.seek(Duration.zero);
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    // controller.dispose();
    // chewieController.dispose();
    // chewieController.pause();
    super.dispose();
  }
}

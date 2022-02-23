import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerDialog extends StatefulWidget {
  final CustomFileModel? file;
  final String? url;
  final bool? fromDashboard;

  const VideoPlayerDialog({
    Key? key,
    this.file,
    this.fromDashboard,
    this.url,
  }) : super(key: key);

  @override
  State<VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {

  double opacity = 1.0;

  // String? myUrl;da

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
  void initState() {
    // String url = widget.url ?? widget.file!.url!;
    // url = url.replaceAll('http://', 'https://');
    // myUrl = url;
    // controller = VideoPlayerController.network(
    //   url,
    // )..initialize().then((_) {
    //     chewieController = ChewieController(
    //       videoPlayerController: controller,
    //       allowFullScreen: true,
    //       allowMuting: true,
    //       showControlsOnInitialize: true,
    //       allowPlaybackSpeedChanging: true,
    //       showControls: true,
    //       autoPlay: true,asda
    //       showOptions: true,
    //       looping: true,
    //     );
    //     setState(() {},);
    //   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: SafeArea(
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
                  widget.fromDashboard!
                      ? Expanded(
                          child: BetterPlayer.network(
                            widget.url!.replaceAll('http://', 'https://'),
                            betterPlayerConfiguration:
                                const BetterPlayerConfiguration(
                              aspectRatio: 16 / 9,
                            ),
                          ),
                        )
                      : Expanded(
                          child: (widget.file!.file is File)
                              ? BetterPlayer.file(
                                  widget.file!.file!.path,
                                  betterPlayerConfiguration:
                                      const BetterPlayerConfiguration(
                                    aspectRatio: 16 / 9,
                                  ),
                                )
                              : BetterPlayer.network(
                                  widget.file!.url!
                                      .replaceAll('http://', 'https://'),
                                  betterPlayerConfiguration:
                                      const BetterPlayerConfiguration(
                                    aspectRatio: 16 / 9,
                                  ),
                                ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // controller.dispose();
    // chewieController.dispose();
    // chewieController.pause();
    super.dispose();
  }
}

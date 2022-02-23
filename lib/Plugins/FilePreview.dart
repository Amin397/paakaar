import 'dart:io' as io;

import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class FilePreview extends StatelessWidget {
  final CustomFileModel file;
  final double iconSize;
  late String ext;

  FilePreview({
    Key? key,
    required this.file,
    this.iconSize = 25.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (file.file is io.File) {
      this.ext = p.extension(
        file.file!.path,
      );
    } else {
      this.ext = "." + file.url!.split('.').last;
    }

    switch (this.ext) {
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.gif':
        return this.buildImage();
        break;
      case '.mp4':
      case '.mov':
      case '.mkv':
      case '.flv':
      case '.mpeg':
        return this.buildVideo();
        break;
      case '.3gp':
      case '.aa':
      case '.aac':
      case '.mp3':
      case '.waw':
      case '':
        return this.buildAudio();
        break;
      case '.pdf':
      case '.doc':
      case '.docm':
      case '.docx':
      case '.html':
      case '.htm':
      case '.rtf':
      case '.txt':
      case '.xml':
      case '.xps':
      case '.csv':
      case '.xltx':
      case '.xlsx':
      case '.xls':
      default:
        return this.buildDocument();
        break;
    }
    return Container();
  }

  Widget buildImage() {
    return Container(
      child: this.file.file is io.File
          ? Image.file(
              file.file!,
              fit: BoxFit.cover,
            )
          : Image.network(
              file.url!,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget buildVideo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorUtils.mainRed.withOpacity(0.5),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Icon(
          Icons.videocam_outlined,
          color: ColorUtils.mainRed,
          size: this.iconSize,
        ),
      ),
    );
  }

  Widget buildAudio() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorUtils.mainRed.withOpacity(0.5),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Icon(
          Icons.mic_outlined,
          color: ColorUtils.mainRed,
          size: this.iconSize,
        ),
      ),
    );
  }

  Widget buildDocument() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorUtils.mainRed.withOpacity(0.5),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        children: [
          Center(
            child: Icon(
              Icons.insert_drive_file_outlined,
              color: ColorUtils.mainRed,
              size: this.iconSize,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: this.iconSize / 3.5,
              ),
              height: this.iconSize / 2,
              width: this.iconSize / 2,
              child: AutoSizeText(
                this.ext,
                textDirection: TextDirection.ltr,
                minFontSize: 1.0,
                style: TextStyle(
                  color: ColorUtils.mainRed,
                ),
                maxFontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

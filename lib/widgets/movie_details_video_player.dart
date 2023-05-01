import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oxoo/style/theme.dart';
import 'package:oxoo/utils/loadingIndicator.dart';
import 'package:wakelock/wakelock.dart';
import 'package:video_player/video_player.dart';

class MovieDetailsVideoPlayerWidget extends StatefulWidget {
  final String? videoUrl;
  final File? localFile;

  const MovieDetailsVideoPlayerWidget({Key? key, this.videoUrl, this.localFile})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MovieDetailsVideoPlayerWidgetState();
  }
}

class _MovieDetailsVideoPlayerWidgetState
    extends State<MovieDetailsVideoPlayerWidget> {
  late VideoPlayerController _controller;
  late ChewieController? _chewieController;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    if (widget.localFile != null) {
      _controller = VideoPlayerController.file(widget.localFile!);
    } else {
      _controller = VideoPlayerController.network(widget.videoUrl!);
    }
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      materialProgressColors: ChewieProgressColors(
          playedColor: CustomTheme.primaryColor,
          bufferedColor: Colors.grey,
          backgroundColor: Colors.white),
      cupertinoProgressColors: ChewieProgressColors(
          playedColor: CustomTheme.primaryColor,
          bufferedColor: Colors.grey,
          backgroundColor: Colors.white),
      aspectRatio: 16 / 9,
      fullScreenByDefault: false,
      allowFullScreen: true,
      autoPlay: true,
      looping: false,
      showOptions: false,
      zoomAndPan: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage = "Invalid Video URL",
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );

    super.initState();
  }

  Future setAllOrientations() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await Wakelock.disable();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _controller.dispose();
    setAllOrientations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onBackPressed();
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: _chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : Center(
                      child: spinkit,
                    ))),
    );
  }

  _onBackPressed() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _chewieController?.exitFullScreen();
    Navigator.pop(context, true);
  }
}

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String? videoUrl;

  const VideoPlayerWidget({Key? key, this.videoUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerWidgetState();
  }
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController1;
  late ChewieController _chewieController;
  static bool? isDark;
  var appModeBox = Hive.box('appModeBox');

  @override
   initState() {
    super.initState();
    isDark = appModeBox.get('isDark') ?? false;
    print(widget.videoUrl);
    _videoPlayerController1 = VideoPlayerController.network(widget.videoUrl!);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      isLive: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage="Invalid Live TV URL",
            style: TextStyle(color: Colors.white),
          ),
        );
      },
      //customControls: CustomeMaterialControls(),
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Chewie(
  //     controller: _chewieController,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var  topbarContainerHeight = size.height * 0.15;

    return  Container(
        child: Stack(
          children: <Widget>[
            Container(
              // Use the VideoPlayer widget to display the video.
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            Container(
                height: topbarContainerHeight,
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(Icons.arrow_back_ios, color: isDark!? Colors.white : Colors.black,),
                      onTap: () {
                        SystemChrome.setPreferredOrientations(
                            [DeviceOrientation.portraitUp]);
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                )),
          ],
        ),
    );
  }
}

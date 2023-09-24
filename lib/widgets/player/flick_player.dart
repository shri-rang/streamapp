import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:oxoo/models/videos.dart' as sub;
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wakelock/wakelock.dart';

import '../../constants.dart';
import '../../service/link_parser/link_parser.dart';
import '../../style/theme.dart';

class FlickPlayer extends StatefulWidget {
  final String url;
  final String type;
  final bool isFullScreen;
  final List<sub.Subtitle>? subtitles;
  FlickPlayer(
      {Key? key,
      required this.type,
      this.isFullScreen = true,
      required this.url,
      this.subtitles})
      : super(key: key);

  @override
  State<FlickPlayer> createState() => _FlickPlayerState();
}

class _FlickPlayerState extends State<FlickPlayer> {
  // late FlickManager? flickManager;
  late bool isDark;
   TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  // late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;
  int? bufferDelay;

     @override
  void initState() {
    super.initState();
    initializePlayer("https://vz-1bd8696b-cfc.b-cdn.net/c4f58b99-f8c8-40f9-a8be-b58e2ea0bc2c/playlist.m3u8");
  }


  Future<void> initializePlayer(String url) async{
    
        _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(url));
 
    await Future.wait([
      _videoPlayerController1.initialize(),
   
    ]);
    _createChewieController();
    setState(() {});

  }


   void _createChewieController() {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];

    // final subtitles = [
    //   Subtitle(
    //     index: 0,
    //     start: Duration.zero,
    //     end: const Duration(seconds: 10),
    //     text: const TextSpan(
    //       children: [
    //         TextSpan(
    //           text: 'Hello',
    //           style: TextStyle(color: Colors.red, fontSize: 22),
    //         ),
    //         TextSpan(
    //           text: ' from ',
    //           style: TextStyle(color: Colors.green, fontSize: 20),
    //         ),
    //         TextSpan(
    //           text: 'subtitles',
    //           style: TextStyle(color: Colors.blue, fontSize: 18),
    //         )
    //       ],
    //     ),
    //   ),
    //   Subtitle(
    //     index: 0,
    //     start: const Duration(seconds: 10),
    //     end: const Duration(seconds: 20),
    //     text: 'Whats up? :)',
    //     // text: const TextSpan(
    //     //   text: 'Whats up? :)',
    //     //   style: TextStyle(color: Colors.amber, fontSize: 22, fontStyle: FontStyle.italic),
    //     // ),
    //   ),
    // ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: true,
      showOptions: false,
      showControls: true,
      
      // fullScreenByDefault: true,

        
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

      // additionalOptions: (context) {
      //   return <OptionItem>[
      //     OptionItem(
      //       onTap: () {
              
      //       },
      //       iconData: Icons.live_tv_sharp,
            
      //       title: 'Toggle Video Src',
      //     ),
      //   ];
      // },

    );
  }


    int currPlayIndex = 0;

  // Future<void> toggleVideo() async {
  //   await _videoPlayerController1.pause();
  //   currPlayIndex += 1;
  //   if (currPlayIndex >= srcs.length) {
  //     currPlayIndex = 0;
  //   }
  //   await initializePlayer();
  // }


  // Future<ClosedCaptionFile> _loadCaptions() async {
  //   final url = Uri.parse(
  //       // widget.subtitles != null && widget.subtitles?.length != 0
  //       //     ? widget.subtitles![0].url
  //       //     : 
  //           ""
  //           );
  //   try {
  //     final data = await http.get(url);
  //     final srtContent = data.body.toString();
  //     printLog("-----vtt file read: $srtContent");
  //     flickManager?.flickControlManager!.toggleSubtitle();
  //     return WebVTTCaptionFile(srtContent);
  //   } catch (e) {
  //     printLog('---------Failed to get subtitles for $e');
  //     return SubRipCaptionFile('');
  //   }
  // }

  // Future setLandscape() async {
  //   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values);
  //   await SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ]);
  //   await Wakelock.enable();
  // }

  // Future setAllOrientations() async {
  //   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values);
  //   await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  //   await Wakelock.disable();
  // }

  @override
  void dispose() {
      _videoPlayerController1.dispose();
  
    _chewieController?.dispose();
    printLog("-------------flick player dispose()");
    // flickManager!.dispose();
    // setAllOrientations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return _mainUI(context);
    } else {
      return GestureDetector(
          onPanUpdate: (details) {
            // Swiping in right direction.
            if (details.delta.dx > 0) {}
            // Swiping in left direction.
            if (details.delta.dx < 0) {
              Navigator.pop(context, true);
            }
          },
          child: _mainUI(context));
      //child: _testUI(context));
    }
  }

  // Widget _testUI(BuildContext context) {
  //   return Scaffold(
  //     body: FlickVideoPlayer(flickManager: flickManager!),
  //   );
  // }

  Widget _mainUI(BuildContext context) {
    isDark = Hive.box('appModeBox').get('isDark') ?? false;
    return Scaffold(
      backgroundColor: isDark ? CustomTheme.primaryColorDark : Colors.white,
      body: 
      Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ?
                     Theme(
                       data: ThemeData.light().copyWith(
    platform: TargetPlatform.iOS,
  ),
                       child: Chewie(
                          controller: _chewieController!,
                     
                        ),
                     )
                    :  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      ),
              ),
            ),
          //   TextButton(
          //     onPressed: () {
          //       _chewieController?.enterFullScreen();
          //     },
          //     child: const Text('Fullscreen'),
          //   ),
          //   Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: TextButton(
          //           onPressed: () {
          //             setState(() {
          //                Duration currentPosition = _videoPlayerController1.value.position;
          // Duration targetPosition = currentPosition - const Duration(seconds: 10);
          // _chewieController!.seekTo(targetPosition);
          //             });
          //           },
          //           child: const Padding(
          //             padding: EdgeInsets.symmetric(vertical: 16.0),
          //             child: Text("Landscape Video"),
          //           ),
          //         ),
          //       ),
           
          //     ],
          //   ),
          //   Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: TextButton(
          //           onPressed: () {
          //             setState(() {
          //               _platform = TargetPlatform.android;
          //             });
          //           },
          //           child: const Padding(
          //             padding: EdgeInsets.symmetric(vertical: 16.0),
          //             child: Text("Android controls"),
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: TextButton(
          //           onPressed: () {
          //             setState(() {
          //               _platform = TargetPlatform.iOS;
          //             });
          //           },
          //           child: const Padding(
          //             padding: EdgeInsets.symmetric(vertical: 16.0),
          //             child: Text("iOS controls"),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          //   Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: TextButton(
          //           onPressed: () {
          //             setState(() {
          //               _platform = TargetPlatform.windows;
          //             });
          //           },
          //           child: const Padding(
          //             padding: EdgeInsets.symmetric(vertical: 16.0),
          //             child: Text("Desktop controls"),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
            // if (Platform.isAndroid)
            //   ListTile(
            //     title: const Text("Delay"),
            //     subtitle: DelaySlider(
            //       delay:
            //           _chewieController?.progressIndicatorDelay?.inMilliseconds,
            //       onSave: (delay) async {
            //         if (delay != null) {
            //           bufferDelay = delay == 0 ? null : delay;
            //           await initializePlayer(widget.url);
            //         }
            //       },
            //     ),
            //   )
          ],
        ),
              // )
                        // );
      // FutureBuilder<String>(
      //     future: LinkParser()
      //         .getPlayableLink(linkType: widget.type, url: widget.url),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         String? link = snapshot.data;
      //         _prepareFlickManager(link!);
      //         return WillPopScope(
      //           onWillPop: () async {
      //             Navigator.pop(context, false);
      //             return true;
      //           },
      //           child: Align(
      //             alignment: Alignment.topCenter,
      //             child: OrientationBuilder(
      //               builder: (context, orientation) {
      //                 final isPortrait = orientation == Orientation.portrait;
      //                 return Stack(
      //                   fit: isPortrait ? StackFit.loose : StackFit.expand,
      //                   children: [
      //                     VisibilityDetector(
      //                       key: ObjectKey(flickManager),
      //                       onVisibilityChanged: (visibility) {
      //                         if (visibility.visibleFraction == 0 && mounted) {
      //                           flickManager?.flickControlManager?.autoPause();
      //                         } else if (visibility.visibleFraction == 1) {
      //                           flickManager?.flickControlManager?.autoResume();
      //                         }
      //                       },
      //                       child: FlickVideoPlayer(
      //                         flickManager: flickManager!,
      //                         flickVideoWithControls:
      //                             const FlickVideoWithControls(
      //                           closedCaptionTextStyle: TextStyle(fontSize: 20),
      //                           controls: FlickPortraitControls(),
      //                         ),
      //                         flickVideoWithControlsFullscreen:
      //                             const FlickVideoWithControls(
      //                           controls: FlickLandscapeControls(),
      //                           closedCaptionTextStyle: TextStyle(fontSize: 20),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 );
      //               },
      //             ),
      //           ),
      //         );
      //       }
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }),
    );
  }
}




class DelaySlider extends StatefulWidget {
  const DelaySlider({Key? key, required this.delay, required this.onSave})
      : super(key: key);

  final int? delay;
  final void Function(int?) onSave;
  @override
  State<DelaySlider> createState() => _DelaySliderState();
}

class _DelaySliderState extends State<DelaySlider> {
  int? delay;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    delay = widget.delay;
  }

  @override
  Widget build(BuildContext context) {
    const int max = 1000;
    return ListTile(
      title: Text(
        "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
      ),
      subtitle: Slider(
        value: delay != null ? (delay! / max) : 0,
        onChanged: (value) async {
          delay = (value * max).toInt();
          setState(() {
            saved = false;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: saved
            ? null
            : () {
                widget.onSave(delay);
                setState(() {
                  saved = true;
                });
              },
      ),
    );
  }
}
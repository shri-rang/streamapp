import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:oxoo/models/videos.dart';
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
  final List<Subtitle>? subtitles;
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
  late FlickManager? flickManager;
  late bool isDark;

  _prepareFlickManager(String url) {
    flickManager = FlickManager(
      autoPlay: true,
      autoInitialize: true,
      videoPlayerController: VideoPlayerController.network(
        url,
        closedCaptionFile: _loadCaptions(),
      ),
    );
    if (widget.isFullScreen)
      flickManager?.flickControlManager!.enterFullscreen();
  }

  Future<ClosedCaptionFile> _loadCaptions() async {
    final url = Uri.parse(
        widget.subtitles != null && widget.subtitles?.length != 0
            ? widget.subtitles![0].url
            : "");
    try {
      final data = await http.get(url);
      final srtContent = data.body.toString();
      printLog("-----vtt file read: $srtContent");
      flickManager?.flickControlManager!.toggleSubtitle();
      return WebVTTCaptionFile(srtContent);
    } catch (e) {
      printLog('---------Failed to get subtitles for $e');
      return SubRipCaptionFile('');
    }
  }

  Future setLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    await Wakelock.enable();
  }

  Future setAllOrientations() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await Wakelock.disable();
  }

  @override
  void dispose() {
    printLog("-------------flick player dispose()");
    flickManager!.dispose();
    setAllOrientations();
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

  Widget _testUI(BuildContext context) {
    return Scaffold(
      body: FlickVideoPlayer(flickManager: flickManager!),
    );
  }

  Widget _mainUI(BuildContext context) {
    isDark = Hive.box('appModeBox').get('isDark') ?? false;
    return Scaffold(
      backgroundColor: isDark ? CustomTheme.primaryColorDark : Colors.white,
      body: FutureBuilder<String>(
          future: LinkParser()
              .getPlayableLink(linkType: widget.type, url: widget.url),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String? link = snapshot.data;
              _prepareFlickManager(link!);
              return WillPopScope(
                onWillPop: () async {
                  Navigator.pop(context, false);
                  return true;
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      final isPortrait = orientation == Orientation.portrait;
                      return Stack(
                        fit: isPortrait ? StackFit.loose : StackFit.expand,
                        children: [
                          VisibilityDetector(
                            key: ObjectKey(flickManager),
                            onVisibilityChanged: (visibility) {
                              if (visibility.visibleFraction == 0 && mounted) {
                                flickManager?.flickControlManager?.autoPause();
                              } else if (visibility.visibleFraction == 1) {
                                flickManager?.flickControlManager?.autoResume();
                              }
                            },
                            child: FlickVideoPlayer(
                              flickManager: flickManager!,
                              flickVideoWithControls:
                                  const FlickVideoWithControls(
                                closedCaptionTextStyle: TextStyle(fontSize: 20),
                                controls: FlickPortraitControls(),
                              ),
                              flickVideoWithControlsFullscreen:
                                  const FlickVideoWithControls(
                                controls: FlickLandscapeControls(),
                                closedCaptionTextStyle: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

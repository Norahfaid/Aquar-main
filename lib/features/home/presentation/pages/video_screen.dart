import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/icon_button_card.dart';
import '../../../../core/widgets/space.dart';
import '../../../../injection_container/injection_container.dart';

class AdsEquipmentsScreen extends StatefulWidget {
  final String videoUrl;
  const AdsEquipmentsScreen({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<AdsEquipmentsScreen> createState() => _AdsEquipmentsScreenState();
}

class _AdsEquipmentsScreenState extends State<AdsEquipmentsScreen> {
  Future<void>? playerLoader;
  VideoPlayerController? playerController;
  @override
  void dispose() {
    super.dispose();
    if (playerController != null) {
      playerController?.dispose();
    }
  }

  bool getBack = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      VideoLoader videoLoader = VideoLoader(widget.videoUrl);
      videoLoader.loadVideo(() async {
        playerController = VideoPlayerController.file(videoLoader.videoFile!,
            videoPlayerOptions:
                VideoPlayerOptions(allowBackgroundPlayback: false));
        await playerController!.initialize();
        setState(() {});
        playerController!.play();

        setState(() {});
        playerController!.addListener(() {
          if (playerController!.value.position.inSeconds ==
              playerController!.value.duration.inSeconds) {
            playerController!.seekTo(Duration.zero);
            playerController!.play();
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(50.r),
              child: IconButtonCard(
                icon: Icons.keyboard_arrow_right,
                onTap: () {
                  sl<AppNavigator>().pop();
                },
              )),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Space(height: 30),
            playerController == null || !playerController!.value.isInitialized
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: playerController!.value.aspectRatio,
                        child: VideoPlayer(playerController!),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

enum LoadState { loading, success, failure }

class VideoLoader {
  String url;

  File? videoFile;

  Map<String, dynamic>? requestHeaders;

  LoadState state = LoadState.loading;

  VideoLoader(this.url, {this.requestHeaders});

  void loadVideo(VoidCallback onComplete) {
    if (videoFile != null) {
      state = LoadState.success;
      onComplete();
    }

    final fileStream = DefaultCacheManager()
        .getFileStream(url, headers: requestHeaders as Map<String, String>?);

    fileStream.listen((fileResponse) {
      if (fileResponse is FileInfo) {
        if (videoFile == null) {
          state = LoadState.success;
          videoFile = fileResponse.file;
          onComplete();
        }
      }
    });
  }
}

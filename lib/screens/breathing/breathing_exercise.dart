import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class BreathingExercise extends StatefulWidget {
  static const routeName = '/breathe';

  @override
  State<StatefulWidget> createState() {
    return BreathingState();
  }
}

class BreathingState extends State<BreathingExercise> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState(){
    _controller = VideoPlayerController.asset('lib/assets/videos/BreathingGuide_v2.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    _controller.play();
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate(){
    _controller.pause();
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              return Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              );
            } else {
              return Center(
                child:CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

}
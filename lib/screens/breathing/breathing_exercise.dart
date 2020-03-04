import 'package:maintein/assets/icons/home_icon_icons.dart';
import 'package:maintein/screens/home.dart';
import 'package:maintein/screens/breathing/hotlines.dart';
import 'package:maintein/themes/apptheme.dart';
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
  bool _isMute = false;

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      bottomNavigationBar: BottomAppBar(
        elevation: 10.0,
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Tooltip(
              message: "Home",
              child: IconButton(
                  icon: Icon(HomeIcon.home, size: 30.0, color: MyBlue.light,),
                  onPressed: () async {
                    Navigator.pushNamed(context, MyHome.routeName);
                  }
              ),
            ),
            Tooltip(
              message: "Hotline Information",
              child: IconButton(
                icon: Icon(Icons.info_outline, size: 30.0, color: MyBlue.light),
                onPressed: () => Navigator.pushNamed(context, HotlinesList.routeName),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ( _isMute ) ? Colors.grey : MyBlue.picton,
        foregroundColor: Colors.white,
        onPressed: () async {
          if ( _isMute ) {
            await _controller.setVolume(1.0);
            setState(() {
              _isMute = false;
            });
          } else {
            await _controller.setVolume(0.0);
            setState(() {
              _isMute = true;
            });
          }
        },
        tooltip: (_isMute) ? "Mute" : "Unmute",
        child: Icon(Icons.volume_mute),
      ),
    );
  }

}
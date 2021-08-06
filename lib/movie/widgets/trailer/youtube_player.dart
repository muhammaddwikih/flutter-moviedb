import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideo extends StatefulWidget{
  @override
 _YoutubeVideoState createState() => _YoutubeVideoState();

}

class _YoutubeVideoState extends State<YoutubeVideo>{
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'Fp9pNPdNwjI',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
    ),
  );


  @override
  Widget build(BuildContext context) {
    return
      YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      )
    ,
    );
  }

}
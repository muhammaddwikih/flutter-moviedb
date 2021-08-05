import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/movie/widgets/trailer/player_controller.dart';
import 'package:moviedb/movie/widgets/trailer/trailer_movies_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class TrailerMovies extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF191926),
      body: Column(
        children: [
      Expanded(
          flex: 0,
          child : Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 10, left: 20, bottom: 10),
            child: Text(
              "Trailer",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          )),
    Expanded(
        flex: 1,
        child :
    Container(
      child: VideoPlayerApp(),
    )),
        ],
      ),
    );
  }

}
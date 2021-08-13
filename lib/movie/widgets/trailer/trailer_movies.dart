import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/movie/widgets/trailer/player_controller.dart';
import 'package:moviedb/movie/widgets/trailer/trailer_movies_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/movie/widgets/trailer/youtube_player.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read(trailerMoviesViewModelProvider.notifier).getVideosById(id);
    });

    return Column(children: [
      Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(top: 10, left: 20, bottom: 10),
        child: Text(
          "Trailer",
          style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      Consumer(builder: (context, watch, child) {
        final state = watch(trailerMoviesViewModelProvider);
        print("TRAILER LOG ybji16u608U");
        print(state);
        if (state is Loading) {
          return Container(
              height: 400,
              width: double.infinity,
              alignment: Alignment.center,
              child: CircularProgressIndicator());
        } else {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: state.data[0].key,
                flags: YoutubePlayerFlags(
                  // hideControls: true,
                  hideThumbnail: true,
                  controlsVisibleAtStart: true,
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () => {print('Youtube Ready')},
            ),
          );
        }
      })
    ]);
  }
}

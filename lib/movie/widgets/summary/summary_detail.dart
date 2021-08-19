import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/providers/analytics_provider.dart';
import 'package:moviedb/movie/widgets/credit/credit_movies.dart';
import 'package:moviedb/movie/widgets/detail/detail_movies.dart';
import 'package:moviedb/movie/widgets/detail/detail_movies_view_model.dart';
import 'package:moviedb/movie/widgets/summary/summary_favorite_view_model.dart';
import 'package:moviedb/movie/widgets/trailer/trailer_movies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SummaryDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read(detailMoviesViewModelProvider.notifier).getMovieById(id);
    });
    
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read(analyticsProvider).logEvent(name: "home_screen");
    });

    Widget appBar = SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace:
          Consumer(builder: (context, watch, child) {
        final state = watch(detailMoviesViewModelProvider);
        if ( (state is Loading) || (state is Initial)) {
          return Container(
              height: 230,
              width: double.infinity,
              alignment: Alignment.center,
              child: CircularProgressIndicator());
        } else {

          return Column(children: [
            Container(
              width: double.infinity,
              height: 230,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(state.data[0].backdrop),
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.6),
                                BlendMode.dstOut))),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 50),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50, right: 21),
                    alignment: Alignment.topRight,
                    child:
                    Icon(
                      Icons.favorite_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      top: 70,
                    ),
                    child: Text(state.data[0].title,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'OpenSans')),
                  ),
                  Container(
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                              // margin: EdgeInsets.only(left: 23),
                              child: Row(
                            children: [
                              Icon(
                                Icons.brightness_1_rounded,
                                size: 12,
                                color: const Color(0xFF777777),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                state.data[index].genre[index].name,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF777777),
                                    fontFamily: 'OpenSans'),
                              ),
                            ],
                          ));
                        }),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20, top: 50),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            state.data[0].rating.toString() + " / 10",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF777777),
                                fontFamily: 'OpenSans'),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 20, top: 205),
                      child: Row(
                        children: [
                          Icon(Icons.thumb_up_alt_outlined,
                              size: 18, color: const Color(0xFF777777)),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            state.data[0].popularity.toString() + " Users ",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF777777),
                                fontFamily: 'OpenSans'),
                          ),
                        ],
                      )),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 80, left: 250, right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          state.data[0].poster,
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      )),
                  Container(
                      height: 30,
                      margin: EdgeInsets.only(top: 235, left: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(160, 30),
                              primary: const Color(0xFFE82626)),
                          onPressed: () => {
                                // Navigator.pushNamed(context, '/carView'),
                              },
                          child: Text(
                            "Watch Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans'),
                          ))),
                ],
              ),
            )
          ]);
        }
      }),
    );

    Widget body = SliverToBoxAdapter(
        child: Column(
      children: <Widget>[MovieDetails(), TrailerMovies(), MovieCredits()],
    ));

    Widget scrollView = CustomScrollView(
      slivers: <Widget>[appBar, body],
    );

    // return Scaffold(
    //   body: scrollView,
    // );

    return Scaffold(
      backgroundColor: const Color(0xFF191926),
      appBar: AppBar(
        toolbarHeight: 250,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        flexibleSpace: Consumer(builder: (context, watch, child) {
          final state = watch(detailMoviesViewModelProvider);
          List<Widget> genreBoxBuilder() {
            List<Widget> genreBox = [];
            var jml = 0;
            for (Genre genre in state.data[0].genre) {
              if(jml >= 2){
                break;
              }
              genreBox.add(
                  Row(
                children: [
                  Icon(
                    Icons.brightness_1_rounded,
                    size: 12,
                    color: const Color(0xFF777777),
                  ),
                  Text(
                    genre.name,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF777777),
                        fontFamily: 'OpenSans'),
                  ),
                ],
              ));
              jml += 1;
            }
            return genreBox;
          }
          if ((state is Loading) || (state is Initial)) {
            return Container(
                height: 250,
                width: double.infinity,
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          } else {
            context.read(summaryFavoriteViewModelProvider.notifier).checkFav(state.data[0]);
            return Column(children: [
              Container(
                width: double.infinity,
                height: 250,
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    state.data[0].backdrop,
                                  ),
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.6),
                                      BlendMode.color))),
                        ),
                        Positioned.fill(child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.6, 0.95]
                            )
                          ),
                        ))
                      ],
                    ),

                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 30),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, right: 21),
                      alignment: Alignment.topRight,
                      child:
                      Consumer(builder: (context, watch, child) {
                        final _isPressed =
                        watch(summaryFavoriteViewModelProvider);
                        print(_isPressed);
                        return GestureDetector(
                          onTap: () => context
                              .read(
                              summaryFavoriteViewModelProvider.notifier)
                              .favorite(state.data[0]),
                          child: Icon(
                            _isPressed
                                ? Icons.favorite_sharp
                                : Icons.favorite_border_outlined,
                            color: (_isPressed)
                                ? Colors.red
                                : Colors.white,
                            size: 33,
                          ),
                        );
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        top: 90,
                      ),
                      child: Text(state.data[0].title,
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'OpenSans')),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 120,left: 20),
                      child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 1.0, // gap between adjacent chips
                          runSpacing: 1.0, // gap between lines
                          children: genreBoxBuilder()),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15, top: 155),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              state.data[0].rating.toString() + " / 10",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF777777),
                                  fontFamily: 'OpenSans'),
                            ),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 20, top: 175),
                        child: Row(
                          children: [
                            Icon(Icons.thumb_up_alt_outlined,
                                size: 18, color: const Color(0xFF777777)),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              state.data[0].popularity.toString() + " Users ",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF777777),
                                  fontFamily: 'OpenSans'),
                            ),
                          ],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 80, left: 250, right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            state.data[0].poster,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        )),
                    Container(
                        height: 30,
                        margin: EdgeInsets.only(top: 205, left: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(160, 30),
                                primary: const Color(0xFFE82626)),
                            onPressed: () => {
                                  // Navigator.pushNamed(context, '/carView'),
                                },
                            child: Text(
                              "Watch Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'OpenSans'),
                            ))),
                  ],
                ),
              )
            ]);
          }
        }),
        leading: InkWell(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.transparent,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child:
            Column(
          children: [
            MovieDetails(),
            TrailerMovies(),
            MovieCredits(),
          ],
        ),
      ),
      // ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/movie/widgets/credit/credit_movies.dart';
import 'package:moviedb/movie/widgets/detail/detail_movies.dart';
import 'package:moviedb/movie/widgets/detail/detail_movies_view_model.dart';
import 'package:moviedb/movie/widgets/trailer/trailer_movies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read(detailMoviesViewModelProvider.notifier).getMovieById(id);
    });

    return Scaffold(
      backgroundColor: const Color(0xFF191926),
      appBar: AppBar(
        toolbarHeight: 350,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        flexibleSpace: Consumer(builder: (context, watch, child) {
          final state = watch(detailMoviesViewModelProvider);
          if (state is Loading) {
            return Container(
                height: 350,
                width: double.infinity,
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          } else {
            return Column(children: [
              Container(
                width: double.infinity,
                height: 350,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: NetworkImage(
                      //             "https://www.themoviedb.org/t/p/w780/dq18nCTTLpy9PmtzZI6Y2yAgdw5.jpg"),
                      //         colorFilter: new ColorFilter.mode(
                      //             Colors.black.withOpacity(0.6),
                      //             BlendMode.dstOut)
                      //     )
                      // ),
                      child: Image.network(
                        state.data[0].backdrop,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                      // )
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 50),
                        child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50, right: 21),
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        top: 140,
                      ),
                      child: Text(state.data[0].title,
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ),
                    Container(
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.only(left: 23),
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
                                          color: const Color(0xFF777777)),
                                    ),
                                  ],
                                ));
                          }),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20, top: 185),
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
                                  color: const Color(0xFF777777)),
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
                                  color: const Color(0xFF777777)),
                            ),
                          ],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 50, left: 250, right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            state.data[0].poster,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.3,
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
                                  fontWeight: FontWeight.w600),
                            ))),
                  ],
                ),
              )
            ]);
          }
        }),
        leading:
        InkWell(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(Icons.arrow_back_ios, color: Colors.transparent,),
          ),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child:
            // Container(
            //   height: 300,
            //     width: double.infinity,
            //     child:
            Column(
          children: [
            MovieDetail(),
            // SizedBox(height: 20),
            TrailerMovies(),
            // // SizedBox(height: 20,),
            MovieCredit(),
            // SizedBox(height: 10,)
          ],
        ),
      ),
      // ),
    );
  }
}

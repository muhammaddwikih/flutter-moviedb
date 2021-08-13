import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/movie/widgets/credit/credit_movies_view_model.dart';

class MovieCredit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read(creditMoviesViewModelProvider.notifier).getMovieById(id);
    });

    return Column(
          children: [
            Consumer(builder: (context, watch, child) {
              final state = watch(creditMoviesViewModelProvider);
              if (state is Loading) {
                return Container(
                    height: 400,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              } else {
                return Container(
                  child: Column(
                    children: [
                  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Container(
                          //   child:
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Cast',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'See All',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300),
                              )),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 130,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    children: [
                                      Image.network(state.data[index].foto,
                                          height: 80, width: 80),
                                      SizedBox(height: 3,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                        state.data[index].nama,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800),
                                        maxLines: 2,
                                      )
                                )
                                    ],
                                  ),
                                );
                            }),
                      )

                    ],
                  ),
                );
              }
            })

          ],
        );
  }
}

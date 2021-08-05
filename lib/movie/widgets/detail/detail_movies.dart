import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/movie/widgets/detail/detail_movies_view_model.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read(detailMoviesViewModelProvider.notifier).getMovieById(id);
    });

    return Scaffold(
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     Container(
      //       margin: EdgeInsets.only(top: 10,right: 21),
      //       alignment: Alignment.topRight,
      //       child: Icon(
      //         Icons.favorite_border_outlined,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ],
      //   leading: InkWell(
      //     child: Container(
      //       margin: EdgeInsets.only(left: 10, top: 10),
      //       child:Icon(Icons.arrow_back_ios),
      //     ),
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
        body: Consumer(builder: (context, watch, child) {
          final state = watch(detailMoviesViewModelProvider);
          if (state is Loading) {
            return Container(
                height: 400,
                width: double.infinity,
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          } else {
            return
                Column(
              children: [
                Expanded(
                  flex: 10,
                    child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.network(
                          state.data[0].backdrop,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 69.71, right: 21),
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: 69.71, left: 21),
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                        onTap: () {
                          Navigator.pushNamed(context, "/");
                        },
                      ) ,
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 200, ),
                        child:
                        Text(state.data[0].title,
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ),
                        Container(
                          width: double.infinity,
                          height: 250,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return
                                  Container(
                                    margin: EdgeInsets.only(top: 220, left: 23),
                                    child: Row(
                                      children: [
                                        Icon(Icons.brightness_1_rounded, size: 12, color: const Color(0xFF777777),),
                                        SizedBox(width: 3,),
                                        Text(state.data[index].genre[index].name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFF777777)),),
                                      ],
                                    )
                                  );
                              }),
                        ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 245),
                        child: Row( children: [
                          Icon(Icons.star, color: Colors.yellow, size: 18,),
                          SizedBox(width: 3,),
                          Text(state.data[0].rating.toString() + " / 10", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFF777777)),),
                        ],)
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 265),
                        child: Row(
                          children: [
                            Icon(Icons.thumb_up_alt_outlined, size: 18, color: const Color(0xFF777777)),
                            SizedBox(width: 3,),
                            Text(state.data[0].popularity.toString() + " Users ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFF777777)),),
                          ],
                        )
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin:
                              EdgeInsets.only(top: 183, left: 270, right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              state.data[0].poster,
                            ),
                          )),
                      Container(
                          height: 30,
                          margin: EdgeInsets.only(top: 295, left: 20),
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
                )),
                Expanded(
                    flex: 0,
                    child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  child: Text(
                    "sinopsis",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                )),
                Expanded(
                    flex: 2,
                    child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 20),
                  child: AutoSizeText(
                    state.data[0].sinopsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                )),
              ],
            );
          }
        }));
  }
}

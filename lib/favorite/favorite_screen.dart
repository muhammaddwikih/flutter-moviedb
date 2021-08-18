import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/favorite/favorite_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read(favoriteViewModelProvider.notifier).getMovieList();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF191926),
        shadowColor: Colors.transparent,
        title: Text(
          "Favourite Movies",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Consumer(builder: (context, watch, child) {
              final state = watch(favoriteViewModelProvider);
              print(state.data.length);
              if (state is Loading) {
                return Container(
                    height: 230,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              } else {
                return
                    //   Container(
                    //   child: Text(state.data[0].title, style: TextStyle(color: Colors.red),),
                    // );
                    Container(
                        width: double.infinity,
                        height: 500,
                        margin: EdgeInsets.only(top: 20),
                        child: ListView.builder(
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFF222232),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 12),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 250,
                                        margin: EdgeInsets.only(
                                            left: 12, bottom: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                state.data[index].poster,
                                              ),
                                              colorFilter: new ColorFilter.mode(
                                                  Colors.white.withOpacity(0.1),
                                                  BlendMode.color)),
                                        ),
                                      ),
                                      Positioned.fill(
                                          bottom: 18,
                                          left: 28,
                                          right: 15,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(8)),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black
                                                          .withOpacity(0.8)
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    stops: [0.6, 0.95])),
                                          ))
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF191926),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    margin: EdgeInsets.only(top: 10, left: 40),
                                    alignment: Alignment.center,
                                    child: Text("16+", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Poppins'),),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 160, top: 10),
                                    child: Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40, top: 210),
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "testing",
                                      style: TextStyle(color: Colors.red, fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 210, top: 10),
                                    child: Text(
                                      state.data[index].title,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                          color: const Color(0xFFECECEC)),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 167, top: 30),
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      "97 MIN",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 10,
                                          color: const Color(0xFF565665)),
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    height: 100,
                                    margin: EdgeInsets.only(left: 210, top: 60),
                                    child: SingleChildScrollView(
                                      child: Text(
                                        state.data[index].sinopsis,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 190,
                                    height: 30,
                                    margin: EdgeInsets.only(left: 210, right:30 ,top: 210),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0.0, 1],
                                        colors: [
                                          const Color(0xFF8036E7),
                                          const Color(0xFFFF3365),
                                        ],
                                      ),
                                      // color: Colors.deepPurple.shade300,
                                    ),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: Size(160, 30),
                                            primary: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            shape: StadiumBorder())
                                        ,
                                        onPressed: () => {
                                              // Navigator.pushNamed(context, '/carView'),
                                            },
                                        child: Text(
                                          "BOOK YOUR TICKET",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Poppins'),
                                        )),
                                  )
                                ],
                              );
                              //   Container(
                              //   // height: 100,
                              //   width: double.infinity,
                              //   child: Text(state.data[index].title, style: TextStyle(color: Colors.red),),
                              // );
                            }));
              }
            })
          ],
        ),
      ),
    );
  }
}

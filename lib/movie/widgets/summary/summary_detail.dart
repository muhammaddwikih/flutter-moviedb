import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/movie/widgets/credit/credit_movies.dart';
import 'package:moviedb/movie/widgets/detail/detail_movies.dart';
import 'package:moviedb/movie/widgets/trailer/trailer_movies.dart';

class SummaryDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF191926),
        body:
        // SingleChildScrollView(
        // child:
        // Column(
        //   children: [

        Container(
            child: Column(
              children: [
                Expanded(flex: 5,child: MovieDetail()),
                // SizedBox(height: 20),
                Expanded(flex: 2, child: TrailerMovies()),
                // SizedBox(height: 20,),
                Expanded(flex: 2,child: MovieCredit()),
                // SizedBox(height: 10,)
              ],
            ),
          ),
    );
    // );
  }
}
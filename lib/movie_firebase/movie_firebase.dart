import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/core/providers/analytics_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieFirebase extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read(analyticsProvider).logEvent(name: "detail_screen");
    });

    return Scaffold(
      body: Center(
        child: Text("ini Halaman Detail", style: TextStyle(color: Colors.white),),
      ),
    );
  }
  
}
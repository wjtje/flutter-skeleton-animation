import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Skeleton animation'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => ListTile(
                    title: SkeletonAnimation(
                      width: 200,
                      height: 14,
                      radius: Radius.circular(6),
                    ),
                    subtitle: SkeletonAnimation(
                      width: 200,
                      height: 10,
                      radius: Radius.circular(6),
                    ),
                  ),
                  childCount: 20
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
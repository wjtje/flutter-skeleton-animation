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
                            title: Skeleton(
                              style: SkeletonStyle.text,
                              height: 14.0,
                            ),
                            subtitle: Skeleton(
                              style: SkeletonStyle.text,
                              height: 10.0,
                            ),
                            onTap: () {},
                          ),
                      childCount: 20),
                )
              ],
            )),
      ),
      // enable dark mode
      darkTheme: ThemeData(brightness: Brightness.dark),
    );
  }
}

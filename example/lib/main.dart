import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

List tileList = [
  [null, null],
  [null, Colors.blue],
  [null, Colors.blue.shade900],
  [Colors.green, Colors.blue.shade900],
  [null, Colors.green],
  [null, Colors.green.shade900],
  [null, Colors.red],
  [null, Colors.red.shade200]
];

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
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, i) => ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            tileColor: tileList[i][1],
                            title: Skeleton(
                              style: SkeletonStyle.text,
                              textColor: tileList[i][0],
                              parentBackgroundColor: tileList[i][1],
                              height: 14.0,
                            ),
                            subtitle: Text(
                              'Loaded Text',
                              style: TextStyle(color: tileList[i][0]),
                            ),
                            onTap: () {},
                          ),
                      childCount: tileList.length),
                )
              ],
            )),
      ),
      // enable dark mode
      darkTheme: ThemeData(brightness: Brightness.dark),
    );
  }
}

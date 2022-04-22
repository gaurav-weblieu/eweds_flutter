import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'How to overlap SliverList on a SliverAppBar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              child: Container(),
              preferredSize: Size(0, 20),
            ),
            pinned: false,
            snap: true,
            floating: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://images.pexels.com/photos/62389/pexels-photo-62389.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index + 1 % 9)],
                  child: Text('List Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

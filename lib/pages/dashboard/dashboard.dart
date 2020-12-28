import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/home_header.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final generatedList = List.generate(500, (index) => 'Item $index');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          HomeHeader(),
          SliverFixedExtentList(
            itemExtent: 50, // I'm forcing item heights
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text(
                  generatedList[index],
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              childCount: generatedList.length,
            ),
          ),
        ],
      ),
    );
  }
}

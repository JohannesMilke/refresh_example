import 'package:flutter/material.dart';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:refresh_example/main.dart';
import 'package:refresh_example/widget/refresh_widget.dart';

class GridViewRefreshPage extends StatefulWidget {
  @override
  _GridViewRefreshPageState createState() => _GridViewRefreshPageState();
}

class _GridViewRefreshPageState extends State<GridViewRefreshPage> {
  List<int> data = [];

  @override
  void initState() {
    super.initState();

    loadList();
  }

  Future loadList() async {
    await Future.delayed(Duration(milliseconds: 400));

    final random = Random();
    final data = List.generate(100, (_) => random.nextInt(100));

    setState(() => this.data = data);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: loadList,
            ),
          ],
        ),
        body: buildList(),
      );

  Widget buildList() => data.isEmpty
      ? Center(child: CircularProgressIndicator())
      : RefreshWidget(
          onRefresh: loadList,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            primary: false,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final number = data[index];

              return buildItem(number);
            },
          ),
        );

  Widget buildItem(int number) => GridTile(
        child: Center(
          child: Text('$number', style: TextStyle(fontSize: 32)),
        ),
      );
}

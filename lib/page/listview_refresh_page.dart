import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refresh_example/main.dart';
import 'package:refresh_example/widget/refresh_widget.dart';

class ListViewRefreshPage extends StatefulWidget {
  @override
  _ListViewRefreshPageState createState() => _ListViewRefreshPageState();
}

class _ListViewRefreshPageState extends State<ListViewRefreshPage> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  List<int> data = [];

  @override
  void initState() {
    super.initState();

    loadList();
  }

  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 4000));

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
          keyRefresh: keyRefresh,
          onRefresh: loadList,
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final number = data[index];

              return buildItem(number);
            },
          ),
        );

  Widget buildItem(int number) => ListTile(
        title: Center(
          child: Text('$number', style: TextStyle(fontSize: 32)),
        ),
      );
}

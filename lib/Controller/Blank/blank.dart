import 'package:flutter/material.dart';

class Blank extends StatefulWidget {
  final Map<String, dynamic>? data;

  const Blank({Key? key, this.data}) : super(key: key);

  @override
  _BlankState createState() => _BlankState();
}

class _BlankState extends State<Blank> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(title: const Text('Test Screen')),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return buildPortraitLayout();
          },
        ),
      ),
      onWillPop: () async => true,
    );
  }

  Widget buildPortraitLayout() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: widget.data!.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext ctxt, int index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(widget.data!.keys.elementAt(index)),
                ),
                Expanded(
                  flex: 2,
                  child: Text(widget.data!.values.elementAt(index)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

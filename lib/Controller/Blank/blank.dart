import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/Widgets/transaction_summary_view.dart';

@RoutePage(name: 'BlankRoute')
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
        appBar: AppBar(title: const Text('Transaction Result')),
        body: SafeArea(
          child: TransactionSummaryView(data: widget.data ?? const {}),
        ),
      ),
      onWillPop: () async => true,
    );
  }
}

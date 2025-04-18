import 'package:flutter/material.dart';
import 'package:sample_app/Services/Helper/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class CartDetail extends StatefulWidget {
  final Map<String, dynamic>? data;

  const CartDetail({Key? key, this.data}) : super(key: key);

  @override
  _CartDetailState createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  String _orderId = '';

  @override
  void initState() {
    _orderId = widget.data!['orderid'] ?? '';
    debugPrint('orderId: $_orderId');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          title: const Text('Cart Detail'),
          actions: <Widget>[
            _orderId.isNotEmpty
                ? IconButton(
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final Uri launchUri = Uri(
                        scheme: 'razervt',
                        host: "merchant.razer.com",
                        query: Helper.instance
                            .encodeQueryParameters(<String, String>{
                          'merchantUrlScheme': 'merchantapp',
                          'merchantHost': 'merchant.example.com',
                          'opType': 'VOID',
                          'orderId': _orderId,
                        }),
                      );
                      try {
                        await launch(launchUri.toString());
                      } catch (e) {
                        debugPrint('Error: $e');
                      }
                    },
                  )
                : Container(),
          ],
        ),
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

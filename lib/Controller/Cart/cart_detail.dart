import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/Services/Helper/helper.dart';
import 'package:sample_app/Widgets/transaction_summary_view.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage(name: 'CartDetailRoute')
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

  Future<void> _onVoid() async {
    final Uri launchUri = Uri(
      scheme: 'razervt',
      host: "merchant.razer.com",
      query: Helper.instance.encodeQueryParameters(<String, String>{
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transaction Result'),
          actions: <Widget>[
            if (_orderId.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.cancel_outlined),
                tooltip: 'Void transaction',
                onPressed: _onVoid,
              ),
          ],
        ),
        body: SafeArea(
          child: TransactionSummaryView(
            data: widget.data ?? const {},
            footer: _orderId.isNotEmpty
                ? OutlinedButton.icon(
                    onPressed: _onVoid,
                    icon: const Icon(Icons.undo_rounded),
                    label: const Text('Void Transaction'),
                  )
                : null,
          ),
        ),
      ),
      onWillPop: () async => true,
    );
  }
}

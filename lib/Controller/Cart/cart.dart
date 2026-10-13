import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_app/Services/Helper/helper.dart';
import 'package:url_launcher/url_launcher.dart';

const double _minAmount = 1.01;

@RoutePage(name: 'CartRoute')
class Cart extends StatefulWidget {
  final String country;

  /// Custom order ID for the sale. A generated one is used when empty.
  final String orderId;

  const Cart({Key? key, required this.country, this.orderId = ''})
      : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String currency = "";

  List<Map<String, dynamic>> channelsMY = [
    {
      "icon": "assets/images/channel/logo-card.png",
      "channel": 'CARD',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-duitnow.png",
      "channel": 'RPP_DuitNowQR-Offline',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-touchngo.png",
      "channel": 'TNG-EWALLET-Offline',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-shopeepay.png",
      "channel": 'ShopeePay-Offline',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-grabpay.png",
      "channel": 'GrabPay-Offline',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-boost.png",
      "channel": 'BOOST-OFFLINE',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-unionpay.png",
      "channel": 'UnionPay-Offline',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-alipay+.png",
      "channel": 'AlipayPlus-Offline',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-wechatpay.png",
      "channel": 'WeChatPayMY-Offline',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-mae.png",
      "channel": 'Maybank-QRPay',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-alipay.png",
      "channel": 'Alipay-Spot',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-atome.png",
      "channel": 'Atome-Offline',
      "opType": 'SALE',
    },
  ];

  List<Map<String, dynamic>> channelsSG = [
    {
      "icon": "assets/images/channel/logo-card.png",
      "channel": 'CARD',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-paynow.png",
      "channel": 'PayNow',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-shopeepay.png",
      "channel": 'ShopeePay-Offline',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-alipay+.png",
      "channel": 'AlipayPlus-Offline',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-grabpay.png",
      "channel": 'GrabPay-Offline',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-atome.png",
      "channel": 'Atome-Offline',
      "opType": 'SALE',
    },
  ];

  List<Map<String, dynamic>> channelsPH = [
    {
      "icon": "assets/images/channel/logo-card.png",
      "channel": 'CARD',
      "opType": 'SALE',
    },
    {
      "icon": "assets/images/channel/logo-maya.png",
      "channel": 'PayMaya-eWallet',
      "opType": 'SALE',
    },
  ];

  String _payType = '2';
  final TextEditingController _amountController =
      TextEditingController(text: '1.01');

  /// Amount must be expressed with exactly 2 decimal places and be at
  /// least [_minAmount].
  String? get _amountErrorText {
    final text = _amountController.text.trim();
    if (text.isEmpty) return 'Amount is required';
    if (!RegExp(r'^\d+\.\d{2}$').hasMatch(text)) {
      return 'Amount must have exactly 2 decimal places';
    }
    if (double.parse(text) < _minAmount) {
      return 'Minimum amount is ${_minAmount.toStringAsFixed(2)}';
    }
    return null;
  }

  bool get _isAmountValid => _amountErrorText == null;

  Future<void> onProceed(Map<String, dynamic> data) async {
    if (!_isAmountValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_amountErrorText!),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    final Uri launchUri = Uri(
      scheme: 'razervt',
      host: "merchant.razer.com",
      query: Helper.instance.encodeQueryParameters(<String, String>{
        'merchantUrlScheme': 'merchantapp',
        'merchantHost': 'merchant.example.com',
        'opType': data['opType'].toString(),
        'currency': currency,
        'amount': _amountController.text,
        'orderId': widget.orderId.isNotEmpty
            ? widget.orderId
            : 'DT${DateTime.now().millisecondsSinceEpoch.toString()}',
        'channel': data['channel'].toString(),
        'payType': _payType
      }),
    );
    try {
      await launch(launchUri.toString());
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint('logCountry initState Country: ${widget.country}'); // Debugging
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> channelsCountry = [];
    debugPrint("logCountry build country = " + widget.country);

    if (widget.country == "PH") {
      channelsCountry = channelsPH;
      currency = "PHP";
    } else if (widget.country == "SG") {
      channelsCountry = channelsSG;
      currency = "SGD";
    } else {
      channelsCountry = channelsMY;
      currency = "MYR";
    }

    debugPrint("logCountry currency = " + currency);
    debugPrint("logCountry channelsCountry.length = " +
        channelsCountry.length.toString());

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Page'),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final theme = Theme.of(context);
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Amount Input
                    Text(
                      'Enter Amount',
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Set the amount to charge for this transaction.',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 16.0),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              if (newValue.text.isEmpty) return newValue;
                              final isValid = RegExp(r'^\d*\.?\d{0,2}$')
                                  .hasMatch(newValue.text);
                              return isValid ? newValue : oldValue;
                            }),
                          ],
                          textAlign: TextAlign.right,
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            errorText: _amountErrorText,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Align(
                                widthFactor: 1.0,
                                child: Text(
                                  currency,
                                  style:
                                      theme.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                            prefixIconConstraints:
                                const BoxConstraints(minWidth: 0, minHeight: 0),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32.0),

                    // Payment Methods Grid
                    Text(
                      'Choose Payment Method',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12.0),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.count(
                          primary: false,
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.9,
                          physics: const NeverScrollableScrollPhysics(),
                          children:
                              List.generate(channelsCountry.length, (index) {
                            return Material(
                              color: theme.colorScheme.surfaceContainerHighest
                                  .withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(14.0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                      channelsCountry[index]['icon']),
                                ),
                                onTap: () async {
                                  final channel = channelsCountry[index]
                                          ['channel']
                                      .toString();
                                  if (channel.contains('CARD')) {
                                    onProceed(channelsCountry[index]);
                                  } else if (channel.contains('DuitNow')) {
                                    // DuitNow only supports merchant-presented
                                    // QR, so skip the pay-type picker.
                                    _payType = '2';
                                    onProceed(channelsCountry[index]);
                                  } else {
                                    onSetPayType(
                                        context, channelsCountry[index]);
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onSetPayType(BuildContext context, Map<String, dynamic> data) {
    if (!_isAmountValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_amountErrorText!),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      isDismissible: true, // Allow dismiss by tapping outside
      enableDrag: true, // Allow dismiss by swiping down
      isScrollControlled: false,
      builder: (context) {
        final theme = Theme.of(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Payment Type',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _PayTypeOption(
                      image: 'assets/images/qrcode-dark.png',
                      label: 'Show QR',
                      onTap: () {
                        Navigator.pop(context); // Close modal
                        _payType = '2';
                        onProceed(data);
                      },
                    ),
                    _PayTypeOption(
                      image: 'assets/images/scan-dark.png',
                      label: 'Scan QR',
                      onTap: () {
                        Navigator.pop(context); // Close modal
                        _payType = '1';
                        onProceed(data);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PayTypeOption extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap;

  const _PayTypeOption({
    Key? key,
    required this.image,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(image, scale: 2.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                label,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

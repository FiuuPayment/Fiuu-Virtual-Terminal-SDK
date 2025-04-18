import 'package:flutter/material.dart';
import 'package:sample_app/Services/Helper/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class Cart extends StatefulWidget {
  final String country;

  const Cart({Key? key, required this.country}) : super(key: key);

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
  final TextEditingController _amountController = TextEditingController(text: '1.01');

  Future<void> onProceed(Map<String, dynamic> data) async {
    final Uri launchUri = Uri(
      scheme: 'razervt',
      host: "merchant.razer.com",
      query: Helper.instance.encodeQueryParameters(<String, String>{
        'merchantUrlScheme': 'merchantapp',
        'merchantHost': 'merchant.example.com',
        'opType': data['opType'].toString(),
        'currency': currency,
        'amount': _amountController.text,
        'orderId': 'DT${DateTime.now().millisecondsSinceEpoch.toString()}',
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
    debugPrint("logCountry channelsCountry.length = " + channelsCountry.length.toString());

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Payment Page',
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: const Color(0xFF003BA0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16.0),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.share_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),

        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // "Your Items" Title
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Text(
                          'Your Items',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'You have 2 items in your cart.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),

                    // List of items
                    ListTile(
                      leading: Image.asset(
                        'assets/images/cart/razer_keyboard_keychain.jpg',
                        width: 64.0,
                        height: 64.0,
                        fit: BoxFit.cover,
                      ),
                      title: Column(
                        children: const [
                          Text(
                            'Keyboard Keychain',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Icon(Icons.remove_circle_outline_outlined),
                            title: Text('1'),
                            trailing: Icon(Icons.add_circle_outline_outlined),
                          ),
                        ],
                      ),
                      trailing: Text(
                        currency + ' 0.30',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    ListTile(
                      leading: Image.asset(
                        'assets/images/cart/razer_steel_tag.png',
                        width: 64.0,
                        height: 64.0,
                        fit: BoxFit.cover,
                      ),
                      title: Column(
                        children: const [
                          Text(
                            'Steel Tag',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Icon(Icons.remove_circle_outline_outlined),
                            title: Text('1'),
                            trailing: Icon(Icons.add_circle_outline_outlined),
                          ),
                        ],
                      ),
                      trailing: Text(
                        currency + ' 0.30',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 40.0),

                    // Subtotal, Delivery Charges & Total
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                currency + ' 0.60',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery Charges',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                currency + ' 0.41',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                currency + ' ${_amountController.text}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // Amount Input Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Edit Amount',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // Payment Methods Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      child: GridView.count(
                        primary: false,
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 0.9,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(channelsCountry.length, (index) {
                          return InkWell(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(channelsCountry[index]['icon']),
                            ),
                            onTap: () async {
                              if (!channelsCountry[index]['channel']
                                  .toString()
                                  .contains('CARD')) {
                                onSetPayType(context, channelsCountry[index]);
                              } else {
                                onProceed(channelsCountry[index]);
                              }
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),


      ),
    );
  }

  void onSetPayType(BuildContext context, Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,  // Allow dismiss by tapping outside
      enableDrag: true,     // Allow dismiss by swiping down
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,  // Allows tap outside to dismiss
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/images/qrcode-dark.png',
                      scale: 2.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close modal
                    _payType = '2';
                    onProceed(data);
                  },
                ),
                InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/images/scan-dark.png',
                      scale: 2.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close modal
                    _payType = '1';
                    onProceed(data);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}

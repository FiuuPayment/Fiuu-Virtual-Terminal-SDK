import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/Services/Helper/helper.dart';
import 'package:sample_app/Services/Routes/router.gr.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _orderIdController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _orderIdController.dispose();
    super.dispose();
  }

  Future<void> _showCountryPicker(BuildContext context) async {
    String? selectedCountry = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Country'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('MY'),
                onTap: () => Navigator.of(context).pop('MY'),
              ),
              ListTile(
                title: const Text('SG'),
                onTap: () => Navigator.of(context).pop('SG'),
              ),
              ListTile(
                title: const Text('PH'),
                onTap: () => Navigator.of(context).pop('PH'),
              ),
            ],
          ),
        );
      },
    );

    if (selectedCountry != null) {
      // Navigate and pass the selected country
      debugPrint("logCountry home selectedCountry = " + selectedCountry);
      AutoRouter.of(context).push(Cart(country: selectedCountry));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Fiuu VT App-to-App Demo',
          style: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color(0xFF003BA0),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _orderIdController,
                  decoration: const InputDecoration(
                    labelText: 'Order ID',
                  ),
                ),
                const SizedBox(height: 16.0),
                GridView.count(
                  primary: false,
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.9,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    InkWell(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          width: 64.0,
                          height: 64.0,
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          child: const Text(
                            'Pay',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () => _showCountryPicker(context),
                    ), // Sale

                    InkWell(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          width: 64.0,
                          height: 64.0,
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          child: const Text(
                            'Void',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (_orderIdController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order ID is required!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        onVoid();
                      },
                    ),

                    InkWell(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          width: 64.0,
                          height: 64.0,
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          child: const Text(
                            'Status',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (_orderIdController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order ID is required!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        onStatus();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> onVoid() async {
    final Uri launchUri = Uri(
      scheme: 'razervt',
      host: "merchant.razer.com",
      query: Helper.instance.encodeQueryParameters(<String, String>{
        'merchantUrlScheme': 'merchantapp',
        'merchantHost': 'merchant.example.com',
        'opType': 'VOID',
        'orderId': _orderIdController.text,
      }),
    );
    try {
      debugPrint('logVoidStatus try launchUri = ' + launchUri.toString());
      await launch(launchUri.toString());
    } catch (e) {
      debugPrint('logVoidStatus Error: $e');
    }
  }

  Future<void> onStatus() async {
    final Uri launchUri = Uri(
      scheme: 'razervt',
      host: "merchant.razer.com",
      query: Helper.instance.encodeQueryParameters(<String, String>{
        'merchantUrlScheme': 'merchantapp',
        'merchantHost': 'merchant.example.com',
        'opType': 'STATUS',
        'orderId': _orderIdController.text,
      }),
    );
    try {
      debugPrint('logVoidStatus try launchUri = ' + launchUri.toString());
      await launch(launchUri.toString());
    } catch (e) {
      debugPrint('logVoidStatus Error: $e');
    }
  }

}
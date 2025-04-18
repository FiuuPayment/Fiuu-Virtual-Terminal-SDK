import 'package:flutter/material.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key, required this.receiptData}) : super(key: key);

  final Map<String, dynamic> receiptData;

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  void initState() {
    super.initState();
    debugPrint('From receipt: ${widget.receiptData}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 24.0, left: 16, right: 16),
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 64.0,
                      alignment: Alignment.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 4.0),
                              child: widget.receiptData['Company'] != null
                                  ? Text(
                                      widget.receiptData['Company']
                                          .toString()
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: 'Monaco',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold))
                                  : const Text('Company Name Not Available')),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 4.0),
                              child: widget.receiptData['Address_1'] != null
                                  ? Text(
                                      widget.receiptData['Address_1']
                                          .toString()
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: 'Monaco',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold))
                                  : const Text('Address Line 1 Not Available')),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 4.0),
                              child: widget.receiptData['Address_2'] != null
                                  ? Text(
                                      widget.receiptData['Address_2']
                                          .toString()
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: 'Monaco',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold))
                                  : const Text('Address Line 2 Not Available')),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 4.0),
                              child: widget.receiptData['Country'] != null
                                  ? Text(
                                      widget.receiptData['Country']
                                          .toString()
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: 'Monaco',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold))
                                  : const Text('Country Not Available')),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: Text(
                                'TEL: ${widget.receiptData['Contact'] ?? 'Contact Not Available'}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'Monaco', fontSize: 12.0)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        widget.receiptData['Status'] == 'cancelled' ? 'REFUND' : 'SALE',
                        style: const TextStyle(
                            fontFamily: 'Monaco', fontSize: 24.0),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'DATE/TIME',
                              style: TextStyle(
                                  fontFamily: 'Monaco', fontSize: 12.0),
                            ),
                            Text(
                              widget.receiptData['Date'] ?? 'Not Available',
                              style: const TextStyle(
                                  fontFamily: 'Monaco', fontSize: 12.0),
                            ),
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'ORDER ID',
                              style: TextStyle(
                                  fontFamily: 'Monaco', fontSize: 12.0),
                            ),
                            Text(
                              widget.receiptData['Order_ID'] ?? 'Not Available',
                              style: const TextStyle(
                                  fontFamily: 'Monaco', fontSize: 12.0),
                            ),
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'TID',
                              style: TextStyle(
                                  fontFamily: 'Monaco', fontSize: 12.0),
                            ),
                            Text(
                              widget.receiptData['TID'] ?? 'Not Available',
                              style: const TextStyle(
                                  fontFamily: 'Monaco', fontSize: 12.0),
                            ),
                          ],
                        )),
                    // Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 16.0, vertical: 4.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         const Text(
                    //           'MID',
                    //           style: TextStyle(
                    //               fontFamily: 'Monaco', fontSize: 12.0),
                    //         ),
                    //         Text(
                    //           widget.receiptData['MID'] ?? 'Not Available',
                    //           style: const TextStyle(
                    //               fontFamily: 'Monaco', fontSize: 12.0),
                    //         ),
                    //       ],
                    //     )),
                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 16.0, vertical: 16.0),
                    //   child: Column(
                    //     children: const [
                    //       SizedBox(
                    //         width: double.infinity,
                    //         child: Text(
                    //           'MyDebit',
                    //           textAlign: TextAlign.left,
                    //           style: TextStyle(
                    //               fontFamily: 'Monaco',
                    //               fontSize: 16.0,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10.0,
                    //       ),
                    //       SizedBox(
                    //         width: double.infinity,
                    //         child: Text(
                    //           'Card Number',
                    //           style: TextStyle(
                    //               fontFamily: 'Monaco',
                    //               fontSize: 16.0,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'APPR CODE',
                              style: TextStyle(
                                  fontFamily: 'Monaco', fontSize: 12.0),
                            ),
                            Text(
                              widget.receiptData['App_Code'] ?? 'Not Available',
                              style: const TextStyle(
                                  fontFamily: 'Monaco', fontSize: 12.0),
                            ),
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'REF ID',
                              style: TextStyle(
                                  fontFamily: 'Monaco', fontSize: 12.0),
                            ),
                            Text(
                              widget.receiptData['Txn_ID'] ?? 'Not Available',
                              style: const TextStyle(
                                  fontFamily: 'Monaco', fontSize: 12.0),
                            ),
                          ],
                        )),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const Divider(
                            thickness: 1.0,
                          ),
                          ListTile(
                            dense: true,
                            contentPadding:
                                const EdgeInsets.only(left: 0.0, right: 0.0),
                            title: const Text(
                              'AMT',
                              style: TextStyle(
                                  fontFamily: 'Monaco',
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              '${widget.receiptData['Currency_Used'] ?? 'Not Available'} ${widget.receiptData['Bill_Amt'] ?? 'Not Available'}',
                              style: const TextStyle(
                                  fontFamily: 'Monaco',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      child: const Text(
                        'I AGREE TO PAY THE ABOVE TOTAL AMOUNT',
                        style: TextStyle(fontFamily: 'Monaco', fontSize: 10.0),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      child: const Text(
                        'ACCORDING TO THE CARD ISSUER AGREEMENT',
                        style: TextStyle(fontFamily: 'Monaco', fontSize: 10.0),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

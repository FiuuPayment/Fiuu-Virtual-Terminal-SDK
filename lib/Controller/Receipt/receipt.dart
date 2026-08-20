import 'package:flutter/material.dart';

import '../../Services/Theme/app_theme.dart';

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
    final theme = Theme.of(context);
    final bool isRefund = widget.receiptData['Status'] == 'cancelled';

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.only(top: 24.0, left: 16, right: 16, bottom: 8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 24.0,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isRefund
                            ? StatusColors.failedContainer
                            : StatusColors.successContainer,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Text(
                        isRefund ? 'REFUND' : 'SALE',
                        style: TextStyle(
                            fontFamily: 'Monaco',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: isRefund
                                ? StatusColors.failed
                                : StatusColors.success),
                      ),
                    ),
                    const SizedBox(height: 32),
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
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                child: Material(
                  color: theme.colorScheme.surfaceContainerHighest,
                  shape: const CircleBorder(),
                  elevation: 2.0,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

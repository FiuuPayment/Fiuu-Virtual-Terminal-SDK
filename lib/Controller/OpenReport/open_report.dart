// import 'dart:convert';
// import 'dart:io';
//
// import 'package:auto_route/auto_route.dart';
// import 'package:excel/excel.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sample_app/Services/Routes/router.gr.dart';
//
// class OpenReport extends StatefulWidget {
//   const OpenReport({Key? key}) : super(key: key);
//
//   @override
//   _OpenReportState createState() => _OpenReportState();
// }
//
// class _OpenReportState extends State<OpenReport> {
//   String filename = '';
//   Future<List<Map<String, dynamic>>> futureList =
//   Future.value(<Map<String, dynamic>>[]);
//   String recordCount = '';
//
//   @override
//   void initState() {
//     super.initState();
//
//     // OpenFile.open("/files/txn.csv").then((value) {
//     //   debugPrint('Type: ${value.type}');
//     //   debugPrint('Massage: ${value.message}');
//     // });
//
//     loadAsset().then((value) {
//       debugPrint('Type: $value');
//     });
//   }
//
//   Future selectFile() async {
//     FilePickerResult? result = await FilePicker.platform
//         .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
//     return result!.files.single.path;
//   }
//
//   Future getSDCardDirectory() async {
//     Directory? directory = await getApplicationDocumentsDirectory();
//     // Directory? directory = await getExternalStorageDirectory();
//     debugPrint(directory.path);
//     await directory.list().toList().then((filesList) {
//       for (var file in filesList) {
//         debugPrint('$file');
//       }
//     });
//     debugPrint(directory.parent.path);
//   }
//
//   Future<String> loadAsset() async {
//     // return await rootBundle.loadString('assets/files/txn.csv');
//     return await rootBundle.loadString('assets/files/vtapi_merchant_razer_com.pem');
//   }
//
//   Future<List<Map<String, dynamic>>> readExcelFile(String file) async {
//     var bytes = File(file).readAsBytesSync();
//     var excel = Excel.decodeBytes(bytes);
//     List<Map<String, dynamic>> txnSheet = [];
//
//     for (var table in excel.tables.keys) {
//       // debugPrint('Sheet name: $table');
//       // debugPrint('${excel.tables[table]!.maxCols}');
//       // debugPrint('${excel.tables[table]!.maxRows}');
//       List<String> header = [];
//       for (var i = 0; i < excel.tables[table]!.rows[0].length; i++) {
//         // debugPrint('${excel.tables[table]!.rows[0][i]!.value}');
//         header.add(excel.tables[table]!.rows[0][i]!.value
//             .toString()
//             .replaceAll(' ', '_'));
//       }
//       int skipCopyHeader = 0;
//       for (var row in excel.tables[table]!.rows) {
//         skipCopyHeader++;
//         Map<String, dynamic> txnRecord = {};
//         for (var i = 0; i < header.length; i++) {
//           txnRecord.putIfAbsent(header[i], () => row[i]?.value);
//         }
//         if (skipCopyHeader > 1) {
//           txnSheet.add(txnRecord);
//         }
//       }
//     }
//     return txnSheet;
//   }
//
//   Future loadExcelAsset() async {
//     List<Map<String, dynamic>> txnSheet = [];
//     ByteData data = await rootBundle.load("assets/files/Txn_Listing.xlsx");
//     var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//     var excel = Excel.decodeBytes(bytes);
//
//     for (var table in excel.tables.keys) {
//       // debugPrint('Sheet name: $table');
//       // debugPrint('${excel.tables[table]!.maxCols}');
//       // debugPrint('${excel.tables[table]!.maxRows}');
//       List<String> header = [];
//       for (var i = 0; i < excel.tables[table]!.rows[0].length; i++) {
//         // debugPrint('${excel.tables[table]!.rows[0][i]!.value}');
//         header.add(excel.tables[table]!.rows[0][i]!.value
//             .toString()
//             .replaceAll(' ', '_'));
//       }
//       int skipCopyHeader = 0;
//       for (var row in excel.tables[table]!.rows) {
//         skipCopyHeader++;
//         Map<String, dynamic> txnRecord = {};
//         for (var i = 0; i < header.length; i++) {
//           txnRecord.putIfAbsent(header[i], () => row[i]?.value);
//         }
//         if (skipCopyHeader > 1) {
//           txnSheet.add(txnRecord);
//         }
//       }
//     }
//     return txnSheet;
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Container(
//           width: double.infinity,
//           height: 32.0,
//           alignment: Alignment.centerLeft,
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Text(
//             filename,
//             style: const TextStyle(fontSize: 14.0, color: Colors.grey),
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.white, width: 1),
//             borderRadius: const BorderRadius.all(Radius.circular(3)),
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(
//               Icons.search,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               selectFile().then((value) {
//                 setState(() {
//                   File file = File(value);
//                   filename = file.path.split('/').last;
//                   futureList = readExcelFile(value);
//                   futureList.then((value) => recordCount = int.tryParse(value.length.toString()).toString());
//                 });
//               });
//             },
//           ),
//         ],
//         centerTitle: true,
//         elevation: 0.0,
//         backgroundColor: const Color(0xFF003BA0),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Column(
//             children: [
//               Container(
//                 height: 32.0,
//                 color: Colors.grey.shade300,
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Row(
//                   children: [
//                     Text('No. of records found: $recordCount'),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: StreamBuilder(
//                     stream: futureList.asStream(),
//                     builder: (BuildContext context, AsyncSnapshot snapshot) {
//                       switch (snapshot.connectionState) {
//                         case ConnectionState.waiting:
//                           return const Material(
//                             child: Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           );
//                         case ConnectionState.done:
//                           if (snapshot.hasData) {
//                             debugPrint('${snapshot.data}');
//                             var jsonString = json.encode(snapshot.data);
//                             var jsonObject = json.decode(jsonString);
//                             return ListView.separated(
//                               itemCount: jsonObject.length,
//                               itemBuilder: (context, index) {
//                                 return ListTile(
//                                   leading: Text('$index'),
//                                   title:
//                                   Text(jsonObject[index]['Txn_ID'] ?? ''),
//                                   subtitle: Text(
//                                       '${jsonObject[index]['Currency_Used'] ?? ''} ${jsonObject[index]['Bill_Amt'] ?? ''}'),
//                                   onTap: () {
//                                     Map<String, dynamic> tempData =
//                                     jsonObject[index];
//                                     tempData.putIfAbsent('Company',
//                                             () => 'KULINER NUSANTARA BEREMPAH (MALAYSIA) SDN BHD');
//                                     tempData.putIfAbsent('Address_1',
//                                             () => '50 JALAN PUTRA SQUARE 1 PUTRA SQUARE');
//                                     tempData.putIfAbsent('Address_2',
//                                             () => '25200 DAMANSARA, KUALA LUMPUR');
//                                     tempData.putIfAbsent(
//                                         'Country', () => 'MALAYSIA');
//                                     tempData.putIfAbsent('Contact',
//                                             () => '601137535580');
//                                     tempData.putIfAbsent(
//                                         'TID', () => '12640044');
//                                     AutoRouter.of(context).push(Receipt(
//                                         receiptData: jsonObject[index]));
//                                   },
//                                 );
//                               },
//                               separatorBuilder:
//                                   (BuildContext context, int index) {
//                                 return Divider(
//                                   color: Colors.grey.shade300,
//                                 );
//                               },
//                             );
//                           } else {
//                             return Container();
//                           }
//                         default:
//                           return Container();
//                       }
//                     }),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   void onShowFiles(context) {
//     showModalBottomSheet(
//         context: context,
//         isDismissible: true,
//         enableDrag: true,
//         isScrollControlled: false,
//         backgroundColor: Colors.white,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
//         ),
//         builder: (context) {
//           return StatefulBuilder(
//               builder: (BuildContext context, StateSetter state) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: const [],
//                 );
//               });
//         });
//   }
// }

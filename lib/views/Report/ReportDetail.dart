import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../model/bill_details.dart';
import '../Bottom_Navigation.dart';

class BillDetailScreen extends StatelessWidget {
  BillDetailScreen({Key? key}) : super(key: key);
  List<BillDetails> billDetail = [
    BillDetails(
        cargoType: "Stell Bars",
        packaging: "Bulk",
        paidDate: "2023-05-10",
        price: 20000,
        weight: "40 Kg",
        paymentDueDate: "2024-05-10",
        billStatus: "Unpaid"),
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BottomNav()));
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        title: Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: screenWidth * 0.12),
          height: 40,
          child: const Center(
            child: Text(
              "Report History Detail",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: billDetail.length,
        itemBuilder: (context, index) {
          BillDetails detail = billDetail[index];
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 15),
              child: Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                        child: ListTile(
                          title: const Text(
                            "Bill Status",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text(
                            detail.billStatus,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Packaging"),
                        trailing: Text(detail.packaging),
                      ),
                      ListTile(
                        title: const Text("Weight"),
                        trailing: Text(detail.weight),
                      ),
                      ListTile(
                        title: const Text("price"),
                        trailing: Text(detail.price.toString()),
                      ),
                      ListTile(
                        title: const Text("Payment Due Date"),
                        trailing: Text(detail.paymentDueDate),
                      ),
                      ListTile(
                        title: const Text("Cargo Type"),
                        trailing: Text(
                          detail.cargoType,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            letterSpacing: 1,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pdf = pw.Document();
          pdf.addPage(pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(32),
            build: (pw.Context context) {
              return <pw.Widget>[
                pw.Header(
                  level: 0,
                  child: pw.Text('Bill Detail'),
                ),
                pw.ListView.builder(
                  itemCount: billDetail.length,
                  itemBuilder: (context, index) {
                    BillDetails detail = billDetail[index];
                    return pw.Container(
                      padding: const pw.EdgeInsets.all(16),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text("Packaging:"),
                                pw.Text(detail.packaging),
                              ]),
                          pw.SizedBox(height: 20),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text("Weight:"),
                                pw.Text(detail.weight),
                              ]),
                          pw.SizedBox(height: 20),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text("Price:"),
                                pw.Text(' ${detail.price}'),
                              ]),
                          pw.SizedBox(height: 20),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text('Payment Due Date: '),
                                pw.Text(detail.paymentDueDate),
                              ]),
                        ],
                      ),
                    );
                  },
                ),
              ];
            },
          ));
          await Printing.layoutPdf(
            onLayout: (PdfPageFormat format) async => pdf.save(),
          );
        },
        child: const Icon(Icons.print),
      ),
    );
  }
}

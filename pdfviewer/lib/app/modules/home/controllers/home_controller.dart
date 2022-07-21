import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  var products = List.generate(
    20,
    (index) => {
      "id": "${index + 1}",
      "name": "Produk ke - ${index + 1}",
      "desc": DateTime.now().toString(),
    },
  );

  void getPDF() async {
    // buat class pdf
    final pdf = pw.Document();

    // my font
    var dataFont = await rootBundle.load("assets/RoadRage-Regular.ttf");
    var myFont = pw.Font.ttf(dataFont);

    // my images
    var dataImage = await rootBundle.load("assets/image.jpg");
    var myImage = dataImage.buffer.asUint8List();

    // buat pages
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.ClipRRect(
              horizontalRadius: 20,
              verticalRadius: 20,
              child: pw.Container(
                width: 350,
                height: 270,
                child: pw.Image(
                  pw.MemoryImage(myImage),
                  fit: pw.BoxFit.cover,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Container(
              color: PdfColors.red800,
              alignment: pw.Alignment.center,
              width: double.infinity,
              child: pw.Text(
                "MY PRODUCTS",
                style: pw.TextStyle(
                  fontSize: 50,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                  font: myFont,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Column(
              children: products
                  .map(
                    (e) => pw.Text(
                      "ID : ${e['id']} - ${e['name']}\n${e['desc']}\n\n",
                      style: pw.TextStyle(
                        fontSize: 30,
                        font: myFont,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ];
        },
      ),
    ); // Page

    // simpan
    Uint8List bytes = await pdf.save();

    // buat file kosong di direktori
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mydocument.pdf');

    // timpa file kosong dengan file pdf
    await file.writeAsBytes(bytes);

    // open pdf
    await OpenFile.open(file.path);
  }
}

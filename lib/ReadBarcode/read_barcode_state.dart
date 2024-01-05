import 'package:flutter/material.dart';
import 'package:deolhonopreco/ReadBarcode/read_barcode.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../ProductDetails/product_details_screen.dart';
import 'ProductDetails/product_details_screen.dart';

class ReadBarcodeState extends State<ReadBarcode> {
  String barcodeValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acha Produto"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Bem-vindo ao Acha Produto!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            "Toque no botão abaixo para escanear o código de barras e encontrar informações sobre o produto.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _scanBarcode(context),
            child: const Text("Escanear Código de Barras"),
          ),
        ],
      ),
    );
  }

  Future<void> _scanBarcode(BuildContext context) async {
    String scanResult = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancelar",
      false,
      ScanMode.BARCODE,
    );

    setState(() {
      barcodeValue = scanResult;
    });

    if (scanResult.isNotEmpty) {
      widget.onBarcodeScanned(scanResult);
    }
  }
}

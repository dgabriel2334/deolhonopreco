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
        title: const Text("Leitor de Código de Barras"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: Center(
                child: ElevatedButton(
                  onPressed: () => _scanBarcode(context), // Passe o contexto para a função
                  child: const Text("Abrir Câmera"),
                ),
              ),
            ),
          ),
          Text("Valor do Código de Barras: $barcodeValue"),
        ],
      ),
    );
  }

  Future<void> _scanBarcode(BuildContext context) async {
    String scanResult = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", // cor de fundo
      "Cancelar", // texto do botão de cancelar
      false, // flash ligado/desligado
      ScanMode.BARCODE, // modo de varredura (pode ser QR_CODE, BARCODE, entre outros)
    );

    setState(() {
      barcodeValue = scanResult;
    });

    if (scanResult.isNotEmpty) {
      // Se o código de barras não estiver vazio, navegue para a tela de detalhes
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(barcode: scanResult),
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'read_barcode_state.dart';
import 'ProductDetails/product_details_screen.dart';

class ReadBarcode extends StatefulWidget {
  final void Function(String) onBarcodeScanned;

  const ReadBarcode({Key? key, required this.onBarcodeScanned})
      : super(key: key);

  @override
  ReadBarcodeState createState() => ReadBarcodeState();
}

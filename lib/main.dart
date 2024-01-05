import 'package:flutter/material.dart';
import 'ReadBarcode/read_barcode.dart';
import 'ProductDetails/product_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AchaProdutoScreen(),
    );
  }
}

class AchaProdutoScreen extends StatelessWidget {
  const AchaProdutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Acha Produto",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Encontre informações sobre produtos escaneando o código de barras. \n"
                  "Pode ser que não encontre o produto que você procura, mas não desista! \n"
                  "Ainda estamos trabalhando para melhorar o aplicativo.\n",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadBarcode(
                      onBarcodeScanned: (barcode) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsScreen(barcode: barcode),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: const Text("Começar"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Feito em Flutter por Dário Gabriel",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductDetailsScreen extends StatefulWidget {
  final String barcode;

  const ProductDetailsScreen({Key? key, required this.barcode})
      : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Map<String, dynamic> productDetails = {};
  late bool hasImage = false;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    final responseProduct = await http.get(Uri.parse(
        'http://www.eanpictures.com.br:9000/api/desc/${widget.barcode}'));
    final responseImage = await http.get(Uri.parse(
        'http://www.eanpictures.com.br:9000/api/fotoexistej/${widget.barcode}'));

    final Map<String, dynamic> decodedBodyImage =
        json.decode(responseImage.body);

    if (responseProduct.statusCode == 200) {
      final Map<String, dynamic> decodedBody =
          json.decode(responseProduct.body);

      if (decodedBody["Status"] == "200") {
        if (decodedBodyImage["Status"] == "200") {
          setState(() {
            hasImage = true;
          });
        }
        setState(() {
          productDetails = decodedBody;
        });
      } else {
        _showProductNotFoundAlert(decodedBody["Status_Desc"]);
      }
    } else {
      // Código de resposta não é 200
      final Map<String, dynamic> errorDetails =
          json.decode(responseProduct.body);

      _showProductNotFoundAlert(errorDetails["Status_Desc"]);
    }
  }

  void _showProductNotFoundAlert(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Produto não encontrado'),
          content: Text(
              "Não foi possível encontrar o produto com código EAN: ${widget.barcode}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
      ),
      body: productDetails != null
          ? Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Center(
                      child: hasImage
                          ? Image.network(
                              'http://www.eanpictures.com.br:9000/api/gtin/${widget.barcode}',
                              height: 300,
                            )
                          : const Text('Imagem não disponível')),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Descrição: ${productDetails["Nome"] ?? "Não informado"}'),
                      Text(
                          'Marca: ${productDetails["Marca"] ?? "Não informado"}'),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductDetailsScreen extends StatefulWidget {
  final String barcode;

  const ProductDetailsScreen({Key? key, required this.barcode}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Map<String, dynamic> productDetails;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    final response = await http.get(Uri.parse('http://www.eanpictures.com.br:9000/api/desc/${widget.barcode}'));

    if (response.statusCode == 200) {
      setState(() {
        productDetails = json.decode(response.body);
      });
    }
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
          // Display the image with adjusted aspect ratio
          Container(
            height: 200, // Adjust the height as needed
            width: double.infinity,
            child: Center(
              child: Image.network(
                'http://www.eanpictures.com.br:9000/api/gtin/${widget.barcode}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Descrição: ${productDetails["Nome"] == "" ? "Não informado" : productDetails["Nome"]}'),
                Text('Marca: ${productDetails["Marca"] == "" ? "Não informado" : productDetails["Marca"]}'),
                // Add other details as needed
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

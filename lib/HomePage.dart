import 'package:flutter/material.dart';

import 'models/ProductModel.dart';
import 'services/DatabaseHandler.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse('0xFF1b212f')),
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: DatabaseHandler.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Product>? products = snapshot.data;
            if (products == null || products.isEmpty) {
              return const Center(
                child: Text('No products available'),
              );
            } else {
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    onTap: () {
                      // Handle tap on product if needed
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}

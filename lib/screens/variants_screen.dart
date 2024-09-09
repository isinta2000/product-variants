import 'package:flutter/material.dart';
import '../models/product_model.dart';

class VariantsScreen extends StatelessWidget {
  final List<ProductVariant> variants;

  VariantsScreen({required this.variants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Variants'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: variants.length,
          itemBuilder: (context, index) {
            final variant = variants[index];
            return ListTile(
              title: Text(variant.options.entries.map((e) => '${e.key}: ${e.value}').join(', ')),
            );
          },
        ),
      ),
    );
  }
}

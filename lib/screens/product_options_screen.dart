import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'variants_screen.dart';

class ProductOptionsScreen extends StatefulWidget {
  @override
  _ProductOptionsScreenState createState() => _ProductOptionsScreenState();
}

class _ProductOptionsScreenState extends State<ProductOptionsScreen> {
  final List<ProductOption> _options = [];
  final _optionNameController = TextEditingController();
  final _valueController = TextEditingController();

  void _addOption() {
    if (_optionNameController.text.isNotEmpty) {
      setState(() {
        _options.add(ProductOption(name: _optionNameController.text, values: []));
        _optionNameController.clear();
      });
    } else {
      _showErrorDialog("Option name cannot be empty");
    }
  }

  void _addValue(ProductOption option) {
    if (_valueController.text.isNotEmpty) {
      setState(() {
        if (option.values.contains(_valueController.text)) {
          _showErrorDialog("Value already exists for this option");
        } else {
          option.values.add(_valueController.text);
          _valueController.clear();
        }
      });
    } else {
      _showErrorDialog("Value cannot be empty");
    }
  }

  void _generateVariants() {
    if (_options.isEmpty || _options.any((opt) => opt.values.isEmpty)) {
      _showErrorDialog("All options must have at least one value");
      return;
    }

    List<List<String>> optionValues = _options.map((opt) => opt.values).toList();
    List<ProductVariant> variants = [];
    _generateVariantsRecursive(optionValues, 0, {}, variants);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VariantsScreen(variants: variants),
      ),
    );
  }

  void _generateVariantsRecursive(
    List<List<String>> optionValues,
    int index,
    Map<String, String> currentOption,
    List<ProductVariant> variants,
  ) {
    if (index == optionValues.length) {
      variants.add(ProductVariant(Map.from(currentOption)));
      return;
    }

    for (String value in optionValues[index]) {
      currentOption[_options[index].name] = value;
      _generateVariantsRecursive(optionValues, index + 1, currentOption, variants);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
        title: Text('Product Variants'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextField(
                    controller: _optionNameController,
                    decoration: InputDecoration(labelText: 'Option Name'),
                  ),
                  ElevatedButton(
                    onPressed: _addOption,
                    child: Text('Add Option'),
                  ),
                  ..._options.map((option) => ExpansionTile(
                    title: Text(option.name),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _valueController,
                          decoration: InputDecoration(labelText: 'Value'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _addValue(option),
                        child: Text('Add Value'),
                      ),
                      ...option.values.map((value) => ListTile(title: Text(value))).toList(),
                    ],
                  )).toList(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _generateVariants,
              child: Text('Generate Variants'),
            ),
          ),
        ],
      ),
    );
  }
}

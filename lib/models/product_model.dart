class ProductOption {
  String name;
  List<String> values;

  ProductOption({required this.name, required this.values});
}

class ProductVariant {
  Map<String, String> options;

  ProductVariant(this.options);
}

Future<void> fetchData() async {
  print ('Fetching data...');
  await Future.delayed(Duration(seconds: 2));
  print('Data fetched.');
}

Future<List<String>> fetchProductData() async {
  print('Fetching product data...');
  await Future.delayed(Duration(seconds: 2));
  print('Product data fetched.');
  return ['Product 1', 'Product 2', 'Product 3'];
}

Future<Map<String, int>> fetchDeMap() async {
  await Future.delayed(Duration(seconds: 2));

  return {"Product 1": 1, "Product 2": 2, "Product 3": 3};
}

void main() {
  fetchProductData()
    .then((value) => value)
    .catchError((error) => Future<List<String>>.error(["Error1", "Error2", "Error3"]));
    .whenComplete(() => print("Completado"));

  fetchDeMap()
    .then((value) => value)
    .catchError((error) => Future<Map<String, int>>.error({"Error1": 1, "Error2": 2, "Error3": 3}))
    .whenComplete(() => print("Completado"));
}
class Box<T> {
  T value;
  Box(this.value);

  void printValue() {
    print(value);
  }

  T firstValue(List<T> values) {
    return values.first;
  }
}

void main() {
  var box = Box<int>(1);
  box.printValue();
  print(box.firstValue([1, 2, 3]));

  var box2 = Box<String>('Hello');
  box2.printValue();

  var box3 = Box<bool>(true);
  box3.printValue();
}
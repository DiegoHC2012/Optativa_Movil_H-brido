import 'data_formatter.dart';

/// The abstract factory (The Creator).
abstract class FormatterFactory {
  IDataFormatter createFormatter();
}

/// The concrete factory that creates a formatter based on the type.
class ConcreteFormatterFactory extends FormatterFactory {
  final String formatType;

  ConcreteFormatterFactory(this.formatType);

  @override
  IDataFormatter createFormatter() {
    switch (formatType.toLowerCase()) {
      case 'json':
        return JsonFormatter();
      case 'xml':
        return XmlFormatter();
      case 'csv':
        return CsvFormatter();
      default:
        throw ArgumentError('Invalid format type: $formatType');
    }
  }
}

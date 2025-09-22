import 'dart:convert';
import '../models/movie.dart';

/// Interface for data formatters (The Product).
abstract class IDataFormatter {
  String format(List<Movie> data);
}

/// Implementation to format data into JSON.
class JsonFormatter implements IDataFormatter {
  @override
  String format(List<Movie> data) {
    final List<Map<String, dynamic>> movieList =
        data.map((movie) => movie.toJson()).toList();
    return JsonEncoder.withIndent('  ').convert(movieList);
  }
}

/// Implementation to format data into XML.
class XmlFormatter implements IDataFormatter {
  @override
  String format(List<Movie> data) {
    var xml = StringBuffer('<?xml version="1.0" encoding="UTF-8"?>\n<movies>\n');
    for (var movie in data) {
      xml.write('  <movie>\n');
      xml.write('    <title>${_escapeXml(movie.title)}</title>\n');
      xml.write('    <overview>${_escapeXml(movie.overview)}</overview>\n');
      xml.write('    <releaseDate>${_escapeXml(movie.releaseDate)}</releaseDate>\n');
      xml.write('    <voteAverage>${movie.voteAverage}</voteAverage>\n');
      xml.write('  </movie>\n');
    }
    xml.write('</movies>');
    return xml.toString();
  }

  String _escapeXml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }
}

/// Implementation to format data into CSV.
class CsvFormatter implements IDataFormatter {
  @override
  String format(List<Movie> data) {
    var csv = StringBuffer('Title,Overview,ReleaseDate,VoteAverage\n');
    for (var movie in data) {
      csv.write(
          '"${_escapeCsv(movie.title)}","${_escapeCsv(movie.overview)}","${movie.releaseDate}",${movie.voteAverage}\n');
    }
    return csv.toString();
  }

  String _escapeCsv(String text) {
    return text.replaceAll('"', '""');
  }
}

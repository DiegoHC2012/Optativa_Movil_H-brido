import 'IRestAPIClient.dart';
import 'dart:io';
import 'dart:convert';

class APIClient<T, D> implements IRestAPIClient<T, D> {
  @override
  Future<D> get(String url, {Map<String, String>? headers}) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse(url));
      setHeaders(request, headers);
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(responseBody) as D;
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}, body: $responseBody');
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<D> post(String url, T data, {Map<String, String>? headers}) async {
    final client = HttpClient();
    try {
      final request = await client.postUrl(Uri.parse(url));
      request.headers.set('Content-Type', 'application/json; charset=UTF-8');
      setHeaders(request, headers);
      request.write(jsonEncode(data));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(responseBody) as D;
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}, body: $responseBody');
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<D> put(String url, T data, {Map<String, String>? headers}) async {
    final client = HttpClient();
    try {
      final request = await client.putUrl(Uri.parse(url));
      request.headers.set('Content-Type', 'application/json; charset=UTF-8');
      setHeaders(request, headers);
      request.write(jsonEncode(data));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(responseBody) as D;
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}, body: $responseBody');
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<D> delete(String url, {Map<String, String>? headers}) async {
    final client = HttpClient();
    try {
      final request = await client.deleteUrl(Uri.parse(url));
      setHeaders(request, headers);
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(responseBody) as D;
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}, body: $responseBody');
      }
    } finally {
      client.close();
    }
  }
  
  void setHeaders(HttpClientRequest request, Map<String, String>? headers) {
    headers?.forEach((key, value) {
      request.headers.add(key, value);
    });
  }
}

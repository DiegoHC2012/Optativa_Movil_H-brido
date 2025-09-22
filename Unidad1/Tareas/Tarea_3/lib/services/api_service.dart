import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

/// Interface for a service that consumes data from an API.
abstract class IApiService<T> {
  Future<List<T>> fetchData();
}

/// Implementation for consuming The Movie DB API.
class MovieApiService implements IApiService<Movie> {
  // IMPORTANT: Replace 'YOUR_API_TOKEN' with your actual token from The Movie DB.
  // You can get one by registering at https://www.themoviedb.org/
  static const String _apiToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZTdlZmExMDU4MmQ5NTNmZmEyNzJkZTA1YzNkNmM0MiIsIm5iZiI6MTc1ODQ5NzM4Ny4wMjcsInN1YiI6IjY4ZDA4YTZiYTZjOWI4ODIxYzc0OWI4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ZEXMwzj5NC-diyqhjczA8JyvbQ_6XewiVhKh2k0hE0k';
  static const String _apiUrl = 'https://api.themoviedb.org/3/movie/popular';

  @override
  Future<List<Movie>> fetchData() async {
    final response = await http.get(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Bearer $_apiToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      // Map the list of results to a list of Movie objects.
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception(
          'Failed to load movies. Status code: ${response.statusCode}');
    }
  }
}

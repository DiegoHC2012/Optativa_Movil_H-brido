abstract class IRestAPIClient<T, D> {
  Future<D> get(String url, {Map<String, String>? headers});
  Future<D> post(String url, T data, {Map<String, String>? headers});
  Future<D> put(String url, T data, {Map<String, String>? headers});
  Future<D> delete(String url, {Map<String, String>? headers}); 
}

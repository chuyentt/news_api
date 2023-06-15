part of news_api;

/// `NewsApi` class allows fetching news articles from NewsAPI.org.
///
/// An instance of this class provides the method [fetchTopHeadlines] which
/// fetches top headlines from a specific country.
///
/// Example usage:
///
/// ```dart
/// import 'package:news_api/news_api.dart';
///
/// Future<void> main() async {
///   var newsApi = NewsApi('<your-api-key>');
///   var articles = await newsApi.fetchTopHeadlines('us');
///   print('articles: $articles');
/// }
/// ```
class NewsApi {
  /// The API key obtained from NewsAPI.org.
  final String apiKey;

  /// The HTTP client that is used to make requests to NewsAPI.org.
  ///
  /// This can be replaced with a mock client for testing purposes.
  http.Client? client;

  /// Creates a new instance of `NewsApi` class.
  ///
  /// Accepts [apiKey] as a required parameter, and [client] as an optional
  /// parameter.
  NewsApi(this.apiKey, {http.Client? client})
      : client = client ?? http.Client() {
    if (apiKey == '<your-api-key>') {
      throw Exception(
          'Please replace <your-api-key> with your NewsAPI.org API key.');
    }
  }

  /// Fetches top headlines from a specific [country] from NewsAPI.org.
  ///
  /// Returns a `Future` that completes with a list of dynamic data
  /// representing articles if the HTTP call succeeds.
  ///
  /// Throws an `Exception` if the HTTP call fails.
  Future<List<dynamic>> fetchTopHeadlines(String country) async {
    final response = await client!.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return jsonData["articles"];
    } else {
      throw Exception('Failed to load news');
    }
  }
}

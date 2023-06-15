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
///   var articles = await newsApi.fetchTopHeadlines(country: 'us');
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

  /// Fetches the top headlines from NewsAPI.org
  ///
  /// [country] - The 2-letter ISO 3166-1 code of the country you want to get
  /// headlines for.
  /// [category] - The category you want to get headlines from.
  /// [sources] - A comma-seperated string of identifiers for the news sources
  /// or blogs you want headlines from.
  /// [q] - Keywords or a phrase to search for.
  /// [pageSize] - The number of results to return per page. (20 results per
  /// page is the default)
  /// [page] - Use this to page through the results if the total results is
  /// greater than the page size.
  Future<List<dynamic>> fetchTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? q,
    int? pageSize,
    int? page,
  }) async {
    if (country == null &&
        category == null &&
        sources == null &&
        q == null &&
        pageSize == null &&
        page == null) {
      throw Exception(
          'You must provide at least one parameter to fetchTopHeadlines');
    }
    String url = 'https://newsapi.org/v2/top-headlines?apiKey=$apiKey';

    if (country != null) url += '&country=$country';
    if (category != null) url += '&category=$category';
    if (sources != null) url += '&sources=$sources';
    if (q != null) url += '&q=$q';
    if (pageSize != null) url += '&pageSize=$pageSize';
    if (page != null) url += '&page=$page';

    final response = await client!.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return jsonData["articles"];
    } else {
      throw Exception('Failed to load news');
    }
  }
}

part of news_api;

/// The `NewsApi` class provides methods for fetching news jsonData from NewsAPI.org.
///
/// An instance of this class provides the methods:
/// - [fetchTopHeadlines] to fetch top headlines from a specific country
/// - [fetchEverything] to fetch news based on specific search parameters
/// - [fetchSources] to fetch the available sources from the News API.
///
/// Example usage:
///
/// ```dart
/// import 'package:news_api/news_api.dart';
///
/// Future<void> main() async {
///   var newsApi = NewsApi('<your-api-key>');
///   var topHeadlines = await newsApi.fetchTopHeadlines(country: 'us');
///   print('Top Headlines: $topHeadlines');
///   var everything = await newsApi.fetchEverything(
///     q: 'bitcoin', from: '2023-05-15', sortBy: 'publishedAt');
///   print('Everything: $everything');
///   var sources = await newsApi.fetchSources(language: 'en', country: 'us');
///   print('Sources: $sources');
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
  Future<Map<String, dynamic>> fetchTopHeadlines({
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
      return jsonData;
    } else {
      throw Exception('Failed to load news');
    }
  }

  /// Fetches news jsonData using the '/everything' endpoint of the News API.
  ///
  /// Accepts parameters to filter the jsonData:
  /// [q] - Keywords or phrases to search for in the article title and body.
  /// [sources] - A comma-separated string of identifiers (maximum 20) for the
  /// news sources or blogs you want headlines from.
  /// [domains] - A comma-separated string of domains (eg bbc.co.uk,
  /// techcrunch.com, engadget.com) to restrict the search to.
  /// [excludeDomains] - A comma-separated string of domains (eg bbc.co.uk,
  /// techcrunch.com, engadget.com) to remove from the results.
  /// [from] - A date and optional time for the oldest article allowed.
  /// [to] - A date and optional time for the latest article allowed.
  /// [language] - The 2-letter ISO-639-1 code of the language you want to get
  /// jsonData in.
  /// [sortBy] - The order to sort the jsonData in. Can be either 'relevancy',
  /// 'popularity', or 'publishedAt'.
  /// [pageSize] - The number of results to return per page. 20 is the default,
  /// 100 is the maximum.
  /// [page] - Use this to page through the results.
  Future<Map<String, dynamic>> fetchEverything({
    String? q,
    String? sources,
    String? domains,
    String? excludeDomains,
    String? from,
    String? to,
    String? language,
    String? sortBy,
    int? pageSize,
    int? page,
  }) async {
    if (q == null &&
        sources == null &&
        domains == null &&
        excludeDomains == null &&
        from == null &&
        to == null &&
        language == null &&
        sortBy == null &&
        pageSize == null &&
        page == null) {
      throw Exception(
          'You must provide at least one parameter to fetchEverything');
    }

    String url = 'https://newsapi.org/v2/everything?apiKey=$apiKey';

    if (q != null) url += '&q=$q';
    if (sources != null) url += '&sources=$sources';
    if (domains != null) url += '&domains=$domains';
    if (excludeDomains != null) url += '&excludeDomains=$excludeDomains';
    if (from != null) url += '&from=$from';
    if (to != null) url += '&to=$to';
    if (language != null) url += '&language=$language';
    if (sortBy != null) url += '&sortBy=$sortBy';
    if (pageSize != null) url += '&pageSize=$pageSize';
    if (page != null) url += '&page=$page';

    final response = await client!.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load news');
    }
  }

  /// Fetches the available sources from the News API using the '/sources'
  /// endpoint.
  ///
  /// Accepts parameters to filter the sources:
  /// [category] - Find sources that display news of this category.
  /// [language] - Find sources that display news in a specific language.
  /// [country] - Find sources that display news in a specific country.
  Future<Map<String, dynamic>> fetchSources({
    String? category,
    String? language,
    String? country,
  }) async {
    if (category == null && language == null && country == null) {
      throw Exception(
          'You must provide at least one parameter to fetchSources');
    }
    String url = 'https://newsapi.org/v2/sources?apiKey=$apiKey';

    if (category != null) url += '&category=$category';
    if (language != null) url += '&language=$language';
    if (country != null) url += '&country=$country';

    final response = await client!.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load sources');
    }
  }
}

import 'package:news_api/news_api.dart';

Future<void> main() async {
  var newsApi = NewsApi('<your-api-key>');

  var topHeadlines = await newsApi.fetchTopHeadlines(country: 'us');
  print('Top Headlines: ${topHeadlines.articles.map((a) => a.title).toList()}');

  var everything = await newsApi.fetchEverything(
      q: 'bitcoin', from: '2023-05-15', sortBy: 'publishedAt');
  print('Everything: ${everything.articles.map((a) => a.title).toList()}');

  var sources = await newsApi.fetchSources(language: 'en', country: 'us');
  print('Sources: ${sources.map((s) => s.name).toList()}');
}

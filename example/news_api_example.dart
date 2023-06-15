import 'package:news_api/news_api.dart';

Future<void> main() async {
  var newsApi = NewsApi('<your-api-key>');
  var articles = await newsApi.fetchTopHeadlines('us');
  print('articles: $articles');
}
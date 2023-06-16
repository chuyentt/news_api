# News API Dart Package

The News API Dart package is a library for interacting with [NewsAPI.org](https://newsapi.org/). [NewsAPI.org](https://newsapi.org/) provides a service API that delivers news from various sources worldwide. With NewsAPI, you can filter news by keyword, source, language, and many other criteria. The news can also be sorted by publication time.

## Usage

```dart
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
```

Replace `<your-api-key>` with the API key you received from NewsAPI.org.

- The `fetchTopHeadlines()` function will return an ArticleResponse object containing news articles of the top headlines from NewsAPI.org.
- The `fetchEverything()` function will return an ArticleResponse object containing news articles that meet specified criteria from NewsAPI.org.
- The `fetchSources()` function will return a List of Source objects from NewsAPI.org based on specified language and country parameters.

### Testing

This package provides unit tests to ensure that the main functionalities work correctly. To run the tests, you can use the following command:

```bash
flutter test
```

### Suggestions & Bug Reporting

If you have any suggestions or encounter any bugs while using this package, do not hesitate to create an [issue tracker][tracker] on our GitHub page.

[tracker]: https://github.com/chuyentt/news_api/issues
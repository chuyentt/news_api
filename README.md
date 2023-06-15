# News API Dart Package

The News API Dart package is designed to interact with [NewsAPI.org](https://newsapi.org/). [NewsAPI.org](https://newsapi.org/) is a service API that allows developers to access news from sources around the globe. With NewsAPI, you can filter news by keyword, source, language, and many other criteria. You can also sort by published time.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  news_api: ^1.0.0
```

Run the following command to install the package:

```bash
flutter pub get
```

## Usage

```dart
import 'package:news_api/news_api.dart';

Future<void> main() async {
  var newsApi = NewsApi('<your-api-key>');
  var articles = await newsApi.fetchTopHeadlines(country: 'us');
  print('articles: $articles');
}
```

Where `<your-api-key>` is the API key you received from NewsAPI.org.

The `fetchTopHeadlines()` function will return a List of news articles in the form of dynamic data (`List<dynamic>`).

### Testing

This package provides unit tests to ensure that the main functionalities work correctly. To run the tests, you can use the following command:

```bash
flutter test
```

### Suggestions & Bug Reporting

If you have any suggestions or encounter any bugs while using this package, do not hesitate to create an [issue tracker][tracker] on our GitHub page.

[tracker]: https://github.com/chuyentt/news_api/issues
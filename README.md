# News API Dart Package

The News API Dart package is designed to interact with [NewsAPI.org](https://newsapi.org/). [NewsAPI.org](https://newsapi.org/) is a service API that allows developers to access news from sources around the globe. With NewsAPI, you can filter news by keyword, source, language, and many other criteria. You can also sort by published time.

## Installation

Depend on it

Run this command:

With Dart:

```
dart pub add news_api
```

With Flutter:

```
flutter pub add news_api
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
  
  var topHeadlines = await newsApi.fetchTopHeadlines(country: 'us');
  print('Top Headlines: $topHeadlines');

  var everything = await newsApi.fetchEverything(
      q: 'bitcoin', from: '2023-05-15', sortBy: 'publishedAt');
  print('Everything: $everything');

  var sources = await newsApi.fetchSources(language: 'en', country: 'us');
  print('Sources: $sources');
}
```

Where `<your-api-key>` is the API key you received from NewsAPI.org.

- The `fetchTopHeadlines()` function will return a Map containing news data in the form of dynamic data `(Map<String, dynamic>)` of the top headlines from NewsAPI.org.

- The `fetchEverything()` function will return a Map containing news data `(Map<String, dynamic>)` that meets specified criteria from NewsAPI.org.

- The `fetchSources()` function will return a Map containing source data `(Map<String, dynamic>)` from NewsAPI.org based on specified language and country parameters.

### Testing

This package provides unit tests to ensure that the main functionalities work correctly. To run the tests, you can use the following command:

```bash
flutter test
```

### Suggestions & Bug Reporting

If you have any suggestions or encounter any bugs while using this package, do not hesitate to create an [issue tracker][tracker] on our GitHub page.

[tracker]: https://github.com/chuyentt/news_api/issues
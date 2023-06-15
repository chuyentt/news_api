/// A Dart package to interact with NewsAPI.org.
///
/// This library provides a simple way to access the news data provided by
/// NewsAPI.org.
/// NewsAPI.org is a service API that allows developers to access news from
/// sources around the globe.
/// You can filter news by keyword, source, language, and many other criteria.
///
/// To use this package, you need to obtain an API key from NewsAPI.org.
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
///
/// [NewsAPI.org](https://newsapi.org/)
library news_api;

import 'dart:convert';

import 'package:http/http.dart' as http;

part 'src/news_api_base.dart';

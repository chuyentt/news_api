import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_api/news_api.dart';
import 'package:test/test.dart';

import 'news_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late String apiKey;
  late MockClient client;
  setUpAll(() {
    apiKey = '<your-api-key>';
    client = MockClient();
  });

  group('fetchTopHeadlines', () {
    test('returns a list of headlines if the http call completes successfully',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any)).thenAnswer((_) async => http.Response(
          '{"status": "ok", "articles":[{"author": 1, "id": 2, "title": "mock"}]}',
          200));
      expect(await newsApi.fetchTopHeadlines(country: 'us'),
          isA<Map<String, dynamic>>());
    });

    test('throws an exception if no parameters are passed', () async {
      final newsApi = NewsApi(apiKey, client: client);

      expect(() => newsApi.fetchTopHeadlines(), throwsA(isA<Exception>()));
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any))
          .thenAnswer((_) async => http.Response('Failed to load news', 404));

      expect(newsApi.fetchTopHeadlines(country: 'us'), throwsException);
    });
  });

  group('fetchEverything', () {
    test(
        'returns a list of articles if the http call completes successfully with at least one parameter',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any)).thenAnswer((_) async => http.Response(
          '{"articles":[{"userId": 1, "id": 2, "title": "mock"}]}', 200));

      expect(await newsApi.fetchEverything(q: 'bitcoin'),
          isA<Map<String, dynamic>>());
    });

    test('throws an exception if no parameters are passed', () async {
      final newsApi = NewsApi(apiKey, client: client);

      expect(() => newsApi.fetchEverything(), throwsA(isA<Exception>()));
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any))
          .thenAnswer((_) async => http.Response('Failed to load news', 404));

      expect(newsApi.fetchEverything(q: 'bitcoin'), throwsException);
    });
  });

  group('fetchSources', () {
    test(
        'returns a list of sources if the http call completes successfully with at least one parameter',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any)).thenAnswer((_) async => http.Response(
          '{"sources":[{"id": "abc-news", "name": "ABC News"}]}', 200));

      expect(await newsApi.fetchSources(category: 'general'),
          isA<Map<String, dynamic>>());
    });

    test('throws an exception if no parameters are passed', () async {
      final newsApi = NewsApi(apiKey, client: client);

      expect(() => newsApi.fetchSources(), throwsA(isA<Exception>()));
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any)).thenAnswer(
          (_) async => http.Response('Failed to load sources', 404));

      expect(newsApi.fetchSources(category: 'general'), throwsException);
    });
  });
}

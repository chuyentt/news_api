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
  late String mockJsonResponse;
  late String mockJsonSources;
  setUpAll(() {
    apiKey = '<your-api-key>';
    client = MockClient();
    mockJsonResponse = '''
    {
      "status": "ok",
      "articles": [
        {
          "source": {
            "id": "abc-news",
            "name": "ABC News",
            "description": "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
            "url": "https://abcnews.go.com",
            "category": "general",
            "language": "en",
            "country": "us"
          },
          "author": "ABC News",
          "title": "Mock News Title",
          "description": "This is a description of the mock news article.",
          "url": "https://abcnews.go.com/US/wireStory?id=46882759",
          "urlToImage": "https://abcnews.go.com/images/US/WireAP_5eb2a7638a4a45eeb8b0a6b0a6a461e1_16x9_992.jpg",
          "publishedAt": "2023-06-15T13:00:00Z",
          "content": "This is the content of the mock news article."
        }
      ]
    }''';

    mockJsonSources = '''
    {
      "status": "ok",
      "sources": [
        {
          "id": "abc-news",
          "name": "ABC News",
          "description": "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
          "url": "https://abcnews.go.com",
          "category": "general",
          "language": "en",
          "country": "us"
        }
      ]
    }
    ''';
  });

  group('fetchTopHeadlines', () {
    test(
        'should return a map of headlines when the http call completes successfully',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any))
          .thenAnswer((_) async => http.Response(mockJsonResponse, 200));
      expect(await newsApi.fetchTopHeadlines(country: 'us'),
          isA<ArticleResponse>());
    });

    test('should throw an exception when no parameters are passed', () async {
      final newsApi = NewsApi(apiKey, client: client);

      expect(() => newsApi.fetchTopHeadlines(), throwsA(isA<Exception>()));
    });

    test('should throw an exception when the http call completes with an error',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any))
          .thenAnswer((_) async => http.Response('Failed to load news', 404));

      expect(newsApi.fetchTopHeadlines(country: 'us'), throwsException);
    });
  });

  group('fetchEverything', () {
    test(
        'should return a map of articles when the http call completes successfully with at least one parameter',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any))
          .thenAnswer((_) async => http.Response(mockJsonResponse, 200));

      expect(
          await newsApi.fetchEverything(q: 'bitcoin'), isA<ArticleResponse>());
    });

    test('should throw an exception when no parameters are passed', () async {
      final newsApi = NewsApi(apiKey, client: client);

      expect(() => newsApi.fetchEverything(), throwsA(isA<Exception>()));
    });

    test('should throw an exception when the http call completes with an error',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any))
          .thenAnswer((_) async => http.Response('Failed to load news', 404));

      expect(newsApi.fetchEverything(q: 'bitcoin'), throwsException);
    });
  });

  group('fetchSources', () {
    test(
        'should return a map of sources when the http call completes successfully with at least one parameter',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any))
          .thenAnswer((_) async => http.Response(mockJsonSources, 200));

      expect(
          await newsApi.fetchSources(category: 'general'), isA<List<Source>>());
    });

    test('should throw an exception when no parameters are passed', () async {
      final newsApi = NewsApi(apiKey, client: client);

      expect(() => newsApi.fetchSources(), throwsA(isA<Exception>()));
    });

    test('should throw an exception when the http call completes with an error',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any)).thenAnswer(
          (_) async => http.Response('Failed to load sources', 404));

      expect(newsApi.fetchSources(category: 'general'), throwsException);
    });
  });
}

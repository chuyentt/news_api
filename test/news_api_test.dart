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

  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any)).thenAnswer((_) async => http.Response(
          '{"articles":[{"userId": 1, "id": 2, "title": "mock"}]}', 200));

      expect(
          await newsApi.fetchTopHeadlines(country: 'us'), isA<List<dynamic>>());
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final newsApi = NewsApi(apiKey, client: client);

      when(client.get(any))
          .thenAnswer((_) async => http.Response('Failed to load news', 404));

      expect(newsApi.fetchTopHeadlines(country: 'us'), throwsException);
    });
  });
}

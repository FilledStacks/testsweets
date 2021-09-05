import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

abstract class HttpService {
  /// Makes a PUT request to the endpoint given by [to].
  Future<SimpleHttpResponse> putBinary(
      {required String to,
      required Stream<List<int>> data,
      required int contentLength,
      Map<String, String>? headers});

  Future<SimpleHttpResponse> postJson(
      {required String to,
      required Map<String, dynamic> body,
      Map<String, String>? headers});

  Future<SimpleHttpResponse> get(
      {required String to, Map<String, String>? headers});
}

class SimpleHttpResponse {
  final int statusCode;
  final String body;
  SimpleHttpResponse(this.statusCode, this.body);

  Map<String, dynamic> parseBodyAsJsonMap() {
    return json.decode(body) as Map<String, dynamic>;
  }
}

class HttpServiceImplementation implements HttpService {
  @override
  Future<SimpleHttpResponse> putBinary(
      {required String to,
      required Stream<List<int>> data,
      required int contentLength,
      Map<String, String>? headers}) async {
    headers = headers ?? <String, String>{};

    final request = await HttpClient().putUrl(Uri.parse(to));
    headers.forEach((key, value) => request.headers.set(key, value));

    print('');

    int numberOfBytesWritten = 0;
    Stopwatch counter = Stopwatch();
    final response = await data.map((chunk) {
      counter.start();

      numberOfBytesWritten += chunk.length;

      if (counter.elapsed > Duration(seconds: 1)) {
        counter.reset();
        //remove old progress print to the console
        stdout.write("\r\x1b[K");
        var progress = ((numberOfBytesWritten / contentLength) * 100).ceil();
        stdout.write("Uploaded $progress% of $contentLength ...");
      }

      return chunk;
    }).pipe(StreamConsumerWithCallbacks(request, onFinalise: () {
      print('Finalising upload...');
    }));

    return SimpleHttpResponse(
        response.statusCode, await response.transform(utf8.decoder).join());
  }

  @override
  Future<SimpleHttpResponse> postJson(
      {required String to,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    headers = headers ?? <String, String>{};
    headers.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json');
    final response = await http.post(
      Uri.parse(to),
      body: json.encode(body),
      headers: headers,
    );

    print(
        'postJson | response - statuscode:${response.statusCode} body:${response.body} headers:${response.headers}');

    return SimpleHttpResponse(response.statusCode, response.body);
  }

  @override
  Future<SimpleHttpResponse> get(
      {required String to, Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(to), headers: headers);

    return SimpleHttpResponse(response.statusCode, response.body);
  }
}

class StreamConsumerWithCallbacks implements StreamConsumer<List<int>> {
  final void Function() onFinalise;
  final StreamConsumer relayTo;
  StreamConsumerWithCallbacks(this.relayTo, {required this.onFinalise});

  @override
  Future addStream(Stream stream) {
    return relayTo.addStream(stream);
  }

  @override
  Future close() {
    onFinalise();
    return relayTo.close();
  }
}

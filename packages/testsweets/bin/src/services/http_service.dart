import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

abstract class HttpService {
  /// Makes a PUT request to the endpoint given by [to].
  Future<SimpleHttpResponse> putBinary(
      {@required String to,
      @required Uint8List data,
      Map<String, String> headers});

  Future<SimpleHttpResponse> postJson(
      {@required String to, @required Map<String, dynamic> body, headers});

  factory HttpService.makeInstance() {
    return _HttpService();
  }
}

class SimpleHttpResponse {
  final int statusCode;
  final String body;
  SimpleHttpResponse(this.statusCode, this.body);

  Map<String, dynamic> parseBodyAsJsonMap() {
    return json.decode(body) as Map;
  }
}

class _HttpService implements HttpService {
  @override
  Future<SimpleHttpResponse> putBinary(
      {String to, Uint8List data, Map<String, String> headers}) async {
    headers = headers ?? Map<String, String>();
    headers.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/octet-stream');

    final client = HttpClient();
    final request = await client.putUrl(Uri.parse(to));
    headers.forEach((key, value) => request.headers.add(key, value));

    int numberOfBytesWritten = 0;
    Stopwatch counter = Stopwatch();
    data.forEach((byte) {
      counter.start();

      numberOfBytesWritten++;
      request.add([byte]);

      if (counter.elapsed > Duration(seconds: 1)) {
        counter.reset();
        print(
            "Uploaded ${(numberOfBytesWritten / data.length * 100).ceil()}% of ${data.length}");
      }
    });

    final response = await request.close();

    return SimpleHttpResponse(
        response.statusCode, await response.transform(utf8.decoder).join());
  }

  @override
  Future<SimpleHttpResponse> postJson(
      {String to, Map<String, dynamic> body, headers}) async {
    headers = headers ?? Map<String, String>();
    headers.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json');
    final response =
        await http.put(to, body: json.encode(body), headers: headers);

    return SimpleHttpResponse(response.statusCode, response.body);
  }
}

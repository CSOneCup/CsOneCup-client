import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _BASE_URL = "http://141.164.52.130:8082";
  Map<String, String>? _defaultHeader;

  ApiService({Map<String, String>? defaultHeader}):
  _defaultHeader = defaultHeader;

  /// 주어진 파라미터로 GET 전송 + data 필드에 fromJson 매핑하여 반환
  Future<T> get<T>(String endpoint, {Map<String, String>? headers, required T Function(dynamic) fromJson}) async {
    print("ApiService: GET to '$_BASE_URL/$endpoint");
    final response = await http.get(Uri.parse('$_BASE_URL/$endpoint'), headers: headers);
    String body = utf8.decode(response.bodyBytes);
    print("ApiService: GET /$endpoint received ${body}");
    if (response.statusCode == 200) {
      return fromJson(jsonDecode(body)['data']);
    } else {
      throw Exception('Failed to load data: ${body}');
    }
  }

  /// 주어진 파라미터로 POST 전송 + data 필드에 fromJson 매핑하여 반환
  Future<T> post<T>(String endpoint, {Map<String, dynamic>? requestBody, Map<String, String>? headers, required T Function(dynamic) fromJson}) async {
    print("ApiService: POST to '$_BASE_URL/$endpoint' with body=$requestBody");
    headers = {
      'Content-Type' : 'application/json',
      ...?_defaultHeader,
      ...?headers
    };
    final response = await http.post(
      Uri.parse('$_BASE_URL/$endpoint'),
      headers: headers,
      body: requestBody != null ? jsonEncode(requestBody) : null,
    );
    String decodedBody = utf8.decode(response.bodyBytes);
    print("ApiService: POST /$endpoint received $decodedBody");
    if (response.statusCode == 200) {
      return fromJson(jsonDecode(decodedBody)['data']);
    } else {
      throw Exception('Failed to post data: $decodedBody');
    }
  }
}

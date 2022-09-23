import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint('Request');
    debugPrint('url: ${data.url}');
    debugPrint('headers: ${data.headers}');
    debugPrint('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('Response');
    debugPrint('status code ${data.statusCode}');
    debugPrint('headers: ${data.headers}');
    debugPrint('body: ${data.body}');
    return data;
  }

  Future<void> findAll() async {
    try {
      final Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
      // ignore: unused_local_variable
      final Response response = await client.get(Uri.parse('http://192.168.15.76:8080/transactions'));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

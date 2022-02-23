import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/get/get_connect/http/src/request/request.dart';
import 'package:paakaar/Utils/Api/web_controllers.dart';

abstract class RequestsUtil extends GetConnect {
  static late String baseRequestUrl;
  static String? token;

  static bool debug = true;

  @override
  void onInit() {
    assert(
      baseRequestUrl == null,
      "baseRequestUrl should be initialized in 'main()'",
    );
    assert(
      token == null,
      "token should be initialized in 'main()'",
    );
    httpClient.addRequestModifier((Request request) async {
      request.headers['token'] = RequestsUtil.token!;
      return request;
    });

    this.baseUrl = baseRequestUrl;
    super.onInit();
  }

  Future<ApiResult> makeRequest({
    required WebControllers webController,
    required String webMethod,
    Map<String, dynamic> body = const {},
    File? files ,
  }) async {
    String url = _makePath(webController, webMethod);
    if (debug) {
      print("Request url: $url\nRequest body: ${jsonEncode(body)}\n");
    }
    FormData formData = FormData(body);

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['token'] = RequestsUtil.token!;
    Map<String,String> bodyData = {};
    body.forEach((key, value) {
      bodyData[key] = value.toString();
    });
    request.fields.addAll(bodyData);
    if (files is File) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          files.path,
        ),
      );
    }

    http.StreamedResponse response1 = await request.send();
    var response = await http.Response.fromStream(response1);
    // Response response = await post(
    //   url,
    //   formData,
    //   headers: {
    //     'token': RequestsUtil.token!,
    //   },
    // );
    ApiResult apiResult = new ApiResult();
    print(response.body);
    if (response.statusCode == 200) {
      try {
        if (debug) {
          print(response.body);
        }
        Map data = jsonDecode(response.body);
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = false;
    }
    if (debug) {
      print(
          "\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
          "status: ${response.statusCode}\n"
          "isDone: ${apiResult.isDone}\n"
          "requestedMethod: ${apiResult.requestedMethod}\n"
          "data: ${apiResult.data}"
          "}");
    }
    return apiResult;
  }

  String _makePath(WebControllers webController, String webMethod) {
    return "${RequestsUtil.baseRequestUrl}/${webController.toString().split('.').last}/API/${'_${webMethod.toString()}'}?token=${RequestsUtil.token}";
  }
}

class ApiResult {
  late bool isDone;
  String? requestedMethod;
  dynamic data;

  ApiResult({
    this.isDone = false,
    this.requestedMethod,
    this.data,
  });
}

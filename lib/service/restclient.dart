import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobex_go/model/api_response.dart';
import 'package:mobex_go/utils/vars.dart';
import 'network_service_response.dart';

class RestClient {
  Future<MappedNetworkServiceResponse<T>> get<T>(String url, Map headers) async{
    try {
      var response = await http.get(url, headers: headers);
      return processResponse<T>(response);
    }
    catch(e) {
      return new MappedNetworkServiceResponse<T>(
          networkServiceResponse: new NetworkServiceResponse<T>(
              responseCode: 0,
              errorMessage: e.toString().contains('SocketException') ? 'No internet' : e.toString()));
    }
  }

  post<T>(String url, {Map headers, body, encoding}) async{
    try {
      var response = await http.post(url, headers: headers, body: body, encoding: encoding);
      return processResponse<T>(response);
    }
    catch(e) {
      return new MappedNetworkServiceResponse<T>(
          networkServiceResponse: new NetworkServiceResponse<T>(
              responseCode: 0,
              errorMessage:  e.toString().contains('SocketException') ? 'No internet' : e.toString()
              ));
    }
  }

  processResponse<T>(http.Response response) {
    if (response.statusCode > ok200) {
      return new MappedNetworkServiceResponse<T>(
          networkServiceResponse: new NetworkServiceResponse<T>(
              errorMessage: ApiResponse.fromJson(json.decode(response.body)).responseMessage,
              responseCode: response.statusCode));
    } else {
      return new MappedNetworkServiceResponse<T>(
          mappedResult: response.body,
          networkServiceResponse: NetworkServiceResponse<T>(responseCode: response.statusCode));
    }
  }
}

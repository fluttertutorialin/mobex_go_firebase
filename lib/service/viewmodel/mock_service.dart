import 'dart:async';
import 'package:mobex_go/model/api_response.dart';
import 'package:mobex_go/model/asc/asc_response.dart';
import 'package:mobex_go/model/assignascho/assign_asc_ho_response.dart';
import 'package:mobex_go/model/dispatch/dispatch_response.dart';
import 'package:mobex_go/model/login/login_response.dart';
import 'package:mobex_go/model/pickup/pickup_response.dart';
import 'package:mobex_go/model/postpone/postpone_response.dart';
import 'package:mobex_go/model/reason/reason.dart';
import 'package:mobex_go/service/abstract/api_service.dart';
import 'package:mobex_go/service/viewmodel/api_view_model.dart';
import 'package:mobex_go/utils/vars.dart';
import '../network_service_response.dart';

class MockService implements APIService {
  @override
  login(String mobile, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200,
        response: LoginResponse(
          empId: 00001,
          empName: 'Admin',
          empMobile: '0000000000',
          message: '',
        ),
        errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<List<PickUpResponse>>> pickUp(String userId) async{
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200, response: getPickUp(), errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<List<ReasonResponse>>>
  postPonCancelReasonList() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200,
        response: getReasonPostPoneCancel(),
        errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse> postPoneCancelReason(
      Map<String, dynamic> body, String title, String reasonName) async{
    await Future.delayed(Duration(seconds: 1));
    return Future.value(
        NetworkServiceResponse(responseCode: ok200, errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<List<AssignAscHoResponse>>> assignAscHo(
      String userId) async{
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200, response: getAscHo(), errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<AscResponse>> getAsc(String jobId) {
    return Future.value(NetworkServiceResponse(
        responseCode: ok200,
        response:
        AscResponse(ascList: getAscList(), problemList: getAscProblem()),
        errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<ApiResponse>> submitAsc(
      Map<String, dynamic> param) async{
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200,
        response: ApiResponse(
            responseCode: '1', responseMessage: 'ASC submit successful'),
        errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<ApiResponse>> createEstimate(
      String jsonString) async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200,
        response: ApiResponse(
            responseCode: '1', responseMessage: 'Create estimate successful'),
        errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<ApiResponse>> submitApprove(
      Map<String, dynamic> param) async{
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200,
        response: ApiResponse(
            responseCode: '1', responseMessage: 'Receive the mobile successful'),
        errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<List<DispatchResponse>>> dispatch(
      String userId) async{
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200, response: getDispatch(), errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<List<ReasonResponse>>> undeliveredReason() {
    return Future.value(NetworkServiceResponse(
        responseCode: ok200,
        response: getReasonUndelivered(),
        errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<List<PostPoneResponse>>> postpone(
      String userId) async{
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200, response: getPostPone(), errorMessage: ''));
  }

  @override
  Future<NetworkServiceResponse<ApiResponse>> submitHo(
      String userId, String jobId) async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(NetworkServiceResponse(
        responseCode: ok200,
        response: ApiResponse(responseCode: '1', responseMessage: ''),
        errorMessage: ''));
  }
}

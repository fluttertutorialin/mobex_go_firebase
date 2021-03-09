import 'dart:convert';
import 'package:mobex_go/model/api_response.dart';
import 'package:mobex_go/model/asc/asc_response.dart';
import 'package:mobex_go/model/assignascho/assign_asc_ho_response.dart';
import 'package:mobex_go/model/dispatch/dispatch_response.dart';
import 'package:mobex_go/model/login/login_response.dart';
import 'package:mobex_go/model/pickup/pickup_response.dart';
import 'package:mobex_go/model/postpone/postpone_response.dart';
import 'package:mobex_go/model/reason/reason.dart';
import 'package:mobex_go/service/abstract/api_service.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:query_params/query_params.dart';
import '../network_service_response.dart';
import '../network_type.dart';
import '../restclient.dart';

class NetworkService extends NetworkType implements APIService {
  static final _baseUrl = '';
  final _loginUrl = _baseUrl + '';

  //PICKUP - POSTPONE - DISPATCH LIST
  final _pickUpAssignListUrl = _baseUrl + '';
  final _postPoneAssignListUrl = _baseUrl + '';
  final _dispatchAssignListUrl = _baseUrl + '';

  //PICKUP - DISPATCH UNDELIVERED REASON LIST
  final _postPoneCancelReasonListUrl = _baseUrl + '';
  final _dispatchUndeliveredReasonListUrl =
      _baseUrl + '';

  //PICKUP CANCEL - DISPATCH RETURN
  final _pickUpCancelReasonUrl = _baseUrl + '';
  final _dispatchUndeliveredReasonUrl = _baseUrl + "";

  //PICKUP - DISPATCH DONE
  final _pickUpDoneUrl = _baseUrl + '';
  final _dispatchDoneUrl = _baseUrl + '';

  //PICKUP - DISPATCH POSTPONE
  final _pickUpPostPoneReasonUrl = _baseUrl + '';
  final _dispatchPostPoneReasonUrl = _baseUrl + '';

  //DASHBOARD
  //final _dashboardDataDispatch = _baseUrl + '/api/SelectDashboardDataDispatch';
  //final _dashboardDataPickUp = _baseUrl + '/api/SelectDashboardDataPickup';

  //TODO PICKUP MOBILE AFTER PROCESSING ASC - HO
  final _getAsc = _baseUrl + '';
  final _assignToAscHo = _baseUrl + '';

  final _submitHo = _baseUrl + '';
  final _insertAsc = _baseUrl + '';
  final _estimateEntry = _baseUrl + '';
  final _updateAscDetail = _baseUrl + '';

  var headers = {
    "Content-Type": 'application/json',
    "AUTH_KEY": '',
  };

  NetworkService(RestClient rest) : super(rest);

  @override
  Future login(String mobile, String password) async {
    var result = await rest.get<LoginResponse>(
        '$_loginUrl?$mobileNoParam=$mobile&$passwordParam=$password&$deviceIdParam=""',
        headers);
    if (result.networkServiceResponse.responseCode == ok200) {
      var res = LoginResponse.fromJson(json.decode(result.mappedResult));
      return new NetworkServiceResponse(
        response: res,
        responseCode: result.networkServiceResponse.responseCode,
      );
    }

    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
}

  @override
  Future<NetworkServiceResponse<List<PickUpResponse>>> pickUp(String userId) async {
    var result = await rest.get<PickUpResponse>(
        '$_pickUpAssignListUrl?$empIdParam=$userId', headers);
    if (result.networkServiceResponse.responseCode == ok200) {
      List<PickUpResponse> list = (json.decode(result.mappedResult) as List)
          .map((data) => new PickUpResponse.fromJson(data))
          .toList();
      return new NetworkServiceResponse(
        response: list,
        responseCode: result.networkServiceResponse.responseCode,
      );
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse<List<DispatchResponse>>> dispatch(
      String userId) async {
    var result = await rest.get<DispatchResponse>(
        '$_dispatchAssignListUrl?EMPID=$userId', headers);
    if (result.networkServiceResponse.responseCode == ok200) {
      List<DispatchResponse> list = (json.decode(result.mappedResult) as List)
          .map((data) => new DispatchResponse.fromJson(data))
          .toList();
      return new NetworkServiceResponse(
        response: list,
        responseCode: result.networkServiceResponse.responseCode,
      );
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse<List<ReasonResponse>>> undeliveredReason() async {
    var result = await rest.get<ReasonResponse>(
        '$_dispatchUndeliveredReasonListUrl', headers);
    if (result.networkServiceResponse.responseCode == ok200) {
      List<ReasonResponse> list = (json.decode(result.mappedResult) as List)
          .map((data) => new ReasonResponse.fromJson(data))
          .toList();
      return new NetworkServiceResponse(
        response: list,
        responseCode: result.networkServiceResponse.responseCode
      );
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse<List<ReasonResponse>>>
      postPonCancelReasonList() async {
    var result = await rest.get<ReasonResponse>(
        '$_postPoneCancelReasonListUrl', headers);
    if (result.networkServiceResponse.responseCode == ok200) {
      List<ReasonResponse> list = (json.decode(result.mappedResult) as List)
          .map((data) => new ReasonResponse.fromJson(data))
          .toList();
      return new NetworkServiceResponse(
        response: list,
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage,
      );
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse> postPoneCancelReason(
      Map<String, dynamic> postPoneCancelReasonBody,
      String title,
      String reasonName) async {
    var result;

    //PICKUP DONE
    if (title == tabPickUp && reasonName == btnDone) {
      result = await rest.post<ReasonResponse>('$_pickUpDoneUrl',
          headers: headers, body: json.encode(postPoneCancelReasonBody));
    }

    //PICKUP POSTPONE
    else if (title == tabPickUp && reasonName == btnPostpone) {
      result = await rest.post<ReasonResponse>('$_pickUpPostPoneReasonUrl',
          headers: headers, body: json.encode(postPoneCancelReasonBody));
    }

    //PICKUP CANCEL
    else if (title == tabPickUp && reasonName == btnCancel) {
      result = await rest.post<ReasonResponse>('$_pickUpCancelReasonUrl' + "TEMPRSN=" + postPoneCancelReasonBody['POSTPONDRSN'] + "&" + "INQUIRYNO=" + postPoneCancelReasonBody['INQUIRYNO'], headers: headers);
    }

    //DISPATCH DONE
    else if (title == tabDispatch && reasonName == btnDone) {
      result = await rest.post<ReasonResponse>('$_dispatchDoneUrl',
          headers: headers, body: json.encode(postPoneCancelReasonBody));
    }

    //DISPATCH POSTPONE
    else if (title == tabDispatch && reasonName == btnPostpone) {
      result = await rest.post<ReasonResponse>('$_dispatchPostPoneReasonUrl',
          headers: headers, body: json.encode(postPoneCancelReasonBody));
    }

    //DISPATCH UNDELIVERED
    else if (title == tabDispatch && reasonName == btnUndelivered) {
      result = await rest.post<ReasonResponse>(
          '$_dispatchUndeliveredReasonUrl' +
              "RETURNREASON=" +
              postPoneCancelReasonBody['RETURNREASON'] +
              "&" +
              "JOBNO=" +
              postPoneCancelReasonBody['JOBNO'],
          headers: headers);
    }

    if (result.networkServiceResponse.responseCode == ok200) {
      return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage,
      );
    }

    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse<List<AssignAscHoResponse>>> assignAscHo(
      String userId) async {
    URLQueryParams queryParams = new URLQueryParams();
    queryParams.append(empIdParam, userId);

    var result = await rest.get<AssignAscHoResponse>(
        '$_assignToAscHo?$queryParams', headers);
    if (result.networkServiceResponse.responseCode == ok200) {
      List<AssignAscHoResponse> list =
          (json.decode(result.mappedResult) as List)
              .map((data) => new AssignAscHoResponse.fromJson(data))
              .toList();
      return new NetworkServiceResponse(
          response: list,
          responseCode: result.networkServiceResponse.responseCode);
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse<AscResponse>> getAsc(String jobId) async {
    URLQueryParams queryParams = new URLQueryParams();
    queryParams.append(jobIdParam, jobId);

    var result = await rest.get<AscResponse>('$_getAsc?$queryParams', headers);
    if (result.networkServiceResponse.responseCode == ok200) {
      var res = AscResponse.fromJson(json.decode(result.mappedResult));
      return new NetworkServiceResponse(
          response: res,
          responseCode: result.networkServiceResponse.responseCode);
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse<ApiResponse>> submitAsc(
      Map<String, dynamic> param) async {
    var result = await rest.post<ApiResponse>('$_insertAsc',
        body: json.encode(param), headers: headers);
    if (result.mappedResult != null) {
      var res = ApiResponse.fromJson(json.decode(result.mappedResult));
      return new NetworkServiceResponse(
          response: res,
          responseCode: result.networkServiceResponse.responseCode);
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse<ApiResponse>> createEstimate(
      String jsonString) async {
    var result = await rest.post<ApiResponse>('$_estimateEntry',
        body: jsonString, headers: headers);
    if (result.mappedResult != null) {
      var res = ApiResponse.fromJson(json.decode(result.mappedResult));
      return new NetworkServiceResponse(
        response: res,
        responseCode: result.networkServiceResponse.responseCode,
      );
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse<ApiResponse>> submitApprove(
      Map<String, dynamic> param) async {
    var result = await rest.post<ApiResponse>('$_updateAscDetail',
        body: json.encode(param), headers: headers);
    if (result.mappedResult != null) {
      var res = ApiResponse.fromJson(json.decode(result.mappedResult));
      return new NetworkServiceResponse(
          response: res,
          responseCode: result.networkServiceResponse.responseCode);
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse<List<PostPoneResponse>>> postpone(String userId) async{
    var result = await rest.get<DispatchResponse>(
        '$_postPoneAssignListUrl?EMPID=$userId', headers);
    if (result.networkServiceResponse.responseCode == ok200) {
      List<PostPoneResponse> list = (json.decode(result.mappedResult) as List)
          .map((data) => new PostPoneResponse.fromJson(data))
          .toList();
      return new NetworkServiceResponse(
        response: list,
        responseCode: result.networkServiceResponse.responseCode
      );
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }

  @override
  Future<NetworkServiceResponse<ApiResponse>> submitHo(String userId, String jobId) async {
    var result = await rest.post<ApiResponse>('$_submitHo?JOBID=$jobId&BIKERID=$userId',
        headers: headers);
    if (result.mappedResult != null) {
      var res = ApiResponse.fromJson(json.decode(result.mappedResult));
      return new NetworkServiceResponse(
        response: res,
        responseCode: result.networkServiceResponse.responseCode
      );
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        errorMessage: result.networkServiceResponse.errorMessage);
  }
}

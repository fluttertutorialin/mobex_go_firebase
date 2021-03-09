import 'package:mobex_go/model/api_response.dart';
import 'package:mobex_go/model/asc/asc_response.dart';
import 'package:mobex_go/model/assignascho/assign_asc_ho_response.dart';
import 'package:mobex_go/model/dispatch/dispatch_response.dart';
import 'package:mobex_go/model/postpone/postpone_response.dart';
import 'package:mobex_go/model/reason/reason.dart';
import 'package:mobex_go/service/abstract/api_service.dart';
import 'package:mobex_go/service/di/dependency_injection.dart';
import '../network_service_response.dart';

class ApiProvider {
  NetworkServiceResponse apiResult;
  APIService apiService = new Injector().flavor;

  getLogin(String mobile, String password) async {
    NetworkServiceResponse result = await apiService.login(mobile, password);
    this.apiResult = result;
  }

  getPickUp(String userId) async {
    NetworkServiceResponse result = await apiService.pickUp(userId);
    this.apiResult = result;
  }

  getDispatch(String userId) async {
    NetworkServiceResponse<List<DispatchResponse>> result = await apiService.dispatch(userId);
    this.apiResult = result;
  }

  getUndeliveredReason() async {
    NetworkServiceResponse<List<ReasonResponse>> result =
    await apiService.undeliveredReason();
    this.apiResult = result;
  }

  Future getPostPonCancelReasonList() async {
    NetworkServiceResponse<List<ReasonResponse>> result =
    await apiService.postPonCancelReasonList();
    this.apiResult = result;
  }

  Future getPostPone(String userId) async {
    NetworkServiceResponse<List<PostPoneResponse>> result =
    await apiService.postpone(userId);
    this.apiResult = result;
  }

  Future getPostPoneCancelReason(Map<String, dynamic> body, String title, String reasonName) async {
    NetworkServiceResponse result = await apiService.postPoneCancelReason(body, title, reasonName);
    this.apiResult = result;
  }

  Future getAssignToAscHo(String userId) async {
    NetworkServiceResponse<List<AssignAscHoResponse>> result =
    await apiService.assignAscHo(userId);
    this.apiResult = result;
  }

  Future getAsc(String jobId) async {
    NetworkServiceResponse<AscResponse> result = await apiService.getAsc(jobId);
    this.apiResult = result;
  }

  Future submitAsc(Map<String, dynamic> param) async {
    NetworkServiceResponse<ApiResponse> result = await apiService.submitAsc(param);
    this.apiResult = result;
  }

  Future createEstimate(String jsonString) async {
    NetworkServiceResponse<ApiResponse> result = await apiService.createEstimate(jsonString);
    this.apiResult = result;
  }

  Future submitApprove(Map<String, dynamic> param) async {
    NetworkServiceResponse<ApiResponse> result = await apiService.submitApprove(param);
    this.apiResult = result;
  }

  Future submitHo(String userId, String jobId) async {
    NetworkServiceResponse<ApiResponse> result = await apiService.submitHo(userId, jobId);
    this.apiResult = result;
  }
}

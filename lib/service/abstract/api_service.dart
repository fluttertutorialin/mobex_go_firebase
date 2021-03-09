import 'package:mobex_go/model/api_response.dart';
import 'package:mobex_go/model/asc/asc_response.dart';
import 'package:mobex_go/model/assignascho/assign_asc_ho_response.dart';
import 'package:mobex_go/model/dispatch/dispatch_response.dart';
import 'package:mobex_go/model/pickup/pickup_response.dart';
import 'package:mobex_go/model/postpone/postpone_response.dart';
import 'package:mobex_go/model/reason/reason.dart';
import '../network_service_response.dart';

abstract class APIService {
  login(String mobile, String password);
  Future<NetworkServiceResponse<List<PickUpResponse>>> pickUp(String userId);
  Future<NetworkServiceResponse<List<DispatchResponse>>> dispatch(String userId);
  Future<NetworkServiceResponse<List<PostPoneResponse>>> postpone(String userId);
  Future<NetworkServiceResponse<List<ReasonResponse>>> undeliveredReason();
  Future<NetworkServiceResponse<List<ReasonResponse>>> postPonCancelReasonList();
  Future<NetworkServiceResponse> postPoneCancelReason(Map<String, dynamic> body, String title, String reasonName);

  Future<NetworkServiceResponse<List<AssignAscHoResponse>>> assignAscHo(String userId);
  Future<NetworkServiceResponse<AscResponse>> getAsc(String jobId);
  Future<NetworkServiceResponse<ApiResponse>> submitAsc(Map<String, dynamic> param);
  Future<NetworkServiceResponse<ApiResponse>> createEstimate(String jsonString);
  Future<NetworkServiceResponse<ApiResponse>> submitApprove(Map<String, dynamic> param);
  Future<NetworkServiceResponse<ApiResponse>> submitHo(String userId, String jobId);

}

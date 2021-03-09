import 'package:bloc/bloc.dart';
import 'package:mobex_go/model/asc/problem_list.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'asc_event.dart';
import 'asc_state.dart';

class AscBloc extends Bloc<AscEvent, AscState> {
  final ApiProvider apiProvider = ApiProvider();
  double estimateId;
  String estimateValue;

  @override
  AscState get initialState => AscState.initial();

  void asc(jobId) {
    dispatch(JobIdParam(jobIdParam: jobId));
    dispatch(Asc());
  }

  void totalEstimate(double estimateId, String estimateValue) {
    this.estimateId = estimateId;
    this.estimateValue = estimateValue;
    dispatch(TotalEstimate());
  }

  @override
  Stream<AscState> mapEventToState(AscEvent event) async* {
    if (event is JobIdParam) {
      yield currentState.copyWith(jobId: event.jobIdParam);
    }

    if (event is TotalEstimate) {
      double totalAmount = 0.0;
      bool isCheckServiceCharge;

      int id = currentState.problemList.indexWhere((item) => item.id == estimateId);
      currentState.problemList[id].enterValue = estimateValue;

      for (ProblemListResponse problem in currentState.problemList) {
        if (problem.problemName.toLowerCase() ==
            'SERVICE CHARGES'.toLowerCase()) {
          if (problem.enterValue.isEmpty) {
            isCheckServiceCharge = false;
          } else {
            isCheckServiceCharge = true;
          }
        }

        if (problem.problemName.toLowerCase() == 'PCB'.toLowerCase()) {
          if (problem.enterValue.isEmpty) {
            currentState.selectPcbSubPcb.remove(problem.problemName);
          } else {
            if (!currentState.selectPcbSubPcb.contains(problem.problemName)) {
              currentState.selectPcbSubPcb.add(problem.problemName);
            }
          }
        }

        if (problem.problemName.toLowerCase() == 'SUB PCB'.toLowerCase()) {
          if (problem.enterValue.isEmpty) {
            currentState.selectPcbSubPcb.remove(problem.problemName);
          } else {
            if (!currentState.selectPcbSubPcb.contains(problem.problemName)) {
              currentState.selectPcbSubPcb.add(problem.problemName);
            }
          }
        }

        if (problem.enterValue.isNotEmpty) {
          totalAmount += double.parse(problem.enterValue);
        }
      }

      yield currentState.copyWith(
          mustServiceCharge: isCheckServiceCharge,
          problemList: currentState.problemList,
          totalEstimate: totalAmount,
          selectPcbSubPcb: currentState.selectPcbSubPcb);
    }

    if (event is Asc) {
      yield currentState.copyWith(
          mustServiceCharge: false,
          totalEstimate: 0.0,
          selectPcbSubPcb: List(),
          ascList: List(),
          errorMessage: '',
          problemList: List(),
          loading: true);
      await apiProvider.getAsc(currentState.jobId);

      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult.response;
          yield currentState.copyWith(
              loading: false,
              errorMessage: '',
              ascList: response.ascList,
              problemList: response.problemList);
        } else {
          yield currentState.copyWith(
            loading: false,
            errorMessage: apiProvider.apiResult.errorMessage
          );
        }
      } catch (e) {
        yield currentState.copyWith(
          loading: false,
          errorMessage: e.toString()
        );
        event.callback('Error, Something bad happened.');
      }
    }
  }
}

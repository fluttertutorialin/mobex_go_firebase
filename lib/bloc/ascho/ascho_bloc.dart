import 'package:mobex_go/model/assignascho/assign_asc_ho_response.dart';
import 'package:bloc/bloc.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'ascho_event.dart';
import 'ascho_state.dart';

class AscHoBloc extends Bloc<AscHoEvent, AscHoState> {
  final ApiProvider apiProvider = ApiProvider();
  AssignAscHoResponse assignAscHo;
  String status, estimate;
  var response;

  @override
  AscHoState get initialState => AscHoState.initial();

  void ascHo(userId) {
    dispatch(UserIdParam(userIdParam: userId));
    dispatch(AscHo());
  }

  void searchInput(search) {
    dispatch(SearchInput(search: search));
  }

  void jobIdParam(jobId) {
    dispatch(JobIdParam(jobIdParam: jobId));
  }

  void submitHo(callback) {
    dispatch(SubmitHo(callback: callback));
  }

  void ascHoRemove() {
    dispatch(AscHoRemove());
  }

  void ascStatusUpdate(AssignAscHoResponse assignAscHo, String status,
      {String estimate}) {
    this.assignAscHo = assignAscHo;
    this.status = status;
    this.estimate = estimate;
    dispatch(AscStatusUpdate());
  }

  @override
  Stream<AscHoState> mapEventToState(AscHoEvent event) async* {
    if (event is SearchInput) {
      yield currentState.copyWith(search: event.search);

      if (event.search.isEmpty) {
        yield currentState.copyWith(loading: false, ascHoList: response);
      } else {
        List<AssignAscHoResponse> _searchList = [];
        response.forEach((p) {
          if (p.jobId.contains(currentState.search)) {
            _searchList.add(p);
          }
        });

        yield currentState.copyWith(loading: false, ascHoList: _searchList);
      }
    }

    if (event is UserIdParam) {
      yield currentState.copyWith(userId: event.userIdParam);
    }

    if (event is JobIdParam) {
      yield currentState.copyWith(jobId: event.jobIdParam);
    }

    if (event is SubmitHo) {
      yield currentState.copyWith(loading: false);
      await apiProvider.submitHo(currentState.userId, currentState.jobId);
      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult.response;
          yield currentState.copyWith(
            loading: false,
          );
          event.callback(response);
        } else {
          yield currentState.copyWith(
              loading: false, errorMessage: apiProvider.apiResult.errorMessage);
          event.callback(apiProvider.apiResult.errorMessage);
        }
      } catch (e) {
        yield currentState.copyWith(
          loading: false,
        );
        event.callback('Error, Something bad happened.');
      }
    }

    if (event is AscHo) {
      yield currentState.copyWith(ascHoList: List(), loading: true);
      await apiProvider.getAssignToAscHo(currentState.userId);

      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          response = apiProvider.apiResult.response;
          yield currentState.copyWith(loading: false, ascHoList: response);
        } else {
          yield currentState.copyWith(
              loading: false, errorMessage: apiProvider.apiResult.errorMessage);
        }
      } catch (e) {
        yield currentState.copyWith(loading: false, errorMessage: e.toString());
        event.callback('Error, Something bad happened.');
      }
    }

    if (event is AscStatusUpdate) {
      try {
        int id = currentState.ascHoList
            .indexWhere((item) => item.jobId == assignAscHo.jobId);
        if (id != -1) //If id not match then return -1
        {
          currentState.ascHoList[id] = assignAscHo.copyWith(
              status: status, estimate: estimate != null ? estimate : '');

          yield currentState.copyWith(
              jobId: null, loading: false, ascHoList: currentState.ascHoList);
        }
      } catch (e) {
        event.callback('Error, Something bad happened.');
      }
    }

    if (event is AscHoRemove) {
      List<AssignAscHoResponse> removeJobId = currentState.ascHoList;
      removeJobId.removeWhere((item) => item.jobId == currentState.jobId);
      yield currentState.copyWith(
          jobId: null, loading: false, ascHoList: removeJobId);
    }
  }
}

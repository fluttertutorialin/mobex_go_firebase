import 'package:bloc/bloc.dart';
import 'package:mobex_go/service/viewmodel/api_provider.dart';
import 'package:mobex_go/utils/vars.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiProvider apiProvider = ApiProvider();

  void mobileInput(mobile) {
    dispatch(MobileInput(mobile: mobile));
  }

  void passwordInput(password) {
    dispatch(PasswordInput(password: password));
  }

  void login(callback) {
    dispatch(Login(callback: callback));
  }

  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is MobileInput) {
      yield currentState.copyWith(mobile: event.mobile);
    }

    if (event is PasswordInput) {
      yield currentState.copyWith(password: event.password);
    }

    if (event is Login) {
      yield currentState.copyWith(loading: true);
      await apiProvider.getLogin(currentState.mobile, currentState.password);
      try {
        if (apiProvider.apiResult.responseCode == ok200) {
          var response = apiProvider.apiResult.response;
          yield currentState.copyWith(
            loading: false
          );
          event.callback(response);
        } else {
          yield currentState.copyWith(
            loading: false,
          );
          event.callback(apiProvider.apiResult.errorMessage);
        }
      } catch (e) {
        yield currentState.copyWith(
          loading: false
        );
      }
    }
  }
}

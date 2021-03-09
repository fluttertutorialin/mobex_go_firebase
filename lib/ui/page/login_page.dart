import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobex_go/bloc/login/login_bloc.dart';
import 'package:mobex_go/bloc/login/login_state.dart';
import 'package:mobex_go/bloc/user/user_bloc.dart';
import 'package:mobex_go/model/login/login_response.dart';
import 'package:mobex_go/ui/cliper/background_clipper.dart';
import 'package:mobex_go/ui/widget/custom_float_form.dart';
import 'package:mobex_go/ui/widget/empty/empty_widget.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'collectmobile/tab_collectmobile.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //FirebaseMessaging _firebaseMessaging =  FirebaseMessaging();

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _validate = false;
  bool visible = true;

  LoginBloc _loginBloc;
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Form(key: _key, autovalidate: _validate, child: loginBody()),
    );
  }

  loginBody() => ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[loginHeader(), formUI()],
      );

  @override
  void dispose() {
    if (this.mounted) super.dispose();

    _mobileController.dispose();
    _passwordController.dispose();
  }

  loginHeader() => Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 60.0),
            Text(
              '${titleWelcome + ' ' + appName.toLowerCase()}',
              style: TextStyle(
                  fontFamily: quickFont,
                  fontWeight: FontWeight.w700,
                  color: colorTitle,
                  fontSize: 22.0),
            ),
            SizedBox(height: 5.0),
            Text(
              '$titleSignInContinue',
              style: TextStyle(
                  fontFamily: quickFont, color: Colors.grey, fontSize: 18.0),
            ),
            SizedBox(height: 20.0)
          ]);

  formUI() => Stack(children: <Widget>[
        ClipPath(
            clipper: BackgroundClipper(),
            child: Container(
                height: 400,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  color: Colors.white,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 90.0),
                      _showMobileInput(),
                      _showPasswordInput(),
                      SizedBox(height: 10.0)
                    ]))),
        _showFormIcon(),
        _showLoginPressIcon()
      ]);

  _showMobileInput() => BlocBuilder(
      bloc: _loginBloc,
      builder: (BuildContext context, LoginState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
          child: TextFormField(
              controller: _mobileController,
              decoration: InputDecoration(
                  hintText: '$inputHintMobile', labelText: '$inputHintMobile'),
              keyboardType: TextInputType.phone,
              validator: validateMobile,
              onChanged: _loginBloc.mobileInput),
        );
      });

  _showPasswordInput() => BlocBuilder(
      bloc: _loginBloc,
      builder: (BuildContext context, LoginState state) => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
            child: TextFormField(
                controller: _passwordController,
                obscureText: visible,
                decoration: InputDecoration(
                    hintText: '$inputHintPassword',
                    labelText: '$inputHintPassword',
                    suffix: InkWell(
                        child: Icon(
                          visible ? Icons.visibility_off : Icons.visibility,
                        ),
                        onTap: () {
                          setState(() {
                            visible = !visible;
                          });
                        })),
                validator: validatePassword,
                onChanged: _loginBloc.passwordInput),
          ));

  _showFormIcon() =>
      /*Center(
      child: CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.grey.shade100,
          child: Image.asset('assets/images/mobex_go.png',
              color: Colors.grey, height: 30)));*/

      Center(
          child: Container(
        height: 60,
        width: 60,
        child: EmptyListWidget(
            titleTextStyle: Theme.of(context)
                .typography
                .dense
                .display1
                .copyWith(color: Colors.grey),
            subtitleTextStyle: Theme.of(context)
                .typography
                .dense
                .body2
                .copyWith(color: Colors.black54)),
      ));

  _showLoginPressIcon() => Container(
      height: 430,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: CustomFloatForm(
              icon: Icons.navigate_next,
              isMini: false,
              qrCallback: () {
                _loginValidate();
              })));

  _loginValidate() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _loginToApi();
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  _loginToApi() async {
    FocusScope.of(context).requestFocus(FocusNode());
    showProgress(context);

    _loginBloc.login((results) {
      if (results is LoginResponse) {
        hideProgress(context);
        LoginResponse loginResponse = results;

        _userBloc.saveUserName(loginResponse.empName);
        _userBloc.saveId(loginResponse.empId.toString());
        _userBloc.saveMobile(loginResponse.empMobile);
        _userBloc.saveIsLogin(true);

        _userBloc.getLoginDetails();

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TabCollectMobile(id: 0)));
      } else {
        toast(context, results);
        hideProgress(context);

        //CLEAR
        _mobileController.clear();
        _passwordController.clear();
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:mobex_go/ui/page/profile_page.dart';
import 'package:mobex_go/utils/vars.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/asc/asc_bloc.dart';
import 'bloc/ascho/ascho_bloc.dart';
import 'bloc/contact/contact_bloc.dart';
import 'bloc/dispatch/dispatch_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/multipleupload/multiple_upload_bloc.dart';
import 'bloc/pickup/pickup_bloc.dart';
import 'bloc/postpone/postpone_bloc.dart';
import 'bloc/reason/reason_bloc.dart';
import 'bloc/selectasc/select_asc_bloc.dart';
import 'bloc/submitapprove/submit_approve_bloc.dart';
import 'bloc/submitasc/submit_asc_bloc.dart';
import 'bloc/submitestimate/submit_estimate_bloc.dart';
import 'bloc/submitundelivered/submit_undelivered_bloc.dart';
import 'bloc/undelivered/undelivered_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'service/di/dependency_injection.dart';
import 'ui/page/ascho/mobile_repair_asc_ho.dart';
import 'ui/page/contact_page.dart';
import 'ui/page/login_page.dart';
import 'ui/page/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.black,
    statusBarIconBrightness: Brightness.dark
  );
  SystemChrome.setSystemUIOverlayStyle(dark);

  Injector.configure(Flavor.Testing);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final materialApp = MaterialApp(
    title: appName,
    theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.deepOrange,
        primaryColor: Colors.deepOrangeAccent,
        primarySwatch: Colors.deepOrange,
        fontFamily: quickFont),

    debugShowCheckedModeBanner: false,
    showPerformanceOverlay: false,

    initialRoute: '/',

    //routes
    routes: <String, WidgetBuilder>{
      '/': (context) => SplashScreenPage(),
      loginRoute: (BuildContext context) => LoginPage(),
      profileRoute: (BuildContext context) => ProfilePage(),
      contactRoute: (BuildContext context) => ContactPage(),
      mobileRepairAscHoRoute: (BuildContext context) => MobileRepairAscHoPage(),
    });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(builder: (context) => LoginBloc(),
        child: BlocProvider(builder: (context) => UserBloc(),
        child: BlocProvider(builder: (context) => ContactBloc(),
        child: BlocProvider(builder: (context) => PickUpBloc(),
        child: BlocProvider(builder: (context) => ReasonBloc(),
        child: BlocProvider(builder: (context) => AscHoBloc(),
        child: BlocProvider(builder: (context) => AscBloc(),
        child: BlocProvider(builder: (context) => SelectAscBloc(),
        child: BlocProvider(builder: (context) => SubmitAscBloc(),
        child: BlocProvider(builder: (context) => SubmitEstimateBloc(),
        child: BlocProvider(builder: (context) => SubmitApproveBloc(),
        child: BlocProvider(builder: (context) => DispatchBloc(),
        child: BlocProvider(builder: (context) => UndeliveredBloc(),
        child: BlocProvider(builder: (context) => SubmitUndeliveredBloc(),
        child: BlocProvider(builder: (context) => PostPoneBloc(),
        child: BlocProvider(builder: (context) => MultipleUploadBloc(),

        child: materialApp))))))))))))))));
  }
}

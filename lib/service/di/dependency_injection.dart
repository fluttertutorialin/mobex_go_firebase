import 'package:mobex_go/service/viewmodel/mock_service.dart';
import 'package:mobex_go/service/network/network_service.dart';

import '../restclient.dart';

enum Flavor { Testing, Network }

//Simple DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) async {
    _flavor = flavor;
  }

  factory Injector() => _singleton;

  Injector._internal();

  get flavor {
    switch (_flavor) {
      case Flavor.Testing:
        return MockService();
      default:
        return NetworkService(new RestClient());
    }
  }
}

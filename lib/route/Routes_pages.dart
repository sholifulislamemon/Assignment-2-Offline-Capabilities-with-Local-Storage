import 'package:assignment2localstorageinhive/route/route_names.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../views/homeScreen.dart';


class RoutesPages{

  static  List<GetPage<dynamic>>? routes= [

    GetPage(name: RoutesNames.Homescreen, page: () => Homescreen(),),


  ];
}


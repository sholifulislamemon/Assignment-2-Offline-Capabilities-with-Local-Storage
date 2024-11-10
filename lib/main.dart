import 'package:assignment2localstorageinhive/route/Routes_pages.dart';
import 'package:assignment2localstorageinhive/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Open a box (local storage in Hive)
  await Hive.openBox('apiDataBox');

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  @override
  void dispose() {
    Hive.close();
  }
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 890),
      minTextAdapt: true,
      splitScreenMode: true,

      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Use Local Storage in Hive',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        getPages:RoutesPages.routes,
        initialRoute: RoutesNames.Homescreen,
      ),
    );
  }
}

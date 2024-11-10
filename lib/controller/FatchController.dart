import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/ApiModel.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class FatchApiController extends GetxController {
  late Box box;
  RxList<ApiModel> postlist = <ApiModel>[].obs;

  Future<void> openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox("data");
  }

  Future<bool> getapi() async {
    await openBox();
    String baseUrl = "https://jsonplaceholder.typicode.com/comments";
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        await putData(data);
        postlist.clear();
        postlist.addAll(data.map((e) => ApiModel.fromJson(e)).toList());
      }
    } on SocketException {
      print("NO Internet");
    } catch (e) {
      print("Error: $e");
    }

    var myMap = box.toMap().values.toList();
    if (myMap.isEmpty) {
      postlist.add(ApiModel(id: 0, name: "Empty", email: "", body: ""));
    } else {
      postlist.clear();
      postlist.addAll(myMap.map((e) => ApiModel.fromJson(e)).toList());
    }

    return true;
  }

  Future<void> putData(List data) async {
    await box.clear();
    for (var item in data) {
      var apiModel = ApiModel.fromJson(item);
      await box.add(apiModel.toJson());
    }
  }
}

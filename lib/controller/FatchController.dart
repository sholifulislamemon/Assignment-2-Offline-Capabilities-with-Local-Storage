import 'dart:convert';


import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/ApiModel.dart';



class FatchApiController extends GetxController{
  static const base_url ="https://jsonplaceholder.typicode.com/comments";
  List<ApiModel> postlist=[];

  Future<List<ApiModel>> getapi()async{
    final response= await http.get(Uri.parse(base_url));
    var data = jsonDecode(response.body.toString());
    if( response.statusCode == 200){
      for ( Map i in data){
        postlist.add(ApiModel.fromJson(i));
      }
      return postlist;

    }else{
      return postlist;
    }
  }





}
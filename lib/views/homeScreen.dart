import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/FatchController.dart';

import '../utils/TextStyle.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final FatchApiController controller = Get.put(FatchApiController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: controller.getapi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  value: 10,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: controller.postlist.length,
                itemBuilder: (context, index) {
                  var data = controller.postlist[index];
                  return Card(
                    color: Colors.blueGrey.withOpacity(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage("https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp"),
                          ),
                          titleTextStyle:const TextStyle(overflow: TextOverflow.ellipsis),
                          title: HeddingThree(
                              text: data.name.toString(), TextColor: Colors.black),
                          subtitle: HeddingThree(
                            text: data.email.toString(),
                            TextColor: Colors.black,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeddingThree(text: "Descrive me..",TextColor: Colors.black),
                              HeddingFour(text: data.body.toString(),TextColor: Colors.white.withOpacity(.7))
                            ],
                          ),
                        )
                        
                        
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

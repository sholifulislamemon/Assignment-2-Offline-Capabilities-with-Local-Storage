import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/FatchController.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final FatchApiController controller = Get.put(FatchApiController());

  @override
  void initState() {
    super.initState();
    controller.getapi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (controller.postlist.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.postlist.length == 1 && controller.postlist[0].name == "Empty") {
            return const Center(
              child: Text(
                "No data",
                style: TextStyle(fontSize: 24),
              ),
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
                          backgroundImage: NetworkImage(
                              "https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp"),
                        ),
                        title: Text(
                          data.name.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          data.email.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Describe me..", style: TextStyle(color: Colors.black)),
                            Text(
                              data.body.toString(),
                              style: TextStyle(color: Colors.white.withOpacity(.7)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}

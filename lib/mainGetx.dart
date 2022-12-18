import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx_test/controller.dart';

void main() => runApp(const GetMaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Getx Demo'),
        centerTitle: true,
      ),
      //getx方式
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetX<Controller>(
            builder: (controller) {
              return Text('${controller.count1.value}');
            },
          ),
          GetX<Controller>(
            builder: (controller) {
              return Text('${controller.count2.value}');
            },
          ),
          GetX<Controller>(
            builder: (controller) {
              return Text('${controller.sum}');
            },
          ),
          TextButton(
            child: const Text("count1加1"),
            onPressed: () {
              c.count1.value++;
            },
          ),
          TextButton(
            child: const Text("count2加1"),
            onPressed: () {
              c.count2.value++;
            },
          ),
        ],
      )),
    );
  }
}

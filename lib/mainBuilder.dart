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
      body: Center(
        child: GetBuilder<Controller>(builder: (c) {
          return Text(
            '点击了 ${c.count} 次',
            style: const TextStyle(fontSize: 30.0),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        //obs
        onPressed: c.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

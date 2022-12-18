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
        title: const Text('Obs Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          child: ElevatedButton(
            onPressed: () => {Get.to(Other())},
            child: Obx(() => Text("Clicks: ${c.count}")),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //obs
        onPressed: c.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Other extends StatelessWidget {
  // 你可以让Get找到一个正在被其他页面使用的Controller，并将它返回给你。
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // 访问更新后的计数变量
    //  return Scaffold(body: Center(child: Text("${c.count}")));
    return Scaffold(
      appBar: AppBar(
        title: const Text('我是other页面'),
        leading: GestureDetector(
          onTap: () => {Get.back()},
          child: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
      body: Center(child: Text("${c.count}")),
    );
  }
}

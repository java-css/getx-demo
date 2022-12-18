import 'package:get/get.dart';

class Controller extends GetxController {
  //响应式obs
  var count = 0.obs;
  increment() => count++;
  //getx方式
  final count1 = 0.obs;
  final count2 = 0.obs;
  int get sum => count1.value + count2.value;
  //GetBuilder方式
  var countNum = 0;

  get incrementState => null;

  void incrementNum() {
    ++countNum;
    update();
  }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'message.dart';
import 'package:mobx_test/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: Messages(), // 你的翻译
      locale: const Locale('zh', 'CN'), // 默认指定的语言翻译
      fallbackLocale: const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: In18Page(title: "title".tr),
      // home: ObsHome(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo'),
          centerTitle: true,
        ),
        body: RouteNav(),
      ),
      routes: <String, WidgetBuilder>{
        'obs': (BuildContext context) => const ObsHome(),
        'builder': (BuildContext context) => const GetBuilderHome(),
        'getx': (BuildContext context) => const GetxHome(),
        'in18': (BuildContext context) => const In18Page(),
      },
    );
  }
}

class RouteNav extends StatefulWidget {
  @override
  State<RouteNav> createState() => _RouteNavState();
}

class _RouteNavState extends State<RouteNav> {
  bool byName = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SwitchListTile(
              title: Text('${byName ? '' : '不'}通过路由名跳转'),
              value: byName,
              onChanged: (v) => {
                    setState(() {
                      byName = v;
                    })
                  }),
          _item('进入国际化页面', In18Page(), 'in18'),
          _item('进入obs方式页面', const ObsHome(), 'obs'),
          _item('进入GetBuilder方式页面', const GetBuilderHome(), 'builder'),
          _item('进入Getx响应式方式页面', const GetxHome(), 'getx'),
        ],
      ),
    );
  }

  _item(String title, page, String name) {
    return Container(
      child: ElevatedButton(
          onPressed: () {
            if (byName) {
              Navigator.pushNamed(context, name);
            } else {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page));
            }
          },
          child: Text(title)),
    );
  }
}

class ObsHome extends StatelessWidget {
  const ObsHome({super.key});

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
          height: 100,
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

class In18Page extends StatefulWidget {
  // const In18Page({Key? key, required this.title}) : super(key: key);
  const In18Page({super.key});

  // final String title;

  @override
  State<In18Page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<In18Page> {
  void _incrementCounter() {
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text("chinese".tr),
                    onTap: () async {
                      var locale = Locale('zh', 'CN');
                      await Get.updateLocale(locale);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text("english".tr),
                    onTap: () async {
                      var locale = Locale('en', 'US');
                      await Get.updateLocale(locale);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title".tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${'setting_language'.tr}: ${Get.locale}',
            ),
            Text(
              'study'.tr,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'setting_language'.tr,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GetBuilderHome extends StatelessWidget {
  const GetBuilderHome({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        title: const Text('GetBuilder方式 Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: GetBuilder<Controller>(builder: (c) {
          return Text(
            '点击了 ${c.countNum} 次',
            style: const TextStyle(fontSize: 30.0),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        //obs
        onPressed: c.incrementNum,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GetxHome extends StatelessWidget {
  const GetxHome({super.key});

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
              return Text('第一个数:${controller.count1.value}');
            },
          ),
          GetX<Controller>(
            builder: (controller) {
              return Text('第二个数:${controller.count2.value}');
            },
          ),
          GetX<Controller>(
            builder: (controller) {
              return Text('两个数相加:${controller.sum}');
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

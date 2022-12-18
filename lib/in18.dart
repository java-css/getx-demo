import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'message.dart';

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
      home: MyHomePage(title: "title".tr),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
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

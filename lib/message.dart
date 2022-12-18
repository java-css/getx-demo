import 'package:get/get.dart';

import 'en_us.dart';
import 'zh_cn.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_cn': zhCn,
        'en_us': enUs,
      };
}
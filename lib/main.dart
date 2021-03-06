import 'package:flutter/material.dart';
import 'package:flutter_opinion_monitor/_utils/colors.dart';
import 'package:flutter_opinion_monitor/_utils/http/core/hi_cache.dart';
import 'package:flutter_opinion_monitor/router/router.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO

  Logger.root.onRecord.listen((record) {
    print(
        '${record.loggerName}:${record.level.name}:${record.time}:${record.message}');
  });
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate routeDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        var _widget = snapshot.connectionState == ConnectionState.done
            ? Router(routerDelegate: routeDelegate)
            : Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
        return MaterialApp(
          home: _widget,
          theme: ThemeData(
            primarySwatch: createMaterialColor(Colors.white),
          ),
        );
      },
    );

    //
  }
}

// class AppWidget extends StatefulWidget {
//   const AppWidget({Key? key}) : super(key: key);
//
//   @override
//   _AppWidgetState createState() => _AppWidgetState();
// }
//
// class _AppWidgetState extends State<AppWidget> {
//   @override
//   void initState() {
//     super.initState();
//     HiCache.preInit();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: "天南星",
//         theme: ThemeData(
//           primarySwatch: createMaterialColor(Colors.white),
//         ),
//         home: LoginPage());
//   }
//
//   void onAddAction() async {
//     // Map<String, dynamic> json = {
//     //   "code": 0,
//     //   "method": "GET",
//     //   "requestPrams": "dd"
//     // };
//     //
//     // Result result = Result.fromJson(json);
//     // test2();
//     // TestRequest request = TestRequest();
//     // request.add("requestPrams", "1").add("b", "2");
//     // var response = await HiNet.getInstance().fire(request);
//     // log(response.toString());
//
//     //test3();
//
//     test_notice();
//   }
//
//   void test2() {
//     HiCache.getInstance().setString("a", "1");
//     String? a = HiCache.getInstance().get("aa");
//     log(a);
//   }
//
//   void test3() async {
//     var result = await LoginDao.login("liubaochang", "lbc123456");
//     log(result.toString());
//   }
//
//   void test_notice() async {
//     var result = await HiNet.getInstance().fire(ProfileRequest());
//
//     log(result.toString());
//   }
// }

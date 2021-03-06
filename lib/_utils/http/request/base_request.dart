import 'package:flutter_opinion_monitor/_utils/http/dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();
  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    if (needLogin()) {
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass() ?? "");
    }
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  BaseRequest add(String key, Object value) {
    params[key] = value.toString();
    return this;
  }

  Map<String, dynamic> header = Map.from({
    "course-flag": "fa",
    "auth-token": "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa",
  });

  BaseRequest addHeader(String key, Object value) {
    header[key] = value.toString();
    return this;
  }
}

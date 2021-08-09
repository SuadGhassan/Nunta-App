//this file to descibe the connection between server apis and app
import 'dart:async';
// this for http request for api
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'models/user_account_model.dart';
import 'package:nunta_app/service_locator.dart';

class APIProvider {
  //the first here implement get method to get the data stores in the database on a server like its be available for the app (Fetch Data).
  Future<dynamic> get({String url, Map<String, dynamic> params}) async {
    Timer timer; //for count the second when send request
    int apiTimer = 0;
    Response response;
    Map<String, dynamic> apiParams = {
      "app_token":
          "ljoCh1iSESNKVJF37t6KOU1mNegyB8L3WwrKlHjAgZI" //this constant will never change
    };

    timer = Timer.periodic(Duration(milliseconds: 1), (Timer _timer) {
      apiTimer++;
    });

    if (params != null) {
      apiParams.addAll(params);
    }
    //in this condition check when the user login to the app, if the user api_token in the user device will remove it from the request
    if (getIt<UserAccountModel>().isLoggedIn &&
        params?.containsKey('userToken') == true) {
      apiParams.remove('userToken');
      apiParams.putIfAbsent(
          "api_token", () => getIt<UserAccountModel>().userToken);
    } else if (params?.containsKey('userToken') == true) {
      apiParams.remove('userToken');
    }

    Dio dio = new Dio(BaseOptions(
      baseUrl: "http://myscolla.com/nunta/public/api/",
    ));
    dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
    dio.options.headers['content-Type'] = 'multipart/form-data';
    // dio.post this for send to api server and here prepare the app to send http requests to the server and get data (Store Data on server).
    //this for specifi the duration for send request and it is 15 minutes
    try {
      response = await dio.post(url,
          options: buildCacheOptions(Duration(minutes: 15),
              maxStale: Duration(days: 10), forceRefresh: true),
          queryParameters: apiParams);

      print(response.request.uri);
    } on DioError catch (e) {
      print(
          // "Type : ${e.type}, StatusCode : ${e.response.statusCode}, Message : ${e.message}, URL : ${e.request.uri}");
          "Type : ${e.type}, Message : ${e.message}, URL : ${e.request.uri}");
    }
//if the respone failed the timer will stop and print error message
    timer.cancel();
    print("$url Takes     ${apiTimer / 1000}s");

    if (response != null) {
      return response.data;
    } else {
      return response;
    }
  }
}

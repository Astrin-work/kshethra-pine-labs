import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../model/api models/god_model.dart';
import '../utils/hive/hive.dart';


class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://192.168.1.2:7102/api',
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };
  }

  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/Login',
        data: {
          'userUserName': username,
          'userPassword': password,
        },
      );

      print('Response data: ${response.data}');
      final token = response.data['accessToken'];
      print('Token: $token');
      await AppHive().putToken(token: token);
      return token;

    } on DioException catch (e) {
      print('Error response: ${e.response}');
      print('Error data: ${e.response?.data}');
      print('Error message: ${e.message}');
      throw ('${e.response?.data ?? e.message}');
    }
  }

  Future<List<Godmodel>> getDevatha() async {
    final token = await AppHive().getToken();

    final response = await _dio.get(
      '/Devatha/DevathaVazhipadu',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final List<dynamic> dataList = response.data;

    List<Godmodel> godList = [];
    for (var item in dataList) {
      godList.add(Godmodel.fromJson(item));
    }
    return godList;
  }


  Future<void> postVazhipaduDetails(Map<String, dynamic> postVazhipaduData) async {
    final token = await AppHive().getToken();
    print(jsonEncode(postVazhipaduData));

    try {
      final response = await _dio.post(
        '/vazhipadu/vazhipadureceipt',
        data: postVazhipaduData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("------------API Call Success------------");
        print('Vazhipadu submitted: ${response.data}');
      }
    } on DioException catch (e) {
      print('Error submitting vazhipadu: ${e.response?.data ?? e.message}');
      throw Exception('Error submitting vazhipadu: ${e.response?.data ?? e.message}');
    }
  }








}

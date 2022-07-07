import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:question_1/constants/api_url.dart';

import '../models/user_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Data>?> fetchDataUser(int page, int per_page) async {
    List<Data>? listUser = [];
    try {
      Response response =
          await _dio.get('${ApiUrl.userUrl}?page=$page&per_page=$per_page');
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        var _model = UserModel.fromJson(response.data);
        listUser = _model.data;
      }
    } catch (e) {
      log(e.toString());
    }
    return listUser;
  }
}

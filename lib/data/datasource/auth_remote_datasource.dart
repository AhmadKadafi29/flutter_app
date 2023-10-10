import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/models/request/auth_request_model.dart';
import 'package:flutter_app/data/models/response/auth_response_model.dart';
import 'auth_local_datasource.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/variable.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      AuthRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(Uri.parse('${Variable.baseUrl}/api/login'),
        headers: headers, body: requestModel.toJson());
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return left('server error');
    }
  }

  Future<Either<String, String>> logout() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': 'bearer ${await AuthLocalDatasource().getToken()}',
    };
    final response = await http.post(Uri.parse('${Variable.baseUrl}/api/logout'),
        headers: headers);
    if (response.statusCode == 200) {
      return const Right('logout successfully');
    } else {
      return left('server error');
    }
  }
}

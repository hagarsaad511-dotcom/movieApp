import 'package:movie_app/data/model/request/register_request_model.dart';
import 'package:movie_app/data/model/response/register_response_model.dart';

import '../entities/register_entity.dart';

abstract class RegisterRepository {

  // Future<void> register ( RegisterEntity entity);
  Future<RegisterResponseModel> register ( RegisterRequestModel registerRequest);
}
import 'dart:io' show HttpStatus;
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:retrofit/retrofit.dart';

import 'package:cleanarchdemo/utils/resources/data_state.dart';

abstract class BaseApiRepository {
  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        throw DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          message: httpResponse.response.statusMessage
        );
      }  
    } on DioException catch (error) {
      return DataFailed(error);
    }
  } 
}

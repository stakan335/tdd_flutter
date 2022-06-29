import 'dart:convert';

import 'package:dio/dio.dart';

import '../fixtures/fixture_reader.dart';

Future<Response<dynamic>> successAnswer(Invocation invocation) async {
  return Response(
    data: jsonDecode(fixtureJson('trivia')),
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );
}

Future<Response<dynamic>> failureAnswer(Invocation invocation) async {
  return Response(
    data: null,
    statusCode: 400,
    requestOptions: RequestOptions(path: ''),
  );
}

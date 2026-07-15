import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/Fruits.dart';

class ApiService {
  late Dio _dio;
  final Logger _logger = Logger();

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://hrms.tigrid.in",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.i("Request: ${options.method} ${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i("Response: ${response.statusCode}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _logger.e("Error: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<List<Fruits>> getFruits() async {
    try {
      final response = await _dio.get("/fruits");
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Fruits.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}

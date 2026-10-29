import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:finance_app/data/models/account_model.dart';
import 'package:finance_app/domain/entities/account.dart';

abstract class RemoteAccountDataSource {
  Future<List<AccountModel>> fetchAccounts();
  Future<AccountModel?> fetchAccountById(String id);
  Future<AccountModel> createAccount(Account account);
  Future<AccountModel> updateAccount(Account account);
  Future<void> deleteAccount(String id);
  Future<List<AccountModel>> fetchAccountsByUserId(String userId);
}

class RemoteAccountDataSourceImpl implements RemoteAccountDataSource {
  final http.Client _httpClient;
  final String _baseUrl;
  final Duration _timeout;

  RemoteAccountDataSourceImpl({
    required http.Client httpClient,
    String baseUrl = 'https://api.financeapp.example.com/v1',
    Duration timeout = const Duration(seconds: 30),
  })  : _httpClient = httpClient,
        _baseUrl = baseUrl,
        _timeout = timeout;

  @override
  Future<List<AccountModel>> fetchAccounts() async {
    final uri = Uri.parse('$_baseUrl/accounts');

    try {
      final response = await _httpClient
          .get(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(_timeout);

      return _handleResponse<List<AccountModel>>(
        response,
        (body) {
          final List<dynamic> jsonList = json.decode(body) as List<dynamic>;
          return jsonList
              .map((json) => AccountModel.fromJson(json as Map<String, dynamic>))
              .toList();
        },
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al obtener cuentas: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(message: 'Error inesperado al obtener cuentas: $e');
    }
  }

  @override
  Future<AccountModel?> fetchAccountById(String id) async {
    final uri = Uri.parse('$_baseUrl/accounts/$id');

    try {
      final response = await _httpClient
          .get(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(_timeout);

      if (response.statusCode == 404) {
        return null;
      }

      return _handleResponse<AccountModel>(
        response,
        (body) {
          final json = jsonDecode(body) as Map<String, dynamic>;
          return AccountModel.fromJson(json);
        },
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al obtener cuenta: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(message: 'Error inesperado al obtener cuenta: $e');
    }
  }

  @override
  Future<AccountModel> createAccount(Account account) async {
    final uri = Uri.parse('$_baseUrl/accounts');
    final body = json.encode(AccountModel.fromEntity(account).toJson());

    try {
      final response = await _httpClient
          .post(
            uri,
            headers: _buildHeaders(contentType: 'application/json'),
            body: body,
          )
          .timeout(_timeout);

      return _handleResponse<AccountModel>(
        response,
        (responseBody) {
          final json = jsonDecode(responseBody) as Map<String, dynamic>;
          return AccountModel.fromJson(json);
        },
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al crear cuenta: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(message: 'Error inesperado al crear cuenta: $e');
    }
  }

  @override
  Future<AccountModel> updateAccount(Account account) async {
    final uri = Uri.parse('$_baseUrl/accounts/${account.id}');
    final body = json.encode(AccountModel.fromEntity(account).toJson());

    try {
      final response = await _httpClient
          .put(
            uri,
            headers: _buildHeaders(contentType: 'application/json'),
            body: body,
          )
          .timeout(_timeout);

      return _handleResponse<AccountModel>(
        response,
        (responseBody) {
          final json = jsonDecode(responseBody) as Map<String, dynamic>;
          return AccountModel.fromJson(json);
        },
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al actualizar cuenta: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(message: 'Error inesperado al actualizar cuenta: $e');
    }
  }

  @override
  Future<void> deleteAccount(String id) async {
    final uri = Uri.parse('$_baseUrl/accounts/$id');

    try {
      final response = await _httpClient
          .delete(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(_timeout);

      if (response.statusCode == 404) {
        throw NotFoundException(
          message: 'Cuenta no encontrada',
          resourceId: id,
        );
      }

      _handleResponse<void>(
        response,
        (_) => null,
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al eliminar cuenta: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(message: 'Error inesperado al eliminar cuenta: $e');
    }
  }

  @override
  Future<List<AccountModel>> fetchAccountsByUserId(String userId) async {
    final uri = Uri.parse('$_baseUrl/users/$userId/accounts');

    try {
      final response = await _httpClient
          .get(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(_timeout);

      return _handleResponse<List<AccountModel>>(
        response,
        (body) {
          final List<dynamic> jsonList = json.decode(body) as List<dynamic>;
          return jsonList
              .map((json) => AccountModel.fromJson(json as Map<String, dynamic>))
              .toList();
        },
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        message: 'Error de conexión al obtener cuentas de usuario: ${e.message}',
      );
    } catch (e) {
      if (e is NetworkException || e is DataSourceException) rethrow;
      throw NetworkException(
        message: 'Error inesperado al obtener cuentas de usuario: $e',
      );
    }
  }

  Map<String, String> _buildHeaders({String? contentType}) {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': contentType ?? 'application/json',
    };
    return headers;
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(String body) parser,
  ) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return parser(response.body);
    } else if (response.statusCode == 400) {
      final errorBody = _parseErrorBody(response.body);
      throw ValidationException(
        message: errorBody['message'] ?? 'Datos inválidos',
        fieldErrors: errorBody['errors'] != null
            ? Map<String, String>.from(errorBody['errors'] as Map)
            : null,
      );
    } else if (response.statusCode == 404) {
      throw NotFoundException(
        message: 'Recurso no encontrado',
      );
    } else if (response.statusCode >= 500) {
      throw DataSourceException(
        message: 'Error del servidor',
        statusCode: response.statusCode,
      );
    } else {
      throw DataSourceException(
        message: 'Error desconocido',
        statusCode: response.statusCode,
      );
    }
  }

  Map<String, dynamic> _parseErrorBody(String body) {
    try {
      return json.decode(body) as Map<String, dynamic>;
    } catch (e) {
      return {'message': 'Error desconocido'};
    }
  }
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});

  @override
  String toString() => 'NetworkException: $message';
}

class DataSourceException implements Exception {
  final String message;
  final int? statusCode;

  const DataSourceException({required this.message, this.statusCode});

  @override
  String toString() => 'DataSourceException: $message (status: $statusCode)';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? fieldErrors;

  const ValidationException({required this.message, this.fieldErrors});

  @override
  String toString() => 'ValidationException: $message';
}

class NotFoundException implements Exception {
  final String message;
  final String? resourceId;

  const NotFoundException({required this.message, this.resourceId});

  @override
  String toString() => 'NotFoundException: $message';
}
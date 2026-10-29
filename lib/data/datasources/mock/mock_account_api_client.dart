import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

/// Cliente HTTP falso que emula el API de cuentas sin salir a la red.
///
/// Parte de los datos de `assets/mocks/accounts.json` y mantiene los cambios en
/// memoria, de modo que crear, actualizar o eliminar se refleja en consultas
/// posteriores durante la sesión.
class MockAccountApiClient extends http.BaseClient {
  static const String seedAsset = 'assets/mocks/accounts.json';

  final String _baseUrl;
  final AssetBundle _bundle;
  final Duration _latency;

  List<Map<String, dynamic>>? _accounts;

  MockAccountApiClient({
    required String baseUrl,
    AssetBundle? bundle,
    Duration latency = const Duration(milliseconds: 300),
  })  : _baseUrl = baseUrl,
        _bundle = bundle ?? rootBundle,
        _latency = latency;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    await Future<void>.delayed(_latency);
    final accounts = await _loadAccounts();
    final body = await request.finalize().bytesToString();
    final segments = _routeSegments(request.url);

    final response = _route(request.method, segments, body, accounts);
    final bytes = utf8.encode(response.body);
    return http.StreamedResponse(
      Stream.value(bytes),
      response.status,
      contentLength: bytes.length,
      request: request,
      headers: const {'content-type': 'application/json; charset=utf-8'},
    );
  }

  Future<List<Map<String, dynamic>>> _loadAccounts() async {
    final cached = _accounts;
    if (cached != null) return cached;
    final raw = await _bundle.loadString(seedAsset);
    final list = (json.decode(raw) as List<dynamic>).cast<Map<String, dynamic>>();
    return _accounts = list.map((a) => Map<String, dynamic>.from(a)).toList();
  }

  /// Segmentos de la ruta que siguen al path del `baseUrl` (p. ej. `[accounts, acc_001]`).
  List<String> _routeSegments(Uri url) {
    final baseSegments = Uri.parse(_baseUrl).pathSegments.where((s) => s.isNotEmpty);
    return url.pathSegments.where((s) => s.isNotEmpty).skip(baseSegments.length).toList();
  }

  _MockResponse _route(
    String method,
    List<String> segments,
    String body,
    List<Map<String, dynamic>> accounts,
  ) {
    // GET /accounts
    if (method == 'GET' && _matches(segments, ['accounts'])) {
      return _MockResponse(200, json.encode(accounts));
    }
    // POST /accounts
    if (method == 'POST' && _matches(segments, ['accounts'])) {
      return _create(body, accounts);
    }
    // GET|PUT|DELETE /accounts/{id}
    if (segments.length == 2 && segments.first == 'accounts') {
      final index = accounts.indexWhere((a) => a['id'] == segments[1]);
      if (index == -1) return _notFound();
      switch (method) {
        case 'GET':
          return _MockResponse(200, json.encode(accounts[index]));
        case 'PUT':
          return _update(body, accounts, index);
        case 'DELETE':
          accounts.removeAt(index);
          return const _MockResponse(204, '');
      }
    }
    // GET /users/{userId}/accounts
    if (method == 'GET' &&
        segments.length == 3 &&
        segments.first == 'users' &&
        segments[2] == 'accounts') {
      final owned = accounts.where((a) => a['user_id'] == segments[1]).toList();
      return _MockResponse(200, json.encode(owned));
    }
    return _notFound();
  }

  _MockResponse _create(String body, List<Map<String, dynamic>> accounts) {
    final data = json.decode(body) as Map<String, dynamic>;
    final errors = <String, String>{
      if ((data['name'] as String?)?.trim().isEmpty ?? true) 'name': 'El nombre es obligatorio',
      if ((data['user_id'] as String?)?.isEmpty ?? true) 'user_id': 'El usuario es obligatorio',
    };
    if (errors.isNotEmpty) {
      return _MockResponse(400, json.encode({'message': 'Datos inválidos', 'errors': errors}));
    }

    final created = {
      ...data,
      'id': 'acc_${DateTime.now().microsecondsSinceEpoch}',
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'updated_at': null,
    };
    accounts.add(created);
    return _MockResponse(201, json.encode(created));
  }

  _MockResponse _update(String body, List<Map<String, dynamic>> accounts, int index) {
    final data = json.decode(body) as Map<String, dynamic>;
    final updated = {
      ...accounts[index],
      ...data,
      'id': accounts[index]['id'],
      'created_at': accounts[index]['created_at'],
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
    accounts[index] = updated;
    return _MockResponse(200, json.encode(updated));
  }

  bool _matches(List<String> segments, List<String> expected) {
    if (segments.length != expected.length) return false;
    for (var i = 0; i < segments.length; i++) {
      if (segments[i] != expected[i]) return false;
    }
    return true;
  }

  _MockResponse _notFound() =>
      _MockResponse(404, json.encode({'message': 'Recurso no encontrado'}));
}

class _MockResponse {
  final int status;
  final String body;

  const _MockResponse(this.status, this.body);
}

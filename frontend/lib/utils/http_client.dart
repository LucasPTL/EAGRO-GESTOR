import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eagro_gestor/utils/database.dart';

const String baseUrl = ConfigBanco.baseUrl;
const chaveApi = "";
const Duration timeoutDuration = ConfigBanco.timeoutDuration;

Future<http.Response?> get(String endpoint) async {
  final Uri url = Uri.parse(baseUrl + endpoint);
  final client = http.Client();
  try {
    try {
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'chaveapi': chaveApi,
        },
      ).timeout(timeoutDuration);
      return response;
    } catch (e) {
      debugPrint('Erro na requisição GET: $e');
      return null;
    }
  } finally {
    client.close();
  }
}

Future<http.Response?> post(String endpoint, Map<String, dynamic> body) async {
  final Uri url = Uri.parse(baseUrl + endpoint);
  final client = http.Client();
  try {
    try {
      final response = await client
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        debugPrint('Resposta bem-sucedida: ${response.body}');
      } else {
        debugPrint(
            'Erro na requisição POST: Status Code ${response.statusCode}');
      }

      return response;
    } catch (e) {
      debugPrint('Erro na requisição POST: $e');
      return null;
    }
  } finally {
    client.close();
  }
}

Future<http.Response?> delete(String endpoint) async {
  final Uri url = Uri.parse(baseUrl + endpoint);
  final client = http.Client();
  try {
    try {
      final response = await client.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'chaveapi': chaveApi,
        },
      ).timeout(timeoutDuration);
      return response;
    } catch (e) {
      debugPrint('Erro na requisição DELETE: $e');
      return null;
    }
  } finally {
    client.close();
  }
}

Future<http.Response?> put(String endpoint, Map<String, dynamic> body) async {
  final Uri url = Uri.parse(baseUrl + endpoint);
  final client = http.Client();
  try {
    try {
      final response = await client
          .put(
            url,
            headers: {
              'Content-Type': 'application/json',
              'chaveapi': chaveApi,
            },
            body: jsonEncode(body),
          )
          .timeout(timeoutDuration);
      return response;
    } catch (e) {
      debugPrint('Erro na requisição PUT: $e');
      return null;
    }
  } finally {
    client.close();
  }
}

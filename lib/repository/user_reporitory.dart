import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:crud_test/model/model.dart';

class ModelRepository {
  final String baseUrl =
      'https://crudcrud.com/api/501bf95f1c1f4c52b5c6ff9369df0004/unicorns';

  Future<List<Model>> fetchModels() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Model.fromJson(item)).toList();
      } else {
        log('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Eror : $e');
      return [];
    }
  }

  Future<bool> addModel(Model model) async {
    try {
      final response = await http.post(Uri.parse(baseUrl),
          headers: {'Content-type': 'application/json'},
          body: json.encode(model.toJsonWithoutId()));
      return response.statusCode == 200;
    } catch (e) {
      log('Error : $e');
      return false;
    }
  }

  Future<bool> updateModel(String id, Model model) async {
    try {
      final response = await http.put(Uri.parse('$baseUrl/$id'),
          headers: {'Content-type': 'application/json'},
          body: json.encode(model.toJson()));
      return response.statusCode == 200;
    } catch (e) {
      log('Error : $e');
      return false;
    }
  }

  Future<bool> deleteModel(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      return response.statusCode == 200;
    } catch (e) {
      log('Error : $e');
      return false;
    }
  }
}

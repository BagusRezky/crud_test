// ignore_for_file: file_names

import 'package:crud_test/model/model.dart';
import 'package:crud_test/repository/user_reporitory.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

class SettingProvider extends ChangeNotifier {
  List<Model> models = [];
  final ModelRepository modelRepository = ModelRepository();
  List<Model> get model => models;

  Future<void> fetchModels() async {
    models = await modelRepository.fetchModels();
    notifyListeners();
  }

  Future<bool> addModel(Model model) async {
    bool added = await modelRepository.addModel(model);
    if (added) {
      await fetchModels(); 
    }
    return added; 
}

  Future<void> updateModel(String id, Model updateModel) async {
    if (await modelRepository.updateModel(id, updateModel)) {
      await fetchModels();
    }
  }

  Future<void> deleteModel(String id) async {
    if (await modelRepository.deleteModel(id)) {
      models.removeWhere((model) => model.id == id);
      notifyListeners();
    }
  }
}

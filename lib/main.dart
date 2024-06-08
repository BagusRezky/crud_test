// ignore_for_file: depend_on_referenced_packages

import 'package:crud_test/model/model.dart';
import 'package:crud_test/settingprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingProvider()..fetchModels(),
      child: const MaterialApp(
        home: ListScreen(),
      ),
    );
  }
}

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Screen'),
        actions: [
          IconButton(
            onPressed: () {
              _showAddModelDialog(context);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await settingProvider.fetchModels();
        },
        child: settingProvider.models.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: settingProvider.models.length,
                itemBuilder: (context, index) {
                  final model = settingProvider.models[index];
                  return ListTile(
                      leading: Text(model.name),
                      title: Text('${model.age}'),
                      subtitle: Text(model.colour),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () =>
                                _showEditModelDialog(context, model),
                          ),
                          IconButton(
                            onPressed: () =>
                                settingProvider.deleteModel(model.id),
                                
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ));
                },
              ),
      ),
    );
  }

  void _showAddModelDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController colourController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add data'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(hintText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: colourController,
                decoration: const InputDecoration(hintText: 'Colour'),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final Model newModel = Model(
                    id: '',
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    colour: colourController.text);
                Provider.of<SettingProvider>(context, listen: false)
                    .addModel(newModel);
                Navigator.of(context).pop();
              },
              child: const Text('ADD'),
            )
          ],
        );
      },
    );
  }

  void _showEditModelDialog(BuildContext context, Model model) {
    final TextEditingController nameController =
        TextEditingController(text: model.name);
    final TextEditingController ageController =
        TextEditingController(text: model.age.toString());
    final TextEditingController colourController =
        TextEditingController(text: model.colour);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit data'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(hintText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: colourController,
                decoration: const InputDecoration(hintText: 'Colour'),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                final Model updateModel = Model(
                    id: model.id,
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    colour: colourController.text);
                Provider.of<SettingProvider>(context, listen: false)
                    .updateModel(model.id, updateModel);
              },
              child: const Text('Update'),
              
            )
          ],
        );
      },
    );
  }
}

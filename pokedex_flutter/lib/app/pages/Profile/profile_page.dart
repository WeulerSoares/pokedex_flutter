import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app/data/models/profile_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  
  final List<ProfileModel> profiles = [];

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _birthDateController;
  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _birthDateController = TextEditingController();
    _genderController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _addProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        profiles.add(
          ProfileModel(
            name: _nameController.text,
            birthDate: DateTime.now(),
            gender: Gender.male,
          ),
        );
        db.collection("Trainer").doc("Trainer").set({"name": _nameController.text});
        _nameController.clear();
        _birthDateController.clear();
        _genderController.clear();
      });
    }
  }

  void _editProfile(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Perfil'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: TextEditingController(text: profiles[index].name),
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite o nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    profiles[index].name = value;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: TextEditingController(text: profiles[index].birthDate.toString()),
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento (Formato: YYYY-MM-DD)',
                    hintText: 'Digite a data de nascimento',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data de nascimento';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    profiles[index].birthDate = DateTime.parse(value);
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: TextEditingController(text: profiles[index].gender.name),
                  decoration: InputDecoration(
                    labelText: 'Gênero',
                    hintText: 'Digite o gênero',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o gênero';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    profiles[index].gender = Gender.female;
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context, profiles[index]);
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    ).then((editedProfile) {
      if (editedProfile != null) {
        setState(() {
          profiles[index] = editedProfile;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Perfis'),
        backgroundColor: Colors.deepPurple, // Cor da app bar
      ),
      body: profiles.isEmpty
          ? Center(
              child: Text(
                'Nenhum perfil encontrado.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      profiles[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.0),
                        Text(
                          'Nascimento: ${profiles[index].birthDate.toString()}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Gênero: ${profiles[index].gender}',
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editProfile(index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Adicionar Perfil'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          hintText: 'Digite o nome',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um nome';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _birthDateController,
                        decoration: InputDecoration(
                          labelText: 'Data de Nascimento (Formato: YYYY-MM-DD)',
                          hintText: 'Digite a data de nascimento',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a data de nascimento';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _genderController,
                        decoration: InputDecoration(
                          labelText: 'Gênero',
                          hintText: 'Digite o gênero',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o gênero';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addProfile();
                      Navigator.pop(context);
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple, // Cor do botão flutuante
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/http/http_client.dart';
import '../../data/models/repositories/pokemon_repository.dart';
import '../home/stores/pokemon_store.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final PokemonStore store = PokemonStore(
    repository: PokemonRepository(
      client: HttpClient(),
    ),
  );

  late Future<List<Pokemon>> _pokemonData;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _pokemonData = _getPokemonData();
  }

  void releasePokemon(Pokemon pokemon) async {
    try {
      DocumentReference pokemonRef =
          db.collection('Pokemons').doc(pokemon.name);
      await pokemonRef.delete();

      setState(() {
        _pokemonData = _getPokemonData();
      });
    } catch (e) {
      print('Erro ao deletar dados do Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokemons capturados',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Pokemon>>(
          future: _pokemonData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('Nenhum Pokémon encontrado.');
            } else {
              return Expanded(
                child: ListView(
                  children: snapshot.data!.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final Pokemon pokemon = entry.value;
                    return Container(
                      margin: EdgeInsets.only(
                          bottom:
                              index == snapshot.data!.length - 1 ? 0.0 : 8.0),
                      child: PokemonCard(
                        pokemon: pokemon,
                        onRelease: () => releasePokemon(pokemon),
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Future<List<Pokemon>> _getPokemonData() async {
  try {
    // Substitua '/Pokemons' pelo caminho específico do seu banco de dados Firebase
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Pokemons').get();

    List<Pokemon> pokemonList =
        snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      Map<String, dynamic> data = doc.data();
      return Pokemon(
        id: data['id'] ?? '',
        name: data['name'] ?? '',
        height: data['height'] ?? '',
        weight: data['weight'] ?? '',
        type: data['type'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
      );
    }).toList();

    return pokemonList;
  } catch (e) {
    print('Erro ao obter dados do Firestore: $e');
    return []; // Retorna uma lista vazia em caso de erro
  }
}

class Pokemon {
  String id;
  String name;
  String type;
  String height;
  String weight;
  String imageUrl;

  Pokemon(
      {required this.id,
      required this.name,
      required this.type,
      required this.weight,
      required this.height,
      required this.imageUrl});
}

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onRelease;

  PokemonCard({required this.pokemon, required this.onRelease});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.white, // Altere para a cor desejada
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome: ${pokemon.name}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Altura: ${pokemon.height} m',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Peso: ${pokemon.weight} kg',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Tipo: ${pokemon.type}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onRelease,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text(
                        'Liberar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            child: Image.network(
              pokemon.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

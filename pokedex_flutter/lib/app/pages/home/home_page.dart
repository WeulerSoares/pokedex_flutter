import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app/data/http/http_client.dart';
import 'package:pokedex_flutter/app/data/models/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/app/pages/Profile/team_page.dart';
import 'package:pokedex_flutter/app/pages/home/stores/pokemon_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokemonStore store = PokemonStore(
    repository: PokemonRepository(
      client: HttpClient(),
    ),
  );

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    store.getPokemon(sortPokemon(1, 150).toString());
  }

  void capturePokemon(String id, String name, String height, String weight,
      String types, String imageUrl) {
    try {
      db.collection('Pokemons').doc(name).set({
        "id": id,
        "name": name,
        "height": height,
        "weight": weight,
        "type": types,
        "imageUrl": imageUrl
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pokémon $name capturado com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        store.getPokemon(sortPokemon(1, 150).toString());
      });
    } catch (e) {
      print('Erro ao cadastrar pokemon: $e');
    }
  }

  void rollPokemon() {
    setState(() {
      store.getPokemon(sortPokemon(1, 150).toString());
    });
  }

  int sortPokemon(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Pokedex',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Menu Lateral',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Página Inicial'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.catching_pokemon_outlined),
              title: Text('Time Pokemon'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.erro,
          store.state,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                store.erro.value,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            final item = store.state.value;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Image.network(
                    item!.sprites.values.elementAt(4),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Nome: ${item.name}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Altura: ${item.height.toStringAsFixed(2)}m',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Peso: ${item.weight.toStringAsFixed(2)}kg',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Tipo: ${item.types}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        capturePokemon(
                            item.id.toString(),
                            item.name,
                            item.height.toString(),
                            item.weight.toString(),
                            item.types,
                            item.sprites.values.elementAt(4));
                      },
                      icon: Icon(Icons.catching_pokemon, color: Colors.white),
                      label: Text('Capturar',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: rollPokemon,
                      icon: Icon(Icons.new_releases, color: Colors.white),
                      label:
                          Text('Rolar', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

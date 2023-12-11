import 'dart:convert';
import 'package:pokedex_flutter/app/data/http/exceptions.dart';
import 'package:pokedex_flutter/app/data/http/http_client.dart';
import 'package:pokedex_flutter/app/data/models/pokemon_model.dart';

abstract class IPokemonRepository {
  Future<PokemonModel> getPokemon(String idOrName);
}

class PokemonRepository implements IPokemonRepository {
  final IHttpClient client;

  PokemonRepository({required this.client});

  @override
  Future<PokemonModel> getPokemon(String idOrName) async {
    final response = await client.get(
      url: 'https://pokeapi.co/api/v2/pokemon/$idOrName',
    );
  
    if (response.statusCode == 200) {
      PokemonModel pokemon = {} as PokemonModel;

      final body = jsonDecode(response.body);

      pokemon = PokemonModel.fromMap(body);

      return pokemon;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida');
    } else {
      throw Exception('Não foi possível carregar o pokemon');
    }
  }
}
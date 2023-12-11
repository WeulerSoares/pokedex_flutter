import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app/data/http/exceptions.dart';
import 'package:pokedex_flutter/app/data/models/pokemon_model.dart';
import 'package:pokedex_flutter/app/data/models/repositories/pokemon_repository.dart';

class PokemonStore {
  final IPokemonRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<PokemonModel> state = ValueNotifier<PokemonModel>({} as PokemonModel);
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  PokemonStore({required this.repository});

  Future getPokemon(String idOrName) async {
    isLoading.value = true;

    try {
      final result = await repository.getPokemon(idOrName);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    }
    catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
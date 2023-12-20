class PokemonModel {
  final int id;
  final String name;
  final String types;
  final double height;
  final double weight;
  final Map<String, dynamic> sprites;

  PokemonModel({
    required this.id,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.sprites,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    // List<String> typesNames =
    //     map['types'].map((type) => type['type']['name'].toList());

    return PokemonModel(
      id: map['id'],
      name: map['name'].toString().toUpperCase(),
      types:
          map['types'].map((e) => e['type']['name']).toString().toUpperCase(),
      height: map['height'] * 0.1,
      weight: map['weight'] * 0.1,
      sprites: Map<String, dynamic>.from(map['sprites'] ?? {}),
    );
  }
}

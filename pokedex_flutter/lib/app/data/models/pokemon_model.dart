class PokemonModel {
  final int id; 
  final String name;
  final double height;
  final double weight;
  final List<String> sprites;

  PokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.sprites,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      id: map['id'],
      name: map['name'],
      height: map['height'],
      weight: map['weight'],
      sprites: List<String>.from(['sprites']),
    );
  }
}
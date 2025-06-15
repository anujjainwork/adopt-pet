class PetModel {
  final int id;
  final String name;
  final String age;
  final String type;
  final String size;
  final String gender;
  final String description;
  final double cost;
  final String imagePath;
  final String breed;
  final bool isAdopted;
  final bool isFavourite;
  final DateTime? adoptedDateTime;

  PetModel({
    required this.id,
    required this.name,
    required this.age,
    required this.type,
    required this.size,
    required this.gender,
    required this.breed,
    required this.description,
    required this.cost,
    required this.imagePath,
    required this.isAdopted,
    required this.isFavourite,
    this.adoptedDateTime
  });

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      type: map['type'],
      size: map['size'],
      gender: map['gender'],
      breed: map['breed'],
      description: map['description'],
      cost: map['cost'] is int ? (map['cost'] as int).toDouble() : map['cost'],
      imagePath: map['imagePath'],
      isAdopted: map['isAdopted'] == 1,
      isFavourite: map['isFavourite'] == 1,
      adoptedDateTime: map['adoptedDateTime']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'type': type,
      'size': size,
      'gender': gender,
      'description': description,
      'breed' : breed,
      'cost': cost,
      'imagePath': imagePath,
      'isAdopted': isAdopted ? 1 : 0,
      'isFavourite': isFavourite ? 1 : 0,
      'adoptedDateTime' : adoptedDateTime
    };
  }

  PetModel copyWith({
    int? id,
    String? name,
    String? age,
    String? type,
    String? size,
    String? gender,
    String? breed,
    String? description,
    double? cost,
    String? imagePath,
    bool? isAdopted,
    bool? isFavourite,
    DateTime? adoptedDateTime,
  }) {
    return PetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      type: type ?? this.type,
      size: size ?? this.size,
      gender: gender ?? this.gender,
      breed: breed ?? this.breed,
      description: description ?? this.description,
      cost: cost ?? this.cost,
      imagePath: imagePath ?? this.imagePath,
      isAdopted: isAdopted ?? this.isAdopted,
      isFavourite: isFavourite ?? this.isFavourite,
      adoptedDateTime: adoptedDateTime
    );
  }
}

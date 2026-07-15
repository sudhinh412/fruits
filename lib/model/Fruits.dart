import 'dart:convert';
Fruits fruitsFromJson(String str) => Fruits.fromJson(json.decode(str));
String fruitsToJson(Fruits data) => json.encode(data.toJson());
class Fruits {
  Fruits({
      this.id, 
      this.name, 
      this.scientificName, 
      this.description, 
      this.image, 
      this.price, 
      this.quantity, 
      this.tag, 
      this.benefits, 
      this.recipes,});

  Fruits.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    scientificName = json['scientificName'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    tag = json['tag'];
    if (json['benefits'] != null) {
      benefits = [];
      json['benefits'].forEach((v) {
        benefits?.add(Benefits.fromJson(v));
      });
    }
    if (json['recipes'] != null) {
      recipes = [];
      json['recipes'].forEach((v) {
        recipes?.add(Recipes.fromJson(v));
      });
    }
  }
  num? id;
  String? name;
  String? scientificName;
  String? description;
  String? image;
  num? price;
  num? quantity;
  String? tag;
  List<Benefits>? benefits;
  List<Recipes>? recipes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['scientificName'] = scientificName;
    map['description'] = description;
    map['image'] = image;
    map['price'] = price;
    map['quantity'] = quantity;
    map['tag'] = tag;
    if (benefits != null) {
      map['benefits'] = benefits?.map((v) => v.toJson()).toList();
    }
    if (recipes != null) {
      map['recipes'] = recipes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Recipes recipesFromJson(String str) => Recipes.fromJson(json.decode(str));
String recipesToJson(Recipes data) => json.encode(data.toJson());
class Recipes {
  Recipes({
      this.name, 
      this.image, 
      this.link,});

  Recipes.fromJson(dynamic json) {
    name = json['name'];
    image = json['image'];
    link = json['link'];
  }
  String? name;
  String? image;
  String? link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['image'] = image;
    map['link'] = link;
    return map;
  }

}

Benefits benefitsFromJson(String str) => Benefits.fromJson(json.decode(str));
String benefitsToJson(Benefits data) => json.encode(data.toJson());
class Benefits {
  Benefits({
      this.name, 
      this.image, 
      this.description,});

  Benefits.fromJson(dynamic json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }
  String? name;
  String? image;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['image'] = image;
    map['description'] = description;
    return map;
  }

}
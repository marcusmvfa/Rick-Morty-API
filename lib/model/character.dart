class Character {
  String? id;
  String? name;
  String? species;
  String? image;
  String? status;

  Character({this.id, this.name, this.species, this.image, this.status});

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    species = json['species'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['species'] = this.species;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}

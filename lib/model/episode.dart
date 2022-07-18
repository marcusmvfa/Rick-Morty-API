import 'package:flutter/foundation.dart';
import 'package:rick_morty_api/model/character.dart';

class Episode {
  String? id;
  String? name;
  String? episode;
  String? airDate;
  List<Character>? characters;
  ValueNotifier<bool> favorited = ValueNotifier(false);
  ValueNotifier<bool> watched = ValueNotifier(false);

  Episode({
    this.id,
    this.name,
    this.episode,
    this.airDate,
    this.characters,
  });

  Episode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    episode = json['episode'];
    airDate = json['air_date'];
    if (json['characters'] != null) {
      characters = <Character>[];
      json['characters'].forEach((v) {
        characters!.add(Character.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['episode'] = episode;
    data['air_date'] = airDate;
    if (characters != null) {
      data['characters'] = characters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

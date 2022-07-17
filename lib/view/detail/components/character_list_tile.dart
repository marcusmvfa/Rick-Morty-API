import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rick_morty_api/model/character.dart';

class CharacterListTile extends StatelessWidget {
  const CharacterListTile(this.character, {Key? key}) : super(key: key);
  final Character character;
  isAlive() => character.status == "Alive" ? Colors.green : Colors.red;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        style: ListTileStyle.drawer,
        leading: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            character.image!,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(character.name!),
        subtitle: Text(character.species!),
        trailing: Text(
          character.status!,
          style: TextStyle(color: isAlive(), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

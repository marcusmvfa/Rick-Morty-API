import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/view/detail/components/character_list_tile.dart';
import 'package:rick_morty_api/view_model/episode_view_model.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<EpisodesViewModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "${vm.episodeSelected.characters!.length} Characters appeared:",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const Divider(
          height: 36,
          thickness: 2,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: vm.episodeSelected.characters!.length,
            itemBuilder: (context, index) {
              return CharacterListTile(vm.episodeSelected.characters![index]);
            })
      ]),
    );
  }
}

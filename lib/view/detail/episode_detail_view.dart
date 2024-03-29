import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/view/detail/components/characters_list.dart';
import 'package:rick_morty_api/view/detail/components/header_detail.dart';
import 'package:rick_morty_api/view_model/episode_view_model.dart';

class EpisodeDetailView extends StatelessWidget {
  EpisodeDetailView({Key? key}) : super(key: key);
  late EpisodesViewModel vm;

  isFavorited() => vm.episodeSelected.favorited.value ? Colors.amber : Colors.white;
  @override
  Widget build(BuildContext context) {
    vm = Provider.of<EpisodesViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const Spacer(),
          const Text("Episode Detail"),
          const Spacer(),
          ValueListenableBuilder(
              valueListenable: vm.episodeSelected.favorited,
              builder: (context, model, child) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                      onPressed: (() {
                        vm.episodeSelected.favorited.value = !vm.episodeSelected.favorited.value;
                        vm.setFavorited(vm.episodeSelected);
                      }),
                      icon: const Icon(Icons.star),
                      color: isFavorited()),
                );
              }),
        ]),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [HeaderDetail(), const CharactersList()],
      )),
    );
  }
}

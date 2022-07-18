import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/view/home/components/episode_list_tile.dart';
import 'package:rick_morty_api/view_model/episode_view_model.dart';

class EpisodesList extends StatelessWidget {
  const EpisodesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<EpisodesViewModel>(context, listen: true);
    viewModel.fillFavorites();
    return ValueListenableBuilder(
        valueListenable: viewModel.episodes,
        builder: (context, value, child) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.episodes.value.length,
              itemBuilder: (context, index) {
                var ep = viewModel.episodes.value[index];
                return EpisodeListTile(ep);
              });
        });
  }
}

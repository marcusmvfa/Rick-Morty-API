import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/model/episode.dart';
import 'package:rick_morty_api/view/home/components/episode_list_tile.dart';
import 'package:rick_morty_api/view/home/components/search_bar.dart';
import 'package:rick_morty_api/view_model/episode_view_model.dart';

class EpisodesList extends StatefulWidget {
  const EpisodesList({Key? key, this.favTab = false}) : super(key: key);
  final bool favTab;
  @override
  State<EpisodesList> createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList> {
  bool favTab = false;
  late EpisodesViewModel viewModel;
  @override
  void initState() {
    favTab = widget.favTab;

    // Provider.of<EpisodesViewModel>(context, listen: false).getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<EpisodesViewModel>(context, listen: true);
    return ValueListenableBuilder<bool>(
        valueListenable: viewModel.isLoading,
        builder: (context, value, child) {
          if (value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (favTab) {
              var l = viewModel.episodes.value
                  .where((element) => element.favorited.value == true)
                  .toList();
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    var l = viewModel.episodes.value
                        .where((element) => element.favorited.value == true)
                        .toList();
                    var ep = l[index];
                    return EpisodeListTile(ep);
                  });
            } else {
              return SingleChildScrollView(
                child: Column(children: [
                  SearchBar(),
                  ValueListenableBuilder<List<Episode>>(
                      valueListenable: viewModel.episodes,
                      builder: (context, value, child) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: viewModel.episodes.value.length,
                            itemBuilder: (context, index) {
                              var ep = viewModel.episodes.value[index];
                              return EpisodeListTile(key: UniqueKey(), ep);
                            });
                      }),
                ]),
              );
            }
          }
        });
  }
}

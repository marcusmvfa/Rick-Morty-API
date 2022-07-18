import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/model/episode.dart';
import 'package:rick_morty_api/view/detail/episode_detail_view.dart';
import 'package:rick_morty_api/view_model/episode_view_model.dart';

class EpisodeListTile extends StatefulWidget {
  const EpisodeListTile(this.episode, {Key? key}) : super(key: key);
  final Episode episode;
  @override
  State<EpisodeListTile> createState() => _EpisodeListTileState();
}

class _EpisodeListTileState extends State<EpisodeListTile> {
  late Episode episode;
  late EpisodesViewModel viewModel;
  @override
  void initState() {
    episode = widget.episode;
    viewModel = Provider.of<EpisodesViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        viewModel.episodeSelected = episode;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodeDetailView()));
      },
      child: ListTile(
        leading: SizedBox(
          width: size.width * 0.12,
          child: InkWell(
            onTap: () {
              setState(() {
                episode.favorited.value = !episode.favorited.value;
              });
              viewModel.setFavorited(episode);
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(episode.id!),
              Icon(
                Icons.star,
                color: episode.favorited.value ? Colors.amber : null,
              ),
            ]),
          ),
        ),
        title: Text(episode.name!),
        subtitle: Text(episode.airDate!),
        trailing: SizedBox(
          width: size.width * 0.25,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              episode.episode!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(episode.characters!.length.toString()), const Icon(Icons.group)])
          ]),
        ),
      ),
    );
  }
}

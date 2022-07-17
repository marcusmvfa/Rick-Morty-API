import 'package:flutter/material.dart';
import 'package:rick_morty_api/view/home/components/episodes_list.dart';
import 'package:rick_morty_api/view_model/episode_view_model.dart';

class MyHomeView extends StatefulWidget {
  const MyHomeView({Key? key}) : super(key: key);

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  @override
  Widget build(BuildContext context) {
    EpisodesViewModel ctrl = EpisodesViewModel();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rick and Morty"),
        ),
        body: EpisodesList());
  }
}

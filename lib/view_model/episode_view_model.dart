import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_morty_api/model/episode.dart';
import 'package:rick_morty_api/services/episode_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EpisodesViewModel extends ChangeNotifier {
  final BehaviorSubject<List?> _repoSubject = BehaviorSubject<List?>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ValueNotifier<List<Episode>> episodes = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  Episode episodeSelected = Episode();
  var listFavorites = <String>[];
  var listWatched = <String>[];

  ValueNotifier<GraphQLClient> graphclient = ValueNotifier(
    GraphQLClient(
      defaultPolicies: DefaultPolicies(query: Policies(fetch: FetchPolicy.noCache)),
      cache: GraphQLCache(),
      link: HttpLink('https://rickandmortyapi.com/graphql'),
    ),
  );

  EpisodesViewModel() {
    getEpisodes().then((value) async {
      await getPreferences();
    });
  }

  Future<void> getEpisodes() async {
    isLoading.value = true;
    final result = await EpisodeService().getEpisodes(graphclient.value);

    final repositories = result.data!['episodes']['results'];
    episodes.value = List<Episode>.from(repositories.map((model) => Episode.fromJson(model)));
    mergeFavorites();
    isLoading.value = false;
  }

  setFavorited(Episode ep) async {
    var prefs = await _prefs;
    if (ep.favorited.value == true && !listFavorites.contains(ep.id!)) {
      listFavorites.add(ep.id!);
    } else if (ep.favorited.value == false) {
      listFavorites.remove(ep.id!);
    }

    prefs.setStringList("favorites", listFavorites as List<String>);
  }

  getFavorites() async {
    var prefs = await _prefs;
    listFavorites = prefs.getStringList("favorites") ?? [];
  }

  setWatched(Episode ep) async {
    var prefs = await _prefs;
    if (ep.watched.value == true && !listWatched.contains(ep.id!)) {
      listWatched.add(ep.id!);
    } else if (ep.watched.value == false) {
      listWatched.remove(ep.id!);
    }

    prefs.setStringList("watched", listWatched as List<String>);
  }

  getWatched() async {
    var prefs = await _prefs;
    listWatched = prefs.getStringList("watched") ?? <String>[];
  }

  fillFavorites() async {
    await getFavorites();
    for (var ep in episodes.value) {
      if (listFavorites.contains(ep.id.toString())) {
        ep.favorited.value = true;
      }
    }
  }

  fillWatcheds() async {
    await getWatched();
    for (var ep in episodes.value) {
      if (listWatched.contains(ep.id.toString())) {
        ep.watched.value = true;
      }
    }
  }

  Future getPreferences() async {
    isLoading.value = true;
    await fillFavorites();
    await fillWatcheds();
    isLoading.value = false;
  }

  searchEpisode(String text) async {
    final result = await EpisodeService().searchEpisode(graphclient.value, text);

    final repositories = result.data!['episodes']['results'];
    episodes.value = List<Episode>.from(repositories.map((model) => Episode.fromJson(model)));
    mergeFavorites();
  }

  mergeFavorites() {
    var list = <Episode>[];
    for (var ep in episodes.value) {
      if (listFavorites.contains(ep.id)) {
        ep.favorited.value = true;
      }
      if (listWatched.contains(ep.id)) {
        ep.watched.value = true;
      }
      list.add(ep);
    }

    episodes.value = list;
    print("merdge");
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_morty_api/model/episode.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EpisodesViewModel extends ChangeNotifier {
  final BehaviorSubject<List?> _repoSubject = BehaviorSubject<List?>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ValueNotifier<List<Episode>> episodes = ValueNotifier([]);
  Episode episodeSelected = Episode();
  var listFavorites = [];
  var listWatched = [];

  static final GraphQLClient _client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink('https://rickandmortyapi.com/graphql'),
  );

  EpisodesViewModel() {
    _queryRepo();
  }

  Future<void> _queryRepo({int nRepositories = 50}) async {
    // null is loading
    _repoSubject.add(null);
    final _options = WatchQueryOptions(
      document: gql("""
    query users {
      episodes{
    info{count, pages}
    results{id,name, episode, air_date,characters{id,name,species, image,status}}
  }
    }
  """),
      variables: <String, dynamic>{
        'nRepositories': nRepositories,
      },
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    final result = await _client.query(_options);

    if (result.hasException) {
      _repoSubject.addError(result.exception!);
      return;
    }
    // result.data can be either a [List<dynamic>] or a [Map<String, dynamic>]
    final repositories = result.data!['episodes']['results'];
    episodes.value = List<Episode>.from(repositories.map((model) => Episode.fromJson(model)));
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
    notifyListeners();
  }

  fillWatcheds() async {
    await getWatched();
    for (var ep in episodes.value) {
      if (listWatched.contains(ep.id.toString())) {
        ep.watched.value = true;
      }
    }
  }

  getPreferences() async {
    await fillFavorites();
    await fillWatcheds();
  }
}

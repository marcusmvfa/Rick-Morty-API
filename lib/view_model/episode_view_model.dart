import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_morty_api/model/episode.dart';
import 'package:rxdart/rxdart.dart';

class EpisodesViewModel extends ChangeNotifier {
  final BehaviorSubject<List?> _repoSubject = BehaviorSubject<List?>();
  ValueNotifier<List<Episode>> episodes = ValueNotifier([]);
  Episode episodeSelected = Episode();

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
}

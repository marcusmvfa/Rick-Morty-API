import 'package:graphql/src/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EpisodeService {
  Future getEpisodes(GraphQLClient value) async {
    final _options = WatchQueryOptions(
      document: gql("""
    query users {
      episodes{
    info{count, pages}
    results{id,name, episode, air_date,characters{id,name,species, image,status}}
  }
    }
  """),
      pollInterval: const Duration(seconds: 2),
      fetchResults: true,
    );

    return await value.query(_options);
  }

  Future searchEpisode(GraphQLClient value, String text) async {
    final _options = WatchQueryOptions(
        document: gql("""
    query {
      episodes(filter: {name: "$text"}){

    results{id,name, episode, air_date,characters{id,name,species, image,status}}
  }
    }
  """),
        pollInterval: const Duration(seconds: 2),
        fetchResults: true,
        fetchPolicy: FetchPolicy.networkOnly);

    return await value.query(_options);
  }
}

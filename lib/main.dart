import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/view/home/home_view.dart';
import 'package:rick_morty_api/view_model/episode_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final HttpLink link = HttpLink(
    'https://api.spacex.land/graphql/',
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EpisodesViewModel()),
      ],
      child: MyApp(client),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(this.client, {Key? key}) : super(key: key);

  final ValueNotifier<GraphQLClient> client;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Provider.of<EpisodesViewModel>(context, listen: false).graphclient,
      child: CacheProvider(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'azs-mob-rickandmorty',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            home: const MyHomeView()),
      ),
    );
  }
}

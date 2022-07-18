import 'package:flutter/material.dart';
import 'package:rick_morty_api/view/home/components/episodes_list.dart';
import 'package:rick_morty_api/view_model/episode_view_model.dart';

class MyHomeView extends StatefulWidget {
  const MyHomeView({Key? key}) : super(key: key);

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    EpisodesViewModel ctrl = EpisodesViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text("AZShip - Rick and Morty"),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            const Tab(
              text: "All",
            ),
            Tab(
                child: Row(
              children: const [
                Text("Favorites"),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                )
              ],
            )),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [EpisodesList(), EpisodesList(favTab: true)],
      ),
    );
  }
}

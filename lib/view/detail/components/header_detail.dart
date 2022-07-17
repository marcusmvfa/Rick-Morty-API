import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/view_model/episode_view_model.dart';

class HeaderDetail extends StatelessWidget {
  HeaderDetail({Key? key}) : super(key: key);
  late EpisodesViewModel vm;
  // alreadySeen() => vm.episodeSelected.watched ? "Watched" : "";
  alreadySeen() => true ? "Watched" : "";
  @override
  Widget build(BuildContext context) {
    vm = Provider.of<EpisodesViewModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            RichText(
              text: TextSpan(
                  text: "Episode: ",
                  style: const TextStyle(
                      fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: vm.episodeSelected.name!,
                      style: const TextStyle(
                          fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                    )
                  ]),
            ),
            Text(
              vm.episodeSelected.episode!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, right: 4),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              vm.episodeSelected.airDate!,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            Card(
              elevation: !vm.episodeSelected.watched ? 5 : 1,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(children: [
                  Icon(
                    vm.episodeSelected.watched ? Icons.check : Icons.more_horiz_outlined,
                    color: vm.episodeSelected.watched ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Watched",
                    style:
                        TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

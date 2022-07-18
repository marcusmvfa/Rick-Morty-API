import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/view_model/episode_view_model.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);
  TextEditingController field = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<EpisodesViewModel>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          Expanded(
            child: TextField(
              autofocus: false,
              controller: field,
              onEditingComplete: () => viewModel.searchEpisode(field.text),
              decoration: InputDecoration(
                hintText: 'Search episode',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

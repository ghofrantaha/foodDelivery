import 'package:flutter/material.dart';
import 'package:foodapp/controllers/database_controller.dart';
import 'package:foodapp/views/widgets/search_list_item.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SearchBar(
              hintText: 'Search for food, meals ...',
              leading: const Icon(
                Icons.fastfood_outlined,
                color: Colors.deepOrangeAccent,
              ),
              onChanged: (value) => setState(() => text = value),
            ),
            const SizedBox(height: 30),
            StreamBuilder(
                stream: context.read<Database>().searchProductByTitle(text),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                      if (snapshot.data == null) {
                        return const Center(child: Text('Error Happen!'));
                      } else if (snapshot.data!.isEmpty) {
                        return text != ''
                            ? const Center(child: Text('No Data Available!'))
                            : const SizedBox();
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, int index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SearchListItem(
                                searchResult: snapshot.data![index],
                              ),
                            ),
                          ),
                        );
                      }
                    case ConnectionState.done:
                      if (snapshot.data == null) {
                        return const Center(child: Text('Error Happen!'));
                      } else if (snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Data Available!'));
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, int index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SearchListItem(
                              searchResult: snapshot.data![index],
                            ),
                          ),
                        );
                      }
                    default:
                      return const SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodapp/controllers/database_controller.dart';
import 'package:foodapp/models/product.dart';
import 'package:foodapp/views/widgets/fav_list_item.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List<Product>>(
          stream: context.read<Database>().myProductsFavorites(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final favItems = snapshot.data;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'My Favorites',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 16.0),
                      if (favItems == null || favItems.isEmpty)
                        Center(
                          child: Text(
                            'No Data Available!',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      if (favItems != null && favItems.isNotEmpty)
                        ListView.builder(
                          itemCount: favItems.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            final favItem = favItems[i];
                            return FavListItem(
                              favItem: favItem,
                            );
                          },
                        ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

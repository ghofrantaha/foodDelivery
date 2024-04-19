import 'package:flutter/material.dart';
import 'package:foodapp/utilities/media_query_extension.dart';
import 'package:foodapp/views/pages/search_page.dart';
import 'package:foodapp/views/widgets/locall_list_item_home.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/product.dart';
import '../../utilities/assets.dart';
import '../widgets/header_of_list.dart';
import '../widgets/list_item_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.asset(
                AppAssets.topBannerHomePageAsset,
                width: double.infinity,
                height: context.height * 0.3,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: context.height * 0.3,
                color: Colors.black.withOpacity(0.3),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Now',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.deepOrangeAccent,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      ),
                      child: const Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                HeaderOfList(
                  onTap: () {},
                  title: 'Offers',
                  description: 'Black friday',
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 330,
                  child: StreamBuilder<List<Product>>(
                      stream: context.read<Database>().salesProductsStream(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                                child: CircularProgressIndicator());
                          case ConnectionState.active:
                            if (snapshot.data == null) {
                              return const Center(child: Text('Error Happen!'));
                            } else if (snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('No Data Available!'));
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, int index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListItemHome(
                                    product: snapshot.data![index],
                                    isNew: false,
                                  ),
                                ),
                              );
                            }
                          case ConnectionState.done:
                            if (snapshot.data == null) {
                              return const Center(child: Text('Error Happen!'));
                            } else if (snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('No Data Available!'));
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, int index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListItemHome(
                                    product: snapshot.data![index],
                                    isNew: false,
                                  ),
                                ),
                              );
                            }
                          default:
                            return const SizedBox();
                        }
                      }),
                ),
                const SizedBox(height: 12.0),
                HeaderOfList(
                  onTap: () {},
                  title: 'New',
                  description: 'Try new restaurant',
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 330,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productsList.length,
                    itemBuilder: (_, int index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LocalListItemHome(
                        product: productsList[index],
                        isNew: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

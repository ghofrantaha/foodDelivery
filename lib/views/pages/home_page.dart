import 'package:flutter/material.dart';
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
    final size = MediaQuery.of(context).size;
    final Database database = Provider.of<Database>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                AppAssets.topBannerHomePageAsset,
                width: double.infinity,
                height: size.height * 0.3,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.3,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Text(
                  'Order Now',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                HeaderOfList(
                  onTap: () {},
                  title: 'Offers',
                  description: 'Black friday',
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 330,
                  child: StreamBuilder<List<Product>>(
                      stream: database.salesProductsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final products = snapshot.data;
                          if (products == null || products.isEmpty) {
                            return const Center(
                              child: Text('No Data Available!'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (_, int index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListItemHome(
                                product: products[index],
                                isNew: false,
                              ),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
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
                        child: ListItemHome(
                          product: productsList[index],
                          isNew: true,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
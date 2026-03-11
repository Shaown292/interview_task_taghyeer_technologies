import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../event/product_event.dart';
import '../state/product_state.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<ProductsBloc>().add(LoadProducts());

    scrollController.addListener(() {

      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {

        context.read<ProductsBloc>().add(LoadProducts());

      }

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),

      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {

          if (state.loading && state.products.isEmpty) {

            return const Center(
              child: CircularProgressIndicator(),
            );

          }

          return Column(
            children: [

              Expanded(
                child: GridView.builder(

                  controller: scrollController,

                  padding: const EdgeInsets.all(16),

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisCount: 2,

                    crossAxisSpacing: 16,

                    mainAxisSpacing: 16,

                    childAspectRatio: 0.75,

                  ),

                  itemCount: state.products.length,

                  itemBuilder: (context, index) {

                    final product = state.products[index];

                    return Container(

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius: BorderRadius.circular(16),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          )
                        ],

                      ),

                      child: Column(

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Expanded(
                            child: ClipRRect(

                              borderRadius:
                              const BorderRadius.vertical(
                                  top: Radius.circular(16)),

                              child: Image.network(
                                product.thumbnail,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(

                            padding: const EdgeInsets.all(12),

                            child: Column(

                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Container(

                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4),

                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius:
                                    BorderRadius.circular(6),
                                  ),

                                  child: Text(
                                    "\$${product.price}",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              if (state.loading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),

            ],
          );
        },
      ),
    );
  }
}
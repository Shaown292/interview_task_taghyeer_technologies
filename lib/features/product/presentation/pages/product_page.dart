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

      if(scrollController.position.pixels ==
          scrollController.position.maxScrollExtent){

        context.read<ProductsBloc>().add(LoadProducts());

      }

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Products")),

      body: BlocBuilder<ProductsBloc,ProductsState>(

        builder: (context,state){

          if(state.loading && state.products.isEmpty){

            return const Center(child: CircularProgressIndicator());

          }

          return ListView.builder(

            controller: scrollController,

            itemCount: state.products.length,

            itemBuilder: (context,index){

              final product = state.products[index];

              return Card(

                margin: const EdgeInsets.all(10),

                child: ListTile(

                  leading: Image.network(
                    product.thumbnail,
                    width: 50,
                  ),

                  title: Text(product.title),

                  subtitle: Text("\$${product.price}"),

                ),
              );
            },
          );
        },
      ),
    );
  }
}
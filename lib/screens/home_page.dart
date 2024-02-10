import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app/app.dart';
import '../models/product_model.dart';
import 'cart_screens.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDP NOUT Shop"),
        actions: [
          Badge(
            alignment: const Alignment(0.8, -0.8),
            label: StreamBuilder(
                initialData: cartController.state,
                stream: cartController.stream,
                builder: (context,_) {
                  return Text(cartController.state.item.length.toString() ?? "");
                }
            ),
            child: IconButton.filled(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
              },
              icon: const Icon(
                CupertinoIcons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: GridView.count(
          padding: const EdgeInsets.all(20),
          physics: const AlwaysScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
          children: products.map((product) {
            return DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    product.name,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 2,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${product.price}",
                                    style: Theme.of(context).textTheme.bodySmall,
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton.filled(onPressed: () {
                                cartController.addToCard(product: product, quantity: 1);
                              }, icon: const Icon(Icons.add)),
                              IconButton.filled(onPressed: () {
                                cartController.addToCard(product: product, quantity: -1);
                              }, icon: const Icon(Icons.remove)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
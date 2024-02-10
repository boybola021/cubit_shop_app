import 'package:flutter/material.dart';
import '../app/app.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: cartController.state,
        stream:  cartController.stream,
        builder: (context,snapshot){
          final cart = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: StreamBuilder(
                  stream: null,
                builder: (context,__){
                  return Text("Total: \$ ${cartController.state.total.toStringAsFixed(2)}");
                },
              ),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: cartController.state.item.length,
              itemBuilder: (context, index) {
                final cartItem = cart.item[index];
                return Card(
                  child: ListTile(
                    leading: SizedBox(
                      width: 80,
                      child: Stack(
                        children: [
                          Image(
                            image: NetworkImage(cartItem.products.imageUrl),
                            fit: BoxFit.fitWidth,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                cartItem.quantity.toString(),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    title: Text(
                      cartItem.products.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(cartItem.products.description),
                            ),
                            const SizedBox(width: 10),
                            Text(cartItem.products.price.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total: ${cartItem.total.toStringAsFixed(2)}"),
                            IconButton.filled(
                                onPressed: () {
                                  cartController.addToCard(
                                    product: cartItem.products,
                                    quantity: 1,
                                  );
                                },
                                icon: const Icon(Icons.add)),
                            IconButton.filled(
                                onPressed: () {
                                  cartController.addToCard(
                                    product: cartItem.products,
                                    quantity: -1,
                                  );
                                },
                                icon: const Icon(Icons.remove)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.payment_rounded),
            ),
          );
        }
    );
  }
}

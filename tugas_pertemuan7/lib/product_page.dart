import 'package:flutter/material.dart';
import 'package:pertemuan7/cart_model.dart';
import 'package:pertemuan7/cart_page.dart';
import 'package:provider/provider.dart';

//pakai stateless aj akarena ada provider
class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final products = [
    Product('Laptop','https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D'),
    Product('Mouse','https://images.unsplash.com/photo-1768511526475-aebb7b521580?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D'),
    Product('Monitor','https://plus.unsplash.com/premium_photo-1680721575441-18d5a0567269?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko pedia',
          style: TextStyle(
            color: Color(0xFFEFE8DD)
          )
        ),
        backgroundColor: Color(0xFFFF5722),

        actions: [
          Padding(
            padding:EdgeInsets.only(right: 20),
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                return Badge(
                  label: Text('${cart.totalItems}'),
                  isLabelVisible: cart.totalItems > 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => CartPage(), 
                        )
                      );
                    }, 
                    icon: Icon(Icons.shopping_cart, color:Color(0xFFEFE8DD) ,)
                  )
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products [index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              tileColor:Color(0xFF303841),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item.gambar,
                  fit: .cover,
                  width: 50,
                  height: 50,
                ),
              ),
              title: Text(item.nama,
                style: TextStyle(
                  color: Color(0xFFEFE8DD)
                )
              ),
              trailing: IconButton(
                onPressed: () {
                  //ini yang penting nya
                  Provider.of<CartModel>(context, listen: false).add(item);
                },
                icon: Icon(Icons.add_shopping_cart, color:Color(0xFFEFE8DD),)
              ),
            ),
          );
        },
      ),
    );
  }
}
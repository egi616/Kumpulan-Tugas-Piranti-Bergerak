import 'package:flutter/material.dart';
import 'package:pertemuan7/cart_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFFEFE8DD)
        ),
        backgroundColor: Color(0xFFFF5722),
        title: Text("Keranjang anda", 
          style: TextStyle(
            color: Color(0xFFEFE8DD)
          )
        ),
      ),
      body: Consumer <CartModel>(
        builder: (context, cart, child) {
          if(cart.items.isEmpty){
            return Text('Keranjang Kosong');
          }
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  tileColor: Color(0xFF303841),
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
                    icon: Icon(Icons.delete, color: Color(0xFFEFE8DD)),
                    onPressed:() {
                      Provider.of<CartModel>(context, listen: false).delete(item);;
                    },
                  ),
                ),
              );
            },
          );
        },
      
      )
    );
  }
}
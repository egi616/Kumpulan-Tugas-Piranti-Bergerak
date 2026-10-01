import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _HomeState();
}

class _HomeState extends State<Profile> {
  
  bool tampilkanNama = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 47, 189),
        title: Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text('My Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.waving_hand),
              color: Colors.blue,
              onPressed: (){
                setState(() {
                  tampilkanNama = true;
                });
              },
            ),

            Text('Halo nama Saya...',
              style: TextStyle(
                color: Colors.black,
              ),
            ),

            if(tampilkanNama)
              Text('Egi Jaelani Febrianysah')
          ],
        ),
      ),
    );
  }
}
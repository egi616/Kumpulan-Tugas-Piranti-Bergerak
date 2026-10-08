import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                ),
              ),

              SizedBox(height: 10),
              Text(
                'Egi Jaelani Febriansyah',
                style: GoogleFonts.inknutAntiqua(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),

              SizedBox(height: 10),
              Text(
                'Mahasiswa',
                style: GoogleFonts.inknutAntiqua(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),

              SizedBox(
                width: 250,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),

              //pakai container coba
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 10
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 172, 181, 176),
                  // borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),

                  title: Text(
                    '0830-3223-2322',
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 10
                ),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  // borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),

                  title: Text(
                    'egi616@gmail.com',
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 10
                ),
                color: const Color.fromARGB(255, 47, 140, 140),
                child: ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Colors.black,
                  ),
                  title: Text(
                    '@egi616',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              //dengan widget card
              //untuk box decoration di taruh di shape
              Card(margin: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                color: Colors.cyanAccent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black), //garis pinggir stroke
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.github,
                    color: Colors.black,
                  ),
                  title: Text(
                    textAlign: TextAlign.center,
                    'egi616',
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

            ],
          ), 
      ),
    );
  }
}
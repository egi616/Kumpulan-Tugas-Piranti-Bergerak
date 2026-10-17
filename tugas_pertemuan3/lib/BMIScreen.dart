import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BMIScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {

  //backend disini

  //mutlak
  // _ (private)
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? _hasilBMI;
  String _keterangan = "Silahkan Masukan Data Anda";

  void _hitungBMI(){

    if(jenisKelamin.isEmpty){
      setState(() {
        _hasilBMI = null;
        _keterangan = "Pilih jenis kelamin terlebih dahulu";
      });
      return;
    }

    //?? tenary
    final double bb = double.tryParse(_bbController.text) ?? 0;
    final double tbCm = double.tryParse(_tbController.text) ?? 0;

    //setState
    setState(() {
      if (bb > 0 && tbCm > 0) {
        final double tbM = tbCm / 100;
        final double hasil = bb / (tbM * tbM);

        _hasilBMI = hasil;
        String kategori = "";
        if(hasil < 18.5){
          kategori = "kurus";
        }else if(hasil < 25){
          kategori = "ideal";
        }else if(hasil < 30){
          kategori = "Gemuk";
        }else{
          kategori = "Obesitas";
        }

        _keterangan = "$kategori ($jenisKelamin)";

      }else{
        _hasilBMI = null;
        _keterangan = "Masukan data yang valid";
      }
    });
  }

  String jenisKelamin = "";
  void pilihanJenisKelamin(String jenisKelamindiPilih){
    setState(() {
      jenisKelamin = jenisKelamindiPilih;
    });
  }

  void _resetBMI(){
    setState(() {
      _bbController.clear();
      _tbController.clear();
      _hasilBMI = null;
      jenisKelamin = '';

      _keterangan = "Masukan data anda";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Kalkulator BMI',
          style: GoogleFonts.racingSansOne(
            fontSize: 30,
            fontWeight: .bold,
            letterSpacing: 4
          )
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: Icon(Icons.calculate_outlined, size: 40, color: Colors.pinkAccent,)
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(40), //supaya bisa scroll
          child: Column(
            crossAxisAlignment: .stretch, //button mengikuti layar
            children: [
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      pilihanJenisKelamin("Perempuan");
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: jenisKelamin == "Perempuan" ? Colors.pinkAccent : Colors.transparent, width: 2),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage('assets/images/p.jpg'),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),
                        Text(
                          'Perempuan',
                          style: GoogleFonts.racingSansOne(
                            color: Colors.pinkAccent,
                            fontSize: 24
                          ),
                        )
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      pilihanJenisKelamin("Laki-laki");
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: jenisKelamin == "Laki-laki" ? Colors.blueAccent : Colors.transparent, width: 2),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage('assets/images/l.jpg'),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),
                        Text(
                          'Laki-laki',
                          style: GoogleFonts.racingSansOne(
                            color: Colors.blueAccent,
                            fontSize: 24
                          ),
                        )
                      ],
                    ),
                  ),
                  
                ],
              ),
              SizedBox(height: 15,),

              TextField(
                controller: _bbController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),//supaya inputan bisa decimal
                  decoration: InputDecoration(
                    icon: FaIcon(FontAwesomeIcons.weightScale, size: 40, color: Colors.black,),
                    labelText: 'Berat badan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), 
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2
                      )
                    )
                  ),
              ),
              
              SizedBox(height: 15,),
              TextField(
                controller: _tbController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),//supaya inputan bisa decimal
                  decoration: InputDecoration(
                    icon: FaIcon(FontAwesomeIcons.rulerCombined, size: 40, color: Colors.black,),
                    labelText: 'Tinggi badan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), 
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.pinkAccent,
                        width: 2
                      )
                    )
                  ),
              ),
              
              SizedBox(height: 15,),

              ElevatedButton(
                onPressed: _hitungBMI, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: Colors.grey,
                    width: 1
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20)
                  )
                ),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.calculate, color: Colors.black),
                    SizedBox(width: 5,),
                    Text(
                      'Hitung BMI',
                      style: GoogleFonts.instrumentSans(
                        fontSize: 16,
                        color: Colors.black
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: _resetBMI, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: Colors.grey,
                    width: 1
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20)
                  )
                ),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    FaIcon(FontAwesomeIcons.x, color: Colors.black,),
                    SizedBox(width: 5,),
                    Text(
                      'Reset',
                      style: GoogleFonts.instrumentSans(
                        color: Colors.black,
                        fontSize: 16
                      ),
                    )
                  ],
                )
              ),

              SizedBox(height: 15,),
              Text(
                'Hasil: ',
                textAlign: .center,
                style: GoogleFonts.racingSansOne(
                  color: Colors.black,
                  fontSize: 24
                ),
              ),

              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: .circular(10),
                  
                ),
                child: Column(
                  children: [
                    Text(
                      _hasilBMI?.toStringAsFixed(1) ?? 'Nilai Kosong',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white
                      )
                    ),
                    Text(
                      _keterangan,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ), 
      ),
    );
  }
}
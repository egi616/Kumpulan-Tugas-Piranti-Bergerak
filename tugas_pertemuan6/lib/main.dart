import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final List<Map<String, String>> bukuData = [
  {
    'nama' : 'Fire Punch Vol 1',
    'gambar' : 'assets/images/1.jpg',
    'namaPenulis' : 'Tatsuki Fujimoto', 
    'tahunTerbit' : '2016',
    'penerbit' : 'Shueisha',
    'sinopsis' : 'Di bumi yang membeku dan hancur, Agni dan adiknya, Luna, bertahan hidup dengan kekuatan regenerasi. Tragedi dimulai saat Doma membakar desa mereka dengan api yang tak bisa padam.'
  },
  {
    'nama' : 'Fire Punch Vol 2',
    'gambar' : 'assets/images/2.webp',
    'namaPenulis' : 'Tatsuki Fujimoto', 
    'tahunTerbit' : '2016',
    'penerbit' : 'Shueisha',
    'sinopsis' : 'Dalam perjalanannya mencari Doma untuk balas dendam, Agni bertemu dengan Togata, seorang wanita misterius yang menawarkan bantuan dengan syarat Agni bersedia menjadi aktor di filmnya.'
  },
  {
    'nama' : 'Fire Punch Vol 3',
    'gambar' : 'assets/images/3.jpg',
    'namaPenulis' : 'Tatsuki Fujimoto', 
    'tahunTerbit' : '2016',
    'penerbit' : 'Shueisha',
    'sinopsis' : 'Agni akhirnya menyusup ke Behemdorg, kota tempat Doma berada. Dengan arahan sutradara Togata, Agni memulai aksi penyerangan brutal untuk membebaskan para budak di sana.'
  },

];

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Manga',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.patdary,
        appBar: AppBar(
          title: Text(
            'Daftar Buku',
            style: TextStyle(
              fontWeight: .bold,
              fontSize: 20
            ),
          ),
          centerTitle: true,
          foregroundColor: AppColor.tigadary,
          backgroundColor: AppColor.primary,
          titleSpacing: 2,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list, color: AppColor.tigadary,), text: 'List view',),
              Tab(icon: Icon(Icons.grid_on, color: AppColor.tigadary,), text: 'Grid view',)
            ]
          ),
        ),
        body: TabBarView(
          children: [
            buildListView(),
            membuatGrid()
          ] 
        ),
      ),
    );
  }
}

Widget buildListView(){
  return ListView.builder(
    itemCount: bukuData.length,
    padding: EdgeInsets.all(10),
    itemBuilder: (context, index) {
      final item = bukuData[index];
      return Card(
        elevation: 3,
        color: AppColor.secondary,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(12),
        ),
        child: InkWell(
          onTap: () => bukaDetailBuku(context, item),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              crossAxisAlignment: .center,
              children: [
                Center(
                  child: SizedBox(
                    width: 300,
                    child: AspectRatio(
                      aspectRatio: 2/3,
                      child: Image.asset(
                        item['gambar']!,
                        fit: .cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                    item['nama']!,
                    style: TextStyle(
                      color: AppColor.patdary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget membuatGrid(){
  return GridView.builder(
    padding: EdgeInsets.all(10),
    itemCount: bukuData.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.58,
    ), 
    itemBuilder: (context, index) {
      final item = bukuData[index];
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(5),
          side: BorderSide(color: AppColor.primary),
        ),
        child: InkWell(
          onTap: () => bukaDetailBuku(context, item),
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 2/3,
                child: Image.asset(
                  item['gambar']!,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(item['nama']!),
              ),
              SizedBox(height: 10,),
            ]
          ),
        ),
      );
    },
  );
}

void bukaDetailBuku(BuildContext context, Map<String, String> buku) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailBukuPage(buku: buku),
    ),
  );
}


class DetailBukuPage extends StatelessWidget {
  const DetailBukuPage({super.key, required this.buku});

  final Map<String, String> buku;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buku['nama']!),
        foregroundColor: AppColor.patdary,
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                buku['gambar']!,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Judul Buku: ${buku['nama']!}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Nama Penulis: ${buku['namaPenulis']!}',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            Text(
              'Tahun Terbit: ${buku['tahunTerbit']!}',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            Text(
              'Penerbit: ${buku['penerbit']!}',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            Text(
              'Sinopsis: ${buku['sinopsis']!}',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class AppColor {
  static const Color primary = Color(0xFF071B2B);
  static const Color secondary = Color(0xFF167D8D);
  static const Color tigadary = Color(0xFFB9E4E8);
  static const Color patdary = Color(0xFFEEEEEE);
}

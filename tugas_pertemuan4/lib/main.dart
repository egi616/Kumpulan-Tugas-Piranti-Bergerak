import 'package:flutter/material.dart';
import 'package:pertemuan4/api_service.dart';
import 'package:pertemuan4/article_model.dart';
//mengaktifkan pull to refresh di jalanin web
import 'package:flutter/gestures.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Berita',
      debugShowCheckedModeBanner: false,

      //ini juga untuk mengaktifkan pulll to refresh di web untuk mouse
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        }
      ),

      home: NewsAppScreen(),
    );
  }
}

class NewsAppScreen extends StatefulWidget {
  const NewsAppScreen({super.key});

  @override
  State<NewsAppScreen> createState() => _NewsAppScreenState();
}

class _NewsAppScreenState extends State<NewsAppScreen> {

  //fungsi late
  late Future<List<Article>> _articles = ApiService().fetchArticles();

  //controller tombol ke atas
  final ScrollController _kembaliKeAtas = ScrollController();

  //Untuk represh page
  Future<void> _tarikRefreshArticles() async{
    setState(() {
      _articles = ApiService().fetchArticles();
    });
    await _articles;
  }

  //supaya button kembali ke atas di hilangkan pas diatas
  bool _tampilKembaliKeAtas = false;
  @override
  void initState(){
    super.initState();

    _kembaliKeAtas.addListener((){
      if(_kembaliKeAtas.offset >= 400){
        if(!_tampilKembaliKeAtas){
          setState(() {
            _tampilKembaliKeAtas = true;
          });
        }
      }else{
          if(_tampilKembaliKeAtas){
            setState(() {
              _tampilKembaliKeAtas = false;
            });
          }
        }
    });
  }

  @override
  void dispose(){
    _kembaliKeAtas.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi berita dari scaffold'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      floatingActionButton: AnimatedOpacity(
        opacity: _tampilKembaliKeAtas ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          onPressed:() {
            if(_tampilKembaliKeAtas){
                _kembaliKeAtas.animateTo(
                0.0,
                duration: Duration(milliseconds: 300),
                curve: Curves.bounceIn
              );
            }
          },
          child: Icon(Icons.arrow_upward),
        ), 
      ),
      
      body: FutureBuilder<List<Article>>(
        future: _articles, 
        builder: (context, snapshot) { //snapshot untuk nunggunnya
          if(snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData){ //untuk pull refresh
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }

          final articles = snapshot.data ?? <Article>[];

          if(articles.isEmpty){
            return Center(
              child: Text('Tidak ada berita'),
            );
          }
            return RefreshIndicator(
              onRefresh: _tarikRefreshArticles,
              child: ListView.builder(
                //butuh ini untuk kembali ke atas icon
                controller: _kembaliKeAtas,
                itemCount: articles.length,

                //butuh ini untuk tarik refresh
                physics: AlwaysScrollableScrollPhysics(),

                itemBuilder: (context, index) {
                  final article = articles[index];
                
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: .stretch,
                        children: [
                          if(article.urlToImage != null)
                          Image.network(
                            article.urlToImage!,
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                
                            errorBuilder: (context, error, stackTrace) => 
                              Icon(Icons.image_not_supported)
                            ,
                          ),
                          SizedBox(height: 15,),
                          Text(
                            article.title,
                            style: TextStyle(
                              fontWeight: .bold
                            ),
                          ),
                          
                          SizedBox(height: 15,),
                          Text(
                            article.description ??  "Tidak ada deskripsi"
                          ),
                
                          
                        ],
                      ), 
                    ),
                  );
                },
              ),
            );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pertemuan8/name.dart';
import 'package:pertemuan8/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  //untuk memastikan apakah aplikasi sudah bisa dijalankan
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    //supaya semua widget di aplikasi tau ada perubahan
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // mendaftarkan provider
          create: (context) => ThemeProvider(),      
        ),
        ChangeNotifierProvider(
          // mendaftarkan provider
          create: (context) => NameProvider(),      
        ),
      ],
      child: const MyApp(),    
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //consumer untuk mendengarkan pemberitahuan dari notifylistener
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: themeProvider.themeMode,

          //3 meta data
          title: 'Pengaturan tema',
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    );
  }
}

//kalo stefull itu dinamis tapi di kelas nya sendiri
class HomePage extends StatelessWidget {
  HomePage({super.key});

  
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final colorScheme = Theme.of(context).colorScheme;

    final nameProvider = Provider.of<NameProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nameProvider.name.isEmpty?'Halo...':'Halo, ${nameProvider.name}'
        ),
        centerTitle: true,
        leading: Icon(
          isDark? Icons.dark_mode : Icons.light_mode
        ),
      ),
      body: Center(
        child: Padding(
          padding:EdgeInsets.all(20), 
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Icon(
                isDark? Icons.dark_mode : Icons.light_mode, 
              ),
              Text(
                isDark? 'dark mode' : 'light mode'
              ),
              Card(
                child: SwitchListTile(
                  //properti di ujung kiri
                  secondary: Icon(
                    isDark? Icons.dark_mode : Icons.light_mode,
                  ),
                  title: Text('Mode gelap'),
                  subtitle: Text(isDark? 'Aktif' : 'tidak Aktif'),
                  value: isDark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ),

              SizedBox(height: 10,),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Masukan nama',
                  border: OutlineInputBorder()
                
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  nameProvider.saveName(nameController.text);
                },
                child: Text('Simpan nama'),
              ),
              
            ],      
          ),
        ),
      ),
    );
  }
}
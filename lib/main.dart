import 'package:flutter/material.dart';
import 'package:keepnote/models/NoteBook_Provider/Home_Page_Provider.dart';
import 'package:keepnote/views/splash_screen.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageProvider>(
      create: (context){
        return HomePageProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'note',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashPage()
      ),
    );
  }
}


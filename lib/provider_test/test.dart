import 'package:flutter/material.dart';
import 'package:keepnote/provider_test/MyData.dart';
import 'package:provider/provider.dart';


void main()=> runApp(MyApp2());

class MyApp2 extends StatelessWidget {


  @override
  // Widget build(BuildContext context) {
  //   return Provider<Mydata>(
  //     create: (context)=>Mydata(),
  //     // data,
  //     // {
  //     //   return data;
  //     // },
  //     child: MaterialApp(
  //         debugShowCheckedModeBanner: false,
  //         title: 'note',
  //         theme: ThemeData(
  //           primarySwatch: Colors.blue,
  //         ),
  //         home: Scaffold(
  //           appBar: AppBar(
  //             title: AppbarTittleText(),
  //           ),
  //           body: Column(
  //             children: [
  //               MyTextField(),
  //               TestText(),
  //             ],
  //           ),
  //         )
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Mydata>(
      create: (context)=>Mydata(),
      // data,
      // {
      //   return data;
      // },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'note',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: AppbarTittleText(),
            ),
            body: Column(
              children: [
                MyTextField(),
                TestText(),
              ],
            ),
          )
      ),
    );
  }

}

class AppbarTittleText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text(
        Provider.of<Mydata>(context).Data
    );
  }
}

class MyTextField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newString){
        Provider.of<Mydata>(context,listen: false).changeData(newString);
      },
    );
  }
}

class TestText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        Provider.of<Mydata>(context).Data
      ),
    );
  }
}
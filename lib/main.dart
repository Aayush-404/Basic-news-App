import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String stringResponse;
  List listResponse;
  Map mapResponse;
  List listArticles;

  Future fetchData() async{
    http.Response response;
    response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=in&apiKey=c978bd1cb3604c53882edcfd909cc74f'));
    if(response.statusCode == 200){
     setState(() {
       mapResponse = json.decode(response.body);
       listArticles = mapResponse['articles'];
     });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('News App',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w600),)),
        backgroundColor: Colors.indigo,
      ),
      body:
      mapResponse==null?Container():SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                   child: Column(
                  children: [

                    Image.network(listArticles[index]['urlToImage']),
                    Text(
                      listArticles[index]['title'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,fontSize: 19.0
                      ),
                    )
                  ],
                )
                );
              },
              itemCount: listArticles==null?0:listArticles.length,
              ),
          ],
        ),
      ),
    );
  }
}

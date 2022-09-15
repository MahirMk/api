import 'dart:convert';

import 'package:apiproject/AnimalDetailsWithModel.dart';
import 'package:apiproject/models/Animal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
class AnimalModel extends StatefulWidget {

  @override
  State<AnimalModel> createState() => _AnimalModelState();
}

class _AnimalModelState extends State<AnimalModel> {

  List<Animal> alldata;

  getdata() async
  {
    Uri url = Uri.parse("https://zoo-animal-api.herokuapp.com/animals/rand/10");
    var response = await http.get(url);
    //200 ok 400 api problem 500 server error
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState((){
            alldata = json.map<Animal>((obj)=> Animal.fromJson(obj)).toList();
      });
    }
    else
    {
      print("API Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal View With Model"),
      ),
      body: (alldata!=null)?ListView.builder(
        itemCount: alldata.length,
        itemBuilder: (context,index)
        {
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>AnimalDetailsWithModel(obj: alldata[index],))
                        );
                      },
                      child: Card(
                        color: Colors.pink.shade100,
                        child: Column(
                          children: [
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.network(alldata[index].imageLink.toString(),width: 300,height: 100,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 28.0),
                                  child: Text(alldata[index].name,
                                    style: TextStyle(color: Colors.blue.shade900,fontWeight: FontWeight.w700,fontSize: 20,
                                      decoration: TextDecoration.underline,
                                      decorationStyle: TextDecorationStyle.wavy,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 28.0),
                                  child: Text(alldata[index].latinName.toString(),style: TextStyle(color: Colors.blue.shade900,fontSize: 12),),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 28.0),
                                  child: Text(alldata[index].diet.toString(),style: TextStyle(color: Colors.blue.shade900,fontSize: 6),),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ):Center(
        child: LoadingAnimationWidget.prograssiveDots(
          color: Colors.purple,
          size: 80,
        ),
      ),
    );
  }
}

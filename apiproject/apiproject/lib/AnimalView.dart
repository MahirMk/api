import 'dart:convert';

import 'package:apiproject/AnimalProject.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
class AnimalView extends StatefulWidget {

  @override
  State<AnimalView> createState() => _AnimalViewState();
}

class _AnimalViewState extends State<AnimalView> {

  Future<List> alldata;

  Future<List> getdata() async
  {
    Uri url = Uri.parse("https://zoo-animal-api.herokuapp.com/animals/rand/10");
    var response = await http.get(url);
    //200 ok 400 api problem 500 server error
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json;
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
    setState((){
      alldata = getdata();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal View"),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapshot)
        {
          if(snapshot.hasData)
          {

            if(snapshot.data.length<=0)
            {
              return Center(
                child: Text("No Data"),
              );
            }
            else
            {
              return ListView.builder(
                itemCount: snapshot.data.length,
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
                                 MaterialPageRoute(builder: (context)=>AnimalProject(
                                   txtname : snapshot.data[index]["name"].toString(),
                                   txtlatin_name : snapshot.data[index]["latin_name"].toString(),
                                   txtanimal_type : snapshot.data[index]["animal_type"].toString(),
                                   txtactive_time : snapshot.data[index]["active_time"].toString(),
                                   txtlength_min : snapshot.data[index]["length_min"].toString(),
                                   txtlength_max : snapshot.data[index]["length_max"].toString(),
                                   txtweight_min : snapshot.data[index]["weight_min"].toString(),
                                   txtweight_max : snapshot.data[index]["weight_max"].toString(),
                                   txtlifespan : snapshot.data[index]["lifespan"].toString(),
                                   txthabitat : snapshot.data[index]["habitat"].toString(),
                                   txtdiet : snapshot.data[index]["diet"].toString(),
                                   txtgeo_range : snapshot.data[index]["geo_range"].toString(),
                                   txtimage_link : snapshot.data[index]["image_link"].toString(),
                                   txtid : snapshot.data[index]["id"].toString(),
                                 )
                                 ),
                                );
                              },
                              child: Card(
                                color: Colors.purple.shade100,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Image.network(snapshot.data[index]["image_link"].toString(),width: 300,height: 100,
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
                                          child: Text(snapshot.data[index]["name"],
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
                                          child: Text(snapshot.data[index]["latin_name"],style: TextStyle(color: Colors.blue.shade900,fontSize: 12),),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 28.0),
                                          child: Text(snapshot.data[index]["diet"],style: TextStyle(color: Colors.blue.shade900,fontSize: 6),),
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
              );
            }
          }
          else
          {
            return Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: Colors.purple,
                size: 80,
              ),
            );
          }
        },
      ),
    );
  }
}

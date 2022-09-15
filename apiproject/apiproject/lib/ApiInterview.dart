import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:loading_animation_widget/loading_animation_widget.dart';
class ApiInterview extends StatefulWidget {
  @override
  State<ApiInterview> createState() => _ApiInterviewState();
}

class _ApiInterviewState extends State<ApiInterview> {

  Future<List> alldata;

  Future<List> getdata() async
  {
    Uri url = Uri.parse("https://invicainfotech.com/apicall/mydata");
    var response = await http.get(url);
    //200 ok 400 api problem 500 server error
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json["contacts"];
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
        title: Text("API INTERVIEW"),
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
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.yellow.shade900),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(5.0),
                                                    child: Image.network(snapshot.data[index]["userimage"].toString(),width: 100.0,),
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text("id : "),
                                            Text(snapshot.data[index]["id"].toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Name : ",style: TextStyle(color: Colors.black),),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 28.0),
                                              child: Text(snapshot.data[index]["name"],style: TextStyle(color: Colors.black),),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            Text("Email : ",style: TextStyle(color: Colors.black),),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 28.0),
                                              child: Container(
                                                child: FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Text(snapshot.data[index]["email"].toString(),style: TextStyle(fontSize: 12),),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            Text("Address : ",style: TextStyle(color: Colors.black),),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 28.0),
                                              child: Text(snapshot.data[index]["address"].toString()),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            Text(snapshot.data[index]["gender"].toString()),
                                            Text("/Female",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            Text("Contact No : ",style: TextStyle(color: Colors.black),),
                                            Column(
                                              children: [
                                                Text(snapshot.data[index]["mobile"].toString(),style: TextStyle(color: Colors.black),),
                                                Text(snapshot.data[index]["home"].toString(),style: TextStyle(color: Colors.black),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  width: 350,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // Background color
                                    ),
                                    onPressed: (){
                                      AlertDialog alert = new AlertDialog(
                                        title: Text("Warning!",style: TextStyle(color: Colors.white),),
                                        backgroundColor: Colors.orange,
                                        content: Text("Are you sure you want to delete record?",style: TextStyle(color: Colors.white),),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.of(context).pop();
                                          }, child: Text("Cancel",style: TextStyle(color: Colors.white),)
                                          ),
                                          TextButton(onPressed: () async{
                                            Navigator.of(context).pop();
                                          }, child: Text("Delete",style: TextStyle(color: Colors.white),)
                                          ),
                                        ],
                                      );
                                      showDialog(context: context, builder: (BuildContext context){
                                        return alert;
                                      });
                                    },
                                    child: Text("REMOVE",style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                SizedBox(height: 10,),
                              ],
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

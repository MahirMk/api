import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
class ViewProduct extends StatefulWidget {

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {

  Future<List> alldata;

  Future<List> getdata() async
  {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response = await http.get(url);
    //200 ok 400 api problem 500 server error
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json["data"];
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
        title: Center(child: Text("VIEW PRODUCT")),
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
                            child: Card(
                              color: Colors.purple.shade50,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          child: Text("PID : ",style: TextStyle(color: Colors.blue,fontSize: 20,),)),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 28.0),
                                        child: Text(snapshot.data[index]["pid"],
                                          style: TextStyle(color: Colors.blue.shade900,fontWeight: FontWeight.w700,fontSize: 20,
                                          decoration: TextDecoration.underline,
                                          decorationStyle: TextDecorationStyle.wavy,
                                        ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Name :- ",style: TextStyle(color: Colors.blue,fontSize: 30),),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 28.0),
                                        child: Text(snapshot.data[index]["pname"],style: TextStyle(color: Colors.blue.shade900,fontSize: 30),),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Quantity : ",style: TextStyle(color: Colors.blue,fontSize: 27),),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 25.0),
                                        child: Text(snapshot.data[index]["qty"],style: TextStyle(color: Colors.blue.shade900,fontSize: 25),),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Price : ",style: TextStyle(color: Colors.blue,fontSize: 25),),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 28.0),
                                        child: Container(
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Text(snapshot.data[index]["price"].toString(),style: TextStyle(fontSize: 25,color: Colors.blue.shade900),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Added Date : ",style: TextStyle(color: Colors.blue,fontSize: 20),),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 28.0),
                                        child: Text(snapshot.data[index]["added_datetime"].toString(),style: TextStyle(fontSize: 20,color: Colors.blue.shade900),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0,),
                                  Container(
                                    width: 350,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                      ),
                                      onPressed: (){},
                                      child: Text("UPDATE",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
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

                                              var id = snapshot.data[index]["pid"].toString();

                                              Uri url = Uri.parse("http://picsyapps.com/studentapi/deleteProductNormal.php");

                                              Map<String,String> params = {
                                                "pid":id
                                              };

                                              var response = await http.post(url,body: params);
                                              if(response.statusCode==200)
                                                {
                                                  var json = jsonDecode(response.body);
                                                  if(json["status"]=="true")
                                                    {
                                                      Navigator.of(context).pop();
                                                      setState((){
                                                        alldata = getdata();
                                                      });
                                                      print("Record Deleted");
                                                    }
                                                  else
                                                    {
                                                      var msg=json["message"];
                                                      print(msg);
                                                    }
                                                }



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

                                ],
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

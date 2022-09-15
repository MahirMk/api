import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
class ViewEmployee extends StatefulWidget {

  @override
  State<ViewEmployee> createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {

  Future<List> alldata;

  Future<List> getdata() async
  {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getEmployee.php");
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
        title: Center(child: Text("VIEW EMPLOYEE")),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Eid : ",style: TextStyle(color: Colors.black),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28.0),
                                      child: Text(snapshot.data[index]["eid"],style: TextStyle(color: Colors.black),),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Name : ",style: TextStyle(color: Colors.black),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28.0),
                                      child: Text(snapshot.data[index]["ename"],style: TextStyle(color: Colors.black),),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("salary : ",style: TextStyle(color: Colors.black),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28.0),
                                      child: Text(snapshot.data[index]["salary"],style: TextStyle(color: Colors.black),),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("department : ",style: TextStyle(color: Colors.black),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28.0),
                                      child: Container(
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(snapshot.data[index]["department"].toString(),style: TextStyle(fontSize: 12),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("gender : ",style: TextStyle(color: Colors.black),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28.0),
                                      child: Container(
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(snapshot.data[index]["gender"].toString(),style: TextStyle(fontSize: 12),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("added_datetime : ",style: TextStyle(color: Colors.black),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28.0),
                                      child: Text(snapshot.data[index]["added_datetime"].toString()),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0,),
                                Container(
                                  width: 350,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green.shade900,
                                    ),
                                    onPressed: (){},
                                    child: Text("UPDATE",style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Container(
                                  width: 350,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red.shade900,
                                    ),
                                    onPressed: (){
                                      AlertDialog alert = new AlertDialog(
                                        title: Text("Warning!",style: TextStyle(color: Colors.white),),
                                        backgroundColor: Colors.black,
                                        content: Text("Are you sure you want to delete record?",style: TextStyle(color: Colors.white),),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.of(context).pop();
                                          }, child: Text("Cancel",style: TextStyle(color: Colors.white),)
                                          ),
                                          TextButton(onPressed: () async{

                                            var id = snapshot.data[index]["eid"].toString();

                                            Uri url = Uri.parse("http://picsyapps.com/studentapi/deleteEmployeeNormal.php");

                                            Map<String,String> params = {
                                              "eid":id
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

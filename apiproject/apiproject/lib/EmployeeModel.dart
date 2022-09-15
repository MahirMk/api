import 'dart:convert';

import 'package:apiproject/models/Employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EmployeeModel extends StatefulWidget {

  @override
  State<EmployeeModel> createState() => _EmployeeModelState();
}

class _EmployeeModelState extends State<EmployeeModel> {

  List<Employee> alldata;

  getdata() async
  {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getEmployee.php");
    var response = await http.get(url);
    //200 ok 400 api problem 500 server error
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState((){
        alldata = json["data"].map<Employee>((obj)=> Employee.fromJson(obj)).toList();
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
        title: Text("Employee Model"),
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

                      },
                      child: Card(
                        color: Colors.pink.shade100,
                        child: Column(
                          children: [
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 28.0),
                                  child: Text(alldata[index].eid.toString(),
                                    style: TextStyle(color: Colors.blue.shade900,fontWeight: FontWeight.w700,fontSize: 30,
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
                                  child: Text(alldata[index].ename.toString(),
                                    style: TextStyle(color: Colors.blue.shade900,fontWeight: FontWeight.w700,fontSize: 30,
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
                                  child: Text(alldata[index].salary.toString(),style: TextStyle(color: Colors.blue.shade900,fontSize: 30),),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 28.0),
                                  child: Text(alldata[index].department.toString(),style: TextStyle(color: Colors.blue.shade900,fontSize: 30),),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 28.0),
                                  child: Text(alldata[index].gender.toString(),style: TextStyle(color: Colors.blue.shade900,fontSize: 30),),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 28.0),
                                  child: Text(alldata[index].addedDatetime.toString(),style: TextStyle(color: Colors.blue.shade900,fontSize: 30),),
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
        child: LoadingAnimationWidget.threeArchedCircle(
          color: Colors.purple,
          size: 80,
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:apiproject/ApiHomePage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ApiLoginPage extends StatefulWidget {

  @override
  State<ApiLoginPage> createState() => _ApiLoginPageState();
}

class _ApiLoginPageState extends State<ApiLoginPage> {

  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Image.asset("img/download.png",height: 120,),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  width: 180,
                  height: 50,
                  child: Center(child: Text("Name",style: TextStyle(color: Colors.black,fontSize: 30),)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black,width: 3.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: TextField(
                    controller: _name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(fillColor: Colors. black12, filled: true,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 10,
                            child: Icon(Icons.call,color: Colors.black,)
                        ),
                      ),
                    ),
                    style: TextStyle(color: Colors. black,fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child:  Container(
                    width: 200,
                    height: 50,
                    child: Center(child: Text("PASSWORD",style: TextStyle(color: Colors.black,fontSize: 30),))
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black,width: 3.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: TextField(
                    controller: _password,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(fillColor: Colors. black12, filled: true,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 10,
                            child: Icon(Icons.lock,color: Colors.black,)
                        ),
                      ),
                    ),
                    style: TextStyle(color: Colors. black,fontWeight: FontWeight.bold),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: 70,),
              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: Colors.black,width: 3.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: GestureDetector(
                    onTap : () async{

                      var name = _name.text.toString();
                      var password = _password.text.toString();

                      Uri url = Uri.parse("https://begratefulapp.ca/api/login");

                      Map<String,String> params = {
                        "name": name,
                        "password": password,
                        "device_token":"12345678",
                        "device_os":"android"
                      };

                      Map<String,String> headers = {
                        "Content-Type": "application/json",
                      };


                      var response = await http.post(url,body: jsonEncode(params),headers: headers);

                      if(response.statusCode==200)
                        {
                          var json = jsonDecode(response.body);
                          if(json["result"]=="success")
                            {

                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              prefs.setString("name", name);
                              prefs.setString("password", password);
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder:(context)=>ApiHomePage())
                              );

                              print("Login Successfull");

                              var id = json["data"]["id"].toString();
                              var txtname = json["data"]["name"].toString();
                              var txtemail = json["data"]["email"].toString();
                              var emailvf = json["data"]["email_verified_at"].toString();
                              var user = json["data"]["user_session_token"].toString();
                              var dtoken = json["data"]["device_token"].toString();
                              var dos = json["data"]["device_os"].toString();
                              var passwordlock = json["data"]["password_lock"].toString();
                              var gratitude = json["data"]["gratitude"].toString();
                              var gratitudetime = json["data"]["gratitude_time"].toString();
                              var gratitudereschedule = json["data"]["gratitude_reschedule_time"].toString();
                              var servergratitudetime = json["data"]["server_gratitude_time"].toString();
                              var servergratitudereschedule = json["data"]["server_gratitude_reschedule_time"].toString();
                              var affirmation = json["data"]["affirmation"].toString();
                              var affirmationtime = json["data"]["affirmation_time"].toString();
                              var serveraffirmationtime = json["data"]["server_affirmation_time"].toString();
                              var status = json["data"]["status"].toString();
                              var versiontype = json["data"]["version_type"].toString();
                              var group = json["data"]["group"].toString();
                              var version = json["data"]["version"].toString();
                              var timezone = json["data"]["time_zone"].toString();
                              var ipaddress = json["data"]["ip_address"].toString();
                              var createdat = json["data"]["created_at"].toString();
                              var updatedat = json["data"]["updated_at"].toString();
                              var lastloginat = json["data"]["last_login_at"].toString();
                              var experiencesubmit = json["data"]["experience_submit"].toString();
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              pref.setString("fid", id);
                              pref.setString("isname", txtname);
                              pref.setString("femail", txtemail);
                              pref.setString("fvf", emailvf);
                              pref.setString("fuser", user);
                              pref.setString("fdtoken", dtoken);
                              pref.setString("fdos", dos);
                              pref.setString("password", passwordlock);
                              pref.setString("gtitude", gratitude);
                              pref.setString("gtitudetime", gratitudetime);
                              pref.setString("sgtitude", gratitudereschedule);
                              pref.setString("server", servergratitudetime);
                              pref.setString("servergtitude", servergratitudereschedule);
                              pref.setString("opaffir", affirmation);
                              pref.setString("affirtime", affirmationtime);
                              pref.setString("serveraffir", serveraffirmationtime);
                              pref.setString("isstatus", status);
                              pref.setString("isversion", versiontype);
                              pref.setString("isgroup", group);
                              pref.setString("fversion", version);
                              pref.setString("zone", timezone);
                              pref.setString("ipadd", ipaddress);
                              pref.setString("ipcreate", createdat);
                              pref.setString("ipupdate", updatedat);
                              pref.setString("iplogin", lastloginat);
                              pref.setString("ipsubmit", experiencesubmit);

                              pref.setString("islogin", "yes");

                              Fluttertoast.showToast(
                                  msg: "Your Name And Password is correct",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=>ApiHomePage())
                              );
                            }
                            else
                            {
                              Fluttertoast.showToast(
                                  msg: "Your Name And Password is Incorrect",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              print("Login Failed!");
                            }
                        }
                    },
                    child: Center(child: Text("LOGIN",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),))
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:apiproject/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductModel extends StatefulWidget {

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  List<Product> alldata;

  getdata() async
  {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response = await http.get(url);
    //200 ok 400 api problem 500 server error
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState((){
        alldata = json["data"].map<Product>((obj)=> Product.fromJson(obj)).toList();
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
        title: Text("Product Model"),
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
                                Container(
                                  child: Text(alldata[index].pid.toString(),
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
                                  child: Text(alldata[index].pname.toString(),
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
                                  child: Text(alldata[index].qty.toString(),style: TextStyle(color: Colors.blue.shade900,fontSize: 30),),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 28.0),
                                  child: Text(alldata[index].price.toString(),style: TextStyle(color: Colors.blue.shade900,fontSize: 30),),
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
      ):Center(child: CircularProgressIndicator()),
    );
  }
}

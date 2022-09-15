import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class AddProduct extends StatefulWidget {

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("ADD PRODUCT")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 120,),
            Text("Name",style: TextStyle(fontSize: 30,)),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue,width: 3.0),
                  boxShadow: [
                    BoxShadow(color: Colors.yellow.shade200, blurRadius: 5.0, spreadRadius: 0.4)
                  ],
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
                  decoration: InputDecoration(fillColor: Colors. white, filled: true,border: InputBorder.none,),
                  style: TextStyle(color: Colors. black,fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            Text("Quantity",style: TextStyle(fontSize: 30)),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue,width: 3.0),
                  boxShadow: [
                    BoxShadow(color: Colors.yellow.shade200, blurRadius: 5.0, spreadRadius: 0.4)
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: TextField(
                  controller: _qty,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(fillColor: Colors. white, filled: true,border: InputBorder.none,),
                  style: TextStyle(color: Colors. black,fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            Text("Price",style: TextStyle(fontSize: 30)),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue,width: 3.0),
                  boxShadow: [
                    BoxShadow(color: Colors.yellow.shade200, blurRadius: 5.0, spreadRadius: 0.4)
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: TextField(
                  controller: _price,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(fillColor: Colors. white, filled: true,border: InputBorder.none,),
                  style: TextStyle(color: Colors. black,fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            SizedBox(height: 60,),
            Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 3.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Center(child:
                GestureDetector(
                  onTap: () async{
                    var name = _name.text.toString();
                    var qty = _qty.text.toString();
                    var price = _price.text.toString();
                    
                    Uri url = Uri.parse("http://picsyapps.com/studentapi/insertProductNormal.php");

                    Map<String,String> params ={
                      "pname":name,
                      "qty":qty,
                      "price":price
                    };

                    var response = await http.post(url,body: params);
                    if(response.statusCode==200)
                      {
                        var json = jsonDecode(response.body);
                        if(json["status"]=="true")
                          {
                            var msg = json["message"];
                            print(msg);
                          }
                        else
                          {
                            var msg = json["message"];
                            print(msg);
                          }
                        _name.text="";
                        _qty.text="";
                        _price.text="";
                      }
                  },
                  child: Text("Submit",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold))
                  ),
                ),
            ),
            SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }
}

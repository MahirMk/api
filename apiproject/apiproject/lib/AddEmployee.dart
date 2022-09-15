import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddEmployee extends StatefulWidget {

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {

  TextEditingController _name = TextEditingController();
  TextEditingController _salary = TextEditingController();
  TextEditingController _gender = TextEditingController();

  var grpvalue = "M";
  var select = "e1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("ADD EMPLOYEE")),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0,top: 20.0),
              child: Text("Name"),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _name,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,color: Colors.yellow),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0,top: 20.0),
              child: Text("Salary"),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _salary,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,color: Colors.yellow),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("Gender"),
            ),
            Row(
              children: [

                Container(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text("Male"),
                ),
                Radio(
                  value: "M",
                  groupValue: grpvalue,
                  onChanged: (val)
                  {
                    setState(() {
                      grpvalue=val;
                    });
                  },
                ),
                Text("Female"),
                Radio(
                  value: "F",
                  groupValue: grpvalue,
                  onChanged: (val)
                  {
                    setState(() {
                      grpvalue=val;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: DropdownButton(
                  value: select,
                  onChanged: (val)
                  {
                    setState(() {
                      select = val;
                    });
                  },
                  items:[
                    DropdownMenuItem(
                      child: Text("1"),
                      value: "e1",
                    ),
                    DropdownMenuItem(
                      child: Text("2"),
                      value: "e2",
                    ),
                    DropdownMenuItem(
                      child: Text("3"),
                      value: "e3",
                    ),
                    DropdownMenuItem(
                      child: Text("4"),
                      value: "e4",
                    ),
                    DropdownMenuItem(
                      child: Text("5"),
                      value: "e5",
                    ),
                  ]
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {


                  var txtname = _name.text.toString();
                  var txtsalary = _salary.text.toString();
                  var txtdepartment = select.toString();
                  var txtgender = grpvalue.toString();

                  Uri url = Uri.parse("http://picsyapps.com/studentapi/insertEmployeeNormal.php");

                  Map<String,String> params ={
                    "ename":txtname,
                    "salary":txtsalary,
                    "department":txtdepartment,
                    "gender":txtgender,
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
                    _salary.text="";
                     select="";
                     grpvalue="";
                  }
                },
                child: Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

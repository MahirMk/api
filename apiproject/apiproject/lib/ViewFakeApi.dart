import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ViewFakeApi extends StatefulWidget {

  @override
  State<ViewFakeApi> createState() => _ViewFakeApiState();
}

class _ViewFakeApiState extends State<ViewFakeApi> {

  Future<List> alldata;

  Future<List> getdata() async
  {
    Uri url = Uri.parse("https://fakestoreapi.com/products");
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
        title: Text("Fake Api"),
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
                      return ListTile(
                        leading: Image.network(snapshot.data[index]["image"].toString()),
                        title: Text(snapshot.data[index]["title"].toString()),
                        subtitle: Text(snapshot.data[index]["rating"]["rate"].toString()),
                      );
                    },
                  );
                }
            }
          else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },
      ),
    );
  }
}

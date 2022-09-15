import 'package:flutter/material.dart';

class AnimalProject extends StatefulWidget {

  var txtname="";
  var txtlatin_name="";
  var txtanimal_type="";
  var txtactive_time="";
  var txtlength_min="";
  var txtlength_max="";
  var txtweight_min="";
  var txtweight_max="";
  var txtlifespan="";
  var txthabitat="";
  var txtdiet="";
  var txtgeo_range="";
  var txtimage_link="";
  var txtid="";

  AnimalProject({this.txtname,this.txtlatin_name,this.txtanimal_type,
    this.txtactive_time,this.txtlength_min,this.txtlength_max,this.txtlifespan,this.txtweight_min,this.txtweight_max,
    this.txthabitat,this.txtdiet,this.txtgeo_range,this.txtimage_link,this.txtid});

  @override
  State<AnimalProject> createState() => _AnimalProjectState();
}

class _AnimalProjectState extends State<AnimalProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal Project"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("img/forest.jpg"),
              fit: BoxFit.cover,
              opacity: 200.0,
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Center(child: Image.network(widget.txtimage_link,width: 300,)),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ID :- ",style: TextStyle(fontSize: 30)),
                    Text(widget.txtid,style: TextStyle(fontSize: 30)
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name :- ",style: TextStyle(fontSize: 30)),
                    Text(widget.txtname,style: TextStyle(fontSize: 30)
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Latin Name :- ",style: TextStyle(fontSize: 30)),
                    Expanded(
                      child: Text(widget.txtlatin_name,style: TextStyle(fontSize: 30)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Animal Type :- ",style: TextStyle(fontSize: 30)),
                    Expanded(
                      child: Text(widget.txtanimal_type,style: TextStyle(fontSize: 30)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Text(widget.txtactive_time,style: TextStyle(fontSize: 30)),
                SizedBox(height: 10,),
                Text(widget.txtlength_min,style: TextStyle(fontSize: 30)),
                SizedBox(height: 10,),
                Text(widget.txtlength_max,style: TextStyle(fontSize: 30)),
                SizedBox(height: 10),
                Text(widget.txtlifespan,style: TextStyle(fontSize: 30),),
                SizedBox(height: 10,),
                Text(widget.txtweight_min,style: TextStyle(fontSize: 30)),
                SizedBox(height: 10,),
                Text(widget.txtweight_max,style: TextStyle(fontSize: 30)),
                SizedBox(height: 10,),
                Text(widget.txthabitat,style: TextStyle(fontSize: 30)),
                SizedBox(height: 10,),
                Text(widget.txtdiet,style: TextStyle(fontSize: 30)),
                SizedBox(height: 10,),
                Text(widget.txtgeo_range,style: TextStyle(fontSize: 30)),
                SizedBox(height: 200,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

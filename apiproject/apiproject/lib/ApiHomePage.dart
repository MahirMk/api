import 'package:apiproject/AnimalModel.dart';
import 'package:apiproject/AnimalView.dart';
import 'package:apiproject/ApiInterview.dart';
import 'package:apiproject/ApiLoginPage.dart';
import 'package:apiproject/EmployeeModel.dart';
import 'package:apiproject/ProductModel.dart';
import 'package:apiproject/ViewFakeApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'AddEmployee.dart';
import 'AddProduct.dart';
import 'ViewEmployee.dart';
import 'ViewProduct.dart';

class ApiHomePage extends StatefulWidget {

  @override
  State<ApiHomePage> createState() => _ApiHomePageState();
}

class _ApiHomePageState extends State<ApiHomePage> {

  String _scanBarcode = 'Unknown';

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }


  var opname="";
  var email="";
  var username="";
  var uid="";
  var opemailver="";
  var txtusersession="";
  var txttoken="";
  var dos="";
  var fgratitude="";
  var fgratitudetime="";
  var txtrerescheduletime="";
  var servertime="";
  var txtstatus="";
  var txtversiontype="";
  var txtgroup="";
  var txtversion="";
  var txttimezone="";
  var txtaddress="";
  var txtcreated="";
  var txtupdated="";
  var lastlogin="";
  var txtexperience="";
  var srescheduletime="";
  var opaffirmation="";
  var txtaffirmationtime="";
  var saffirmationtime="";

  getdata() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      opname=prefs.getString("isname");
      email=prefs.getString("femail");
      username=prefs.getString("fuser");
      uid= prefs.getString("fid");
      opemailver=prefs.getString("fvf");
      txttoken=prefs.getString("fdtoken");
      dos=prefs.getString("fdos");
      fgratitude=prefs.getString("gtitude");
      fgratitudetime=prefs.getString("gtitudetime");
      txtrerescheduletime=prefs.getString("sgtitude");
      servertime=prefs.getString("server");
      srescheduletime=prefs.getString("servergtitude");
      opaffirmation=prefs.getString("opaffir");
      txtaffirmationtime=prefs.getString("affirtime");
      saffirmationtime=prefs.getString("serveraffir");
      txtstatus=prefs.getString("isstatus");
      txtversiontype=prefs.getString("isversion");
      txtgroup=prefs.getString("isgroup");
      txtversion=prefs.getString("fversion");
      txttimezone=prefs.getString("zone");
      txtaddress=prefs.getString("ipadd");
      txtcreated=prefs.getString("ipcreate");
      txtupdated=prefs.getString("ipupdate");
      lastlogin=prefs.getString("iplogin");
      txtexperience=prefs.getString("ipsubmit");
    });
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
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(opname),
              GestureDetector(
                onTap: (){
                  AlertDialog alert = new AlertDialog(
                    title: Container(child: Text("Warning!",style: TextStyle(color: Colors.white),)),
                    backgroundColor: Colors.green,
                    content: Text("Are you sure you want to delete record?",style: TextStyle(color: Colors.white)),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      },
                        child: Text("Cancel",style: TextStyle(color: Colors.white),),
                      ),
                      TextButton(onPressed: () async{

                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>ApiLoginPage())
                          );

                        Fluttertoast.showToast(
                            msg: "LogOut",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }, child: Text("LogOut",style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (BuildContext context){
                    return alert;
                  });
                },
                child: Center(child:  Icon(Icons.logout_outlined)),
              ),
              // IconButton(onPressed: () async{
              //   SharedPreferences prefs = await SharedPreferences.getInstance();
              //   prefs.clear();
              //   Navigator.of(context).pop();
              //   Navigator.of(context).push(
              //       MaterialPageRoute(builder: (context)=>ApiLoginPage())
              //   );
              // },
              //     icon: Icon(Icons.logout_outlined)
              // ),
            ],
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.api),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
         color: Colors.purple.shade50,
          child: ListView(
            children: [
              Image.asset("img/download.png",width: 50,),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>AddProduct())
                    );
                  },
                  child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red,width: 2)
                      ),
                      child: Center(child: Text("ADD PRODUCT",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900),))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>ViewProduct())
                    );
                  },
                  child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red,width: 2)
                      ),
                      child: Center(child: Text("VIEW PRODUCT",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900),))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>ProductModel())
                    );
                  },
                  child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red,width: 2)
                      ),
                      child: Center(child: Text("MODEL PRODUCT",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900),))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>AddEmployee())
                    );
                  },
                  child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red,width: 2)
                      ),
                      child: Center(child: Text("ADD EMPLOYEE",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900),))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>ViewEmployee())
                    );
                  },
                  child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red,width: 2)
                      ),
                      child: Center(child: Text("VIEW EMPLOYEE",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900),))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>EmployeeModel())
                    );
                  },
                  child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red,width: 2)
                      ),
                      child: Center(child: Text("MODEL EMPLOYEE",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900),))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>ViewFakeApi())
                    );
                  },
                  child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink.shade900,width: 2)
                      ),
                      child: Center(child: Text("VIEW FAKE API",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900),))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>ApiInterview())
                    );
                  },
                  child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink.shade900,width: 2)
                      ),
                      child: Center(child: Text("API INTERVIEW",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900),))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>AnimalView())
                    );
                  },
                  child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink.shade900,width: 2)
                      ),
                      child: Center(child: Text("ANIMAL VIEW",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900),))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>AnimalModel())
                    );
                  },
                  child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink.shade900,width: 2)
                      ),
                      child: Center(child: Text("ANIMAL VIEW MODEL",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900),))
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.purple.shade50,
            child: Column(
              children: [
                SizedBox(height: 15,),
                Text(email),
                Text(username),
                Text(uid),
                Text(opemailver),
                Text(txttoken),
                Text(dos),
                Text(fgratitude),
                Text(fgratitudetime),
                Text(txtrerescheduletime),
                Text(servertime),
                Text(srescheduletime),
                Text(opaffirmation),
                Text(txtaffirmationtime),
                Text(saffirmationtime),
                Text(txtstatus),
                Text(txtversiontype),
                Text(txtgroup),
                Text(txtversion),
                Text(txttimezone),
                Text(txtaddress),
                Text(txtcreated),
                Text(txtupdated),
                Text(lastlogin),
                Text(txtexperience),
                SizedBox(height: 20,),
                Builder(builder: (BuildContext context) {
                  return Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 16,),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)
                            ),
                            child: GestureDetector(
                                onTap: () => scanQR(),
                                child: Center(
                                    child: Text('Start QR Scan',style: TextStyle(color: Colors.white,fontSize: 20),)
                                ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Text(_scanBarcode.contains("https") || _scanBarcode.contains("http") ? _scanBarcode : "Invalid URL",style: TextStyle(color: Colors.white),),
                          // Text('Scan result : $_scanBarcode\n',
                          //     style: TextStyle(fontSize: 20,color: Colors.blue)
                          // ),
                          SizedBox(height: 16,),
                        ]
                    ),
                  );
                }
                ),

                Center(
                  child: Container(
                    color: Colors.white,
                    height: 200,
                    child: SfBarcodeGenerator(
                      value: 'https://kids.nationalgeographic.com/',
                      symbology: QRCode(),
                      showValue: true,
                      textSpacing: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

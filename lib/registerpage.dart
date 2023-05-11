import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:login_page/loginpage.dart';

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {

  TextEditingController usern=TextEditingController();
  TextEditingController pas=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();

   final keys=GlobalKey<FormState>();
  var check=false;

  Future<void> submitdata() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text ('New Register',style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic),),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assetimage/registerbg.jpg'),
              fit: BoxFit.fill,
            )
        ),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: keys,
          child: SingleChildScrollView(
            child: Column(
              children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assetimage/registeration.jpg'),
                      fit: BoxFit.fill,
                    )
                ),

        height: MediaQuery.of(context).size.height-530),
                SizedBox(height: 20,),
                TextFormField(
                  controller: usern,
                  validator: (value) {
                    if (value==null || value.isEmpty){
                      return 'username is required';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'User name',
                    labelStyle: TextStyle(color: Colors.black87,fontStyle: FontStyle.italic,fontSize: 19,fontWeight: FontWeight.bold),
                    prefixIcon: Icon(Icons.person,color: Colors.black87),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(width: 3,color: Colors.white)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                  ),
                ),),
                SizedBox(height: 15,),
                TextFormField(
                  controller: pas,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is Required';
                    }
                    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                    RegExp regExp = new RegExp(pattern);
                    var match= regExp.hasMatch(value);
                    if(value.length <8 ){
                      return 'Please Enter 8 charter';
                    }
                    else{
                      if(match==false){
                        return 'Enter the strong password';
                      }
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 19,fontWeight: FontWeight.bold),
                    prefixIcon: Icon(Icons.lock,color: Colors.black87,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(width: 2)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is Required';
                    }
                    if(!value.contains('@gmail.com')){
                      return 'Email is not Valid';
                    }

                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 19,fontWeight: FontWeight.bold),
                    prefixIcon: Icon(Icons.email,color: Colors.black87),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(width: 3,color: Colors.white)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                    ),

                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Moblie is required';
                    }
                    if(value.length <10 || value.length>10){
                      return 'Please Enter The Valid Mobile Number';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Mobile No',
                    labelStyle: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 19,fontWeight: FontWeight.bold),
                    prefixIcon: Icon(Icons.call,color: Colors.black87),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(width: 3,color: Colors.white)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: check,
                      onChanged: ( bool? value){
                        setState(() {
                          check=value!;
                        });
                      },
                    ),
                    Center(child: Text('I agree to the tems',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
                  ],
                ),
                SizedBox(height: 10,),
                IgnorePointer(
                  ignoring: !check,
                  child: Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (keys.currentState!.validate()) {
                            var submitdata = {
                              'uname': usern.text,
                              'pass': pas.text,
                              'mob': phone.text,
                              'email': email.text
                            };
                            var response = await http.post(
                                Uri.parse(
                                    'https://ntce.000webhostapp.com/api.php'),
                                body: jsonEncode(submitdata)
                            );
                            if (response.statusCode == 200) {
                              var data= await jsonDecode(response.body);
                              if (data['status']==1) {
                                print(response.body);
                                Get.defaultDialog(
                                  title: 'Regitretion successful',
                                  middleText: '',
                                  titlePadding: EdgeInsets.only(top: 40),
                                  titleStyle: TextStyle(fontSize: 17,color: Colors.black,fontStyle: FontStyle.italic),
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  actions: [
                                    ElevatedButton(onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
                                    }, child: Text('Ok'))
                                  ]
                                );
                              }
                            } else {
                              print('something went wrong');
                            }
                          }
                        },
            child: Text('REGISTER',style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic),),
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

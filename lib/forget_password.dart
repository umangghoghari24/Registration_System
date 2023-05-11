import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_page/loginpage.dart';
import 'package:http/http.dart' as http;

class forgetpassword extends StatefulWidget {
  const forgetpassword({Key? key}) : super(key: key);

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {

  final forgetkey=GlobalKey<FormState>();

  TextEditingController forgetpass=TextEditingController();
  TextEditingController newpass=TextEditingController();
  TextEditingController confimepass=TextEditingController();

  var passnotvisible=true;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget password',
            style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assetimage/forgetbg.jpg'),
              fit: BoxFit.fill,
            )
        ),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: forgetkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assetimage/password.jpg'),
                        fit: BoxFit.fill,
                      )
                  ),
                  height: MediaQuery.of(context).size.height-500,
                ),
                SizedBox(height: 15,),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: forgetpass,
                  validator: (value) {
                    if (value==null || value.isEmpty){
                      return 'Username is wrong';
                    }
                  },
                    decoration: InputDecoration(
                      labelText: 'Enter user name',
                      labelStyle: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 19),
                      prefixIcon: Icon(Icons.person,color: Colors.black87,size: 30,),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide: BorderSide(width: 3,color: Colors.white)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                    )
                ),
                SizedBox(height: 10,),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: newpass,
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
                      labelText: 'Enter new password',
                      labelStyle: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 19),
                      prefixIcon: Icon(Icons.lock,color: Colors.black87,size: 28,),
                        suffixIcon: IconButton(
                          icon: Icon(passnotvisible?Icons.visibility:Icons.visibility_off),color: Colors.black,
                          onPressed: (){
                            setState(() {
                              passnotvisible=!passnotvisible;
                            });
                          },
                        ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide: BorderSide(width: 3,color: Colors.white)
                      ),
                        enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                    )
                ),
                SizedBox(height: 10,),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: confimepass,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is wrong';
                    }
                    if (value!=newpass.text) {
                      return 'password is not match';
                    }
                  },
                    decoration: InputDecoration(
                      labelText: 'Confime password',
                      labelStyle: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 19),
                      prefixIcon: Icon(Icons.lock,color: Colors.black87,size: 30,),
                      suffixIcon: IconButton(
                        icon: Icon(passnotvisible?Icons.visibility:Icons.visibility_off),color: Colors.black,
                        onPressed: (){
                          setState(() {
                            passnotvisible=!passnotvisible;
                          });
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide: BorderSide(width: 3,color: Colors.white)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                    ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: () async {
                  if (forgetkey.currentState!.validate()) {
                    var forgetdata = {
                      'uname': forgetpass.text,
                      'pass': newpass.text,
                    };
                    var response = await http.post(
                        Uri.parse('https://ntce.000webhostapp.com/forget.php'),
                        body: jsonEncode(forgetdata)
                    );
                    if (response.statusCode == 200) {
                      var data= await jsonDecode(response.body);
                      if (data['status']==1) {
                        print(response.body);
                      }
                    } else {
                      print('Password is not match');
                    }
                  }
                },
                  child: Text('FORGET',
                    style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:login_page/change_password.dart';
import 'package:login_page/forget_password.dart';
import 'package:login_page/home.dart';
import 'package:login_page/registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:image/image.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController usname=TextEditingController();
  TextEditingController password= TextEditingController();

  final key= GlobalKey<FormState>();
  var passnotvisible=true;




  void login() async {
 //    if (usname.text=='umang' && password.text=='1010'){
 // final SharedPreferences preferences = await SharedPreferences.getInstance();
 // preferences.setString('usname', usname.text.toString());
 // preferences.setString('password', password.text.toString());
 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
 //    }
 //    else
 //      {
 //        print('Invalid input');
 //      }
  }
  Future<void> loginpage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var getusname= await preferences.getString('usname');
    if(getusname!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginpage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(child: Text('SIGN IN',style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic),)),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assetimage/signin.jpg')
              ,fit: BoxFit.fill),
        ),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assetimage/signup.jpg'),
                        fit: BoxFit.fill,
                      )
                  ),
                  height: MediaQuery.of(context).size.height-510,
                ),
                SizedBox(height: 30,),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: usname,
                  validator: (value) {
                    if (value==null || value.isEmpty){
                      return 'username is required';
                    }
                  },
                    decoration: InputDecoration(
                      labelText: 'User name',
                      labelStyle: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 20),
                      prefixIcon: Icon(Icons.person,color: Colors.black87,size: 32,),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide: BorderSide(width: 3, color: Colors.white)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(45.0),
                    ),
                    )
                ),
                SizedBox(height: 20,),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: password,
                  validator: (value) {
                    if (value==null || value.isEmpty){
                      return 'password is required';
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
                      labelStyle: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 20),
                      prefixIcon: Icon(Icons.lock,color: Colors.black87,size: 27,),
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
                        BorderSide(width: 2, color: Colors.white,),
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                  ),
                   ),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>forgetpassword()));
                },
                    child: Padding(
                      padding:  EdgeInsets.only(left: 240),
                      child: Text('Forget password',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                    )),
                SizedBox(height: 15,),
                Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      if(key.currentState!.validate()){
                      var submitdata = {
                        'uname': usname.text,
                        'pass': password.text,
                      };
                      var response = await http.post(
                          Uri.parse('https://ntce.000webhostapp.com/login.php'),
                          body: jsonEncode(submitdata));
                      if (response.statusCode == 200) {
                        var data= await jsonDecode(response.body);
                        if (data['status']==1) {
                          Get.defaultDialog(
                            title: 'Sign in Successful🥳',
                            titlePadding: EdgeInsets.only(top: 10),
                            titleStyle: TextStyle(fontSize: 22,color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,),
                            radius: 15,
                            middleText: '',
                            backgroundColor: Colors.white,
                            actions: [
                              ElevatedButton(onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
                              }, child: Text('Ok'))
                              // TextButton(onPressed: () {
                              //   //   Navigator.pop(context);

                              // },
                              //     child: Text('ok'))
                            ],
                          );
                          final SharedPreferences preferences = await SharedPreferences.getInstance();
                          preferences.setString('usname', usname.text.toString());
                          preferences.setString('password', password.text.toString());
                       //   Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));

                       // print(response.body);
                      } else {
                          Get.defaultDialog(
                            title: 'Invalid username password',
                            middleText: 'Try Again😣',middleTextStyle: TextStyle(fontSize: 17,color: Colors.red,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                            titlePadding: EdgeInsets.only(top: 30),
                            titleStyle: TextStyle(fontSize: 20,color: Colors.red,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                            radius: 15,
                            backgroundColor: Colors.white,
                          );
                        }
                       }
                      }
                      if (key.currentState!.validate()) {
                        login();
                      }
                    },

                  child: Text('SIGN IN',style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.bold),),
                  )
                ),
                Container(
                  child: ElevatedButton(

                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>registerpage()));
                    },
                    child: Text('REGISTER',style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.bold),),
                  )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

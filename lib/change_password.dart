import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_page/loginpage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class changepassword extends StatefulWidget {
  const changepassword({Key? key}) : super(key: key);

  @override
  State<changepassword> createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {

  final changekey=GlobalKey<FormState>();

  TextEditingController currentpass=TextEditingController();
  TextEditingController newpass=TextEditingController();
  TextEditingController confimepass=TextEditingController();

  var passwordnotvisible=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Change password',
            style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assetimage/passchange.jpg'),
              fit: BoxFit.cover,
            )
        ),
        height: MediaQuery.of(context).size.height,

        child: Form(
          key: changekey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assetimage/changepasswords.png'),
                        fit: BoxFit.fill,
                      )
                  ),
                  height: MediaQuery.of(context).size.height-380,
                ),
                SizedBox(height: 2,),
             //   Text('Change Your Password',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(height: 7,),
                TextFormField(
                    textAlign: TextAlign.center,
                    controller: currentpass,
                    validator: (value) {
                      if (value==null || value.isEmpty){
                        return 'Username is wrong';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Current password',
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
                    textAlign: TextAlign.center,
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
                        icon: Icon(passwordnotvisible?Icons.visibility:Icons.visibility_off),color: Colors.black,
                        onPressed: (){
                          setState(() {
                            passwordnotvisible=!passwordnotvisible;
                          });
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide: BorderSide(width: 4,color: Colors.white)
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
                  textAlign: TextAlign.center,
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
                      icon: Icon(passwordnotvisible?Icons.visibility:Icons.visibility_off),color: Colors.black,
                      onPressed: (){
                        setState(() {
                          passwordnotvisible=!passwordnotvisible;
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
          if (changekey.currentState!.validate()) {
            var changedata = {
              'name':currentpass.text,
              'number':newpass.text,
              'password' :confimepass.text
            };
            var response = await http.post(
                Uri.parse('https://creditpost.000webhostapp.com/api.php'),
                body: jsonEncode(changedata)
            );
            if (response.statusCode == 200) {
              var data= await jsonDecode(response.body);
              print(response.body);
              if (data['status']==1) {
                Get.defaultDialog(
                    title: 'Password is Change',
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
                print(response.body);
              }
            } else {
              print('Password is not match');
            }
          }
        },
          child: Text('SUBMIT',
            style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),))
              ],
            ),
          ),
        ),
      ),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:login_page/change_password.dart';
import 'package:login_page/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  String useurn='';

  Future<void> getdata() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var getusname= await preferences.getString('usname');

    setState(() {
      useurn=getusname.toString();
    });
  }
  Future<void> removedata() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var getusname= await preferences.remove('usname');

    setState(() {
      useurn=getusname.toString();
    });
  }

  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),

        actions: [
          IconButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>changepassword()));
          },
              icon: Icon(Icons.more_vert)),
          ElevatedButton(onPressed: () {
            removedata();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
          },
              child: Text('Logout'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 170,),
            Text('welcome',style: TextStyle(fontSize: 25,color: Colors.green),),
            Center(child: Text(useurn!)),
          ],
        ),
      ),

    );
  }
}

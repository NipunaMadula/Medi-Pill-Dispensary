import 'package:flutter/material.dart';

class Regedter extends StatelessWidget {
  const Regedter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/bill.jpg'),
        fit: BoxFit.cover,
        opacity: 150,
      )),
      child: Scaffold(
        appBar: AppBar(
        title: const Text(
          "Medi Pill",
          style: TextStyle(
            color: Color.fromARGB(255, 7, 7, 7), // Black color
            fontWeight: FontWeight.bold,
            fontSize: 30, // Bold text
          ),
        ),
        backgroundColor: Color.fromARGB(255, 92, 89, 82),
        centerTitle: true,
      ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /*Container(
                  height: 130,
                  child: Image.asset('images/ttt.jpg'),
                ),*/
             
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Register Form',style: TextStyle(fontSize: 30,
                  fontWeight: FontWeight.bold , color: Color.fromARGB(255, 0, 0, 0),)),
                ],
              ),
              

                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelStyle: TextStyle(color: const Color.fromARGB(255, 44, 44, 44))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 9, 9, 9)),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Enter Telephone number',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home');
                    },
                    child: Text('REGISTER', style:TextStyle(color: Colors.black,fontWeight:FontWeight.bold,
                ),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
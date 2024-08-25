import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Bill extends StatefulWidget {
  const Bill({super.key});

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {

  int medicine1 = 0;
  int medicine2 = 0;
  int medicine3 = 0;

  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  

  Future<void> _fetchData() async {
    DataSnapshot snapshot1 = await _database.child('Aspirin').get();
    DataSnapshot snapshot2 = await _database.child('Panadol').get();
    DataSnapshot snapshot3 = await _database.child('Azee').get();
    

    setState(() {
       medicine1 = (snapshot1.value as int?) ?? 0;
      medicine2 = (snapshot2.value as int?) ?? 0;
      medicine3 = (snapshot3.value as int?) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      body: Container(

        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/bill.jpg'),fit: BoxFit.cover)),
        
        child: Center(
          
          child: Column(
            
            children: [
                 SizedBox(height: 95),
              Text('Your Total Bill',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold , color: Color.fromARGB(255, 0, 0, 0))),
              SizedBox(height: 100),

              Text(
                'Aspirin: $medicine1',
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 20),
              Text(
                'Panadol: $medicine2',
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 20),
              Text(
                'Azee: $medicine3',
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 50),
              ElevatedButton(onPressed: (){_fetchData();}, child: Text('Get Bill', style: TextStyle(color: Colors.black,
              fontWeight:FontWeight.bold,
                ),
                ) 
              ) 
            ],
          ),
        ),
      ),
    );
  }
}










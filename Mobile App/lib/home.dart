import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


int medicine1Count = 0;
  int medicine2Count = 0;
  int medicine3Count = 0;

  final DatabaseReference _database = FirebaseDatabase.instance.ref();


  void incrementCount(int index) {
    setState(() {
      if (index == 1 && medicine1Count < 4) {
        medicine1Count++;
      } else if (index == 2 && medicine2Count < 4) {
        medicine2Count++;
      } else if (index == 3 && medicine3Count < 4) {
        medicine3Count++;
      }
    });
  }

  void decrementCount(int index) {
    setState(() {
      if (index == 1 && medicine1Count > 0) {
        medicine1Count--;
      } else if (index == 2 && medicine2Count > 0) {
        medicine2Count--;
      } else if (index == 3 && medicine3Count > 0) {
        medicine3Count--;
      }
    });
  }
  Future<void> _updateDatabase() async {
    await _database.child('Aspirin').set(medicine1Count);
    await _database.child('Panadol').set(medicine2Count);
    await _database.child('Azee').set(medicine3Count);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

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
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/home.jpg'),fit: BoxFit.cover)),

        child: Column(
        
          children: [
            const SizedBox(height: 1),
            const Icon(Icons.medical_services, size: 50),
            const Icon(Icons.medical_services_outlined, size: 50),
            const Text(
              "Choose your medicine:",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => decrementCount(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 43, 41, 41), // Light blue color
                  ),
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () => incrementCount(1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 78, 96, 104), // Light blue color
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 20, color: Colors.black), // Black color for text
                    ),
                    child: Text(
                      "Aspirin ($medicine1Count pills)",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 240, 239, 239),
                        fontWeight: FontWeight.bold,
                      ), // Black color for text
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => incrementCount(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 43, 41, 41), // Light blue color
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => decrementCount(2),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 43, 41, 41), // Light blue color
                  ),
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () => incrementCount(2),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 78, 96, 104), // Light blue color
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 20, color: Colors.black), // Black color for text
                    ),
                    child: Text(
                      "Panadol ($medicine2Count pills)",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 240, 239, 239),
                        fontWeight: FontWeight.bold,
                      ), // Black color for text
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => incrementCount(2),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 43, 41, 41), // Light blue color
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => decrementCount(3),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 43, 41, 41), // Light blue color
                  ),
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () => incrementCount(3),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 78, 96, 104), // Light blue color
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 20, color: Colors.black), // Black color for text
                    ),
                    child: Text(
                      "  Azee   ($medicine3Count pills)",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 240, 239, 239),
                        fontWeight: FontWeight.bold,
                      ), // Black color for text
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => incrementCount(3),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 43, 41, 41), // Light blue color
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                 
              ],
              
            ),
            SizedBox(height: 25,),

            ElevatedButton(
                
                
                onPressed: () {
                  
                  _updateDatabase();
                  Navigator.of(context).pushNamed('/second');
                  
                },
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
                ),
              ),
          ],
        ),
      ),
  

    


    );
    

  }
  
}
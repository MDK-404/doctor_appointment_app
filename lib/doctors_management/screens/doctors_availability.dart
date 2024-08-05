import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorAvailabilityScreen extends StatefulWidget {
  @override
  _DoctorAvailabilityScreenState createState() =>
      _DoctorAvailabilityScreenState();
}

class _DoctorAvailabilityScreenState extends State<DoctorAvailabilityScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, bool> slots = {
    "9-10": false,
    "10-11": false,
    "11-12": false,
    "12-1": false,
    "2-3": false,
    "3-4": false,
  };
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchExistingSlots();
  }

  void _fetchExistingSlots() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doctorSnapshot =
          await _firestore.collection('doctors').doc(user.uid).get();
      if (doctorSnapshot.exists && doctorSnapshot.data() != null) {
        Map<String, dynamic>? data =
            doctorSnapshot.data() as Map<String, dynamic>?;
        if (data != null && data['availableSlots'] != null) {
          setState(() {
            slots = Map<String, bool>.from(data['availableSlots']);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Availability"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: slots.keys.map((slot) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        slots[slot] = !slots[slot]!;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: slots[slot]! ? Colors.green : Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          slot,
                          style: TextStyle(
                            color: slots[slot]! ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _saveSlots,
                    child: Text("Save Slots"),
                  ),
          ],
        ),
      ),
    );
  }

  void _saveSlots() async {
    setState(() {
      isLoading = true;
    });

    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('doctors').doc(user.uid).set({
        'availableSlots': slots,
      }, SetOptions(merge: true));
    }

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Slots saved successfully!')),
    );
  }
}

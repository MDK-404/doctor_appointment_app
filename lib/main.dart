import 'package:doctor_appointment_app/doctors_management/provider/userprovider.dart';
import 'package:doctor_appointment_app/firebase_options.dart';
import 'package:doctor_appointment_app/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// Ensure this import is correct for your project structure

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  DefaultFirebaseOptions.currentPlatform;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Doctor Appointment App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserSelectionScreen(),
      ),
    );
  }
}

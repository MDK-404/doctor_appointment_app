import 'package:doctor_appointment_app/doctors_management/doctor_login_screen.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  final String email;

  VerificationScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A verification code has been sent to $email',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to login screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DoctorLoginScreen(),
                  ),
                );
              },
              child: Text('Proceed to Login'),
            ),
          ],
        ),
      ),
    );
  }
}

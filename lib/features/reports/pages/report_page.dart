import 'package:bayme/features/shared/widget/CommingSoonWidget.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ComingSoonWidget(
        // Customize as needed
        title: 'Coming Soon',
        subtitle: 'We\'re working on something amazing!',
        description: 'Subscribe to get notified when we launch',
        buttonText: 'Get Notified',
        backgroundColor: Colors.grey[50],
        titleColor: Colors.black87,
        buttonColor: Colors.blue,
        onEmailSubmit: (email) {
          // Handle email submission
          print('Email submitted: $email');
          // You can add your API call here
        },
      ),
    );
  }
}
import 'package:bayme/features/shared/widget/CommingSoonWidget.dart';
import 'package:flutter/material.dart';

class PosPage extends StatefulWidget {
  const PosPage({super.key});

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
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
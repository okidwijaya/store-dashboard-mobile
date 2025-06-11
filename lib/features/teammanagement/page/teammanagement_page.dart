import 'package:bayme/features/shared/widget/CommingSoonWidget.dart';
import 'package:flutter/material.dart';

class TeammanagementPage extends StatefulWidget {
  const TeammanagementPage({super.key});

  @override
  State<TeammanagementPage> createState() => _TeammanagementPageState();
}

class _TeammanagementPageState extends State<TeammanagementPage> {
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
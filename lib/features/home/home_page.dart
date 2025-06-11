import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/homescreen-bg.webp',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Start Journey With\nStyleHub',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'Discover the latest fashion trends, shop your favorite brands, and create your perfect style with StyleHub!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ),
                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        context.go('/login'); 
                      },
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

// Reusable Coming Soon Widget Component
class ComingSoonWidget extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? description;
  final String? emailPlaceholder;
  final String? buttonText;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? descriptionColor;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Function(String)? onEmailSubmit;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;

  const ComingSoonWidget({
    Key? key,
    this.title,
    this.subtitle,
    this.description,
    this.emailPlaceholder,
    this.buttonText,
    this.backgroundColor,
    this.titleColor,
    this.subtitleColor,
    this.descriptionColor,
    this.buttonColor,
    this.buttonTextColor,
    this.onEmailSubmit,
    this.padding,
    this.maxWidth,
  }) : super(key: key);

  @override
  _ComingSoonWidgetState createState() => _ComingSoonWidgetState();
}

class _ComingSoonWidgetState extends State<ComingSoonWidget> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;
  String _message = '';

  void _validateAndNotify() {
    String email = _emailController.text.trim();
    
    if (email.isEmpty) {
      setState(() {
        _isEmailValid = false;
        _message = 'Please enter your email address';
      });
      return;
    }

    // Simple email validation
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(email)) {
      setState(() {
        _isEmailValid = false;
        _message = 'Please enter a valid email address';
      });
      return;
    }

    // If validation passes
    setState(() {
      _isEmailValid = true;
      _message = 'Thank you! We\'ll notify you when we launch.';
    });

    // Call the callback function if provided
    if (widget.onEmailSubmit != null) {
      widget.onEmailSubmit!(email);
    }

    // Clear the email field after successful submission
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        _emailController.clear();
        setState(() {
          _message = '';
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.grey[50],
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main heading
              Text(
                widget.title ?? 'Coming Soon',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: widget.titleColor ?? Colors.black87,
                  letterSpacing: -1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 24),
              
              // Subtitle
              Text(
                widget.subtitle ?? 'We\'re working on our new website. Stay tuned!',
                style: TextStyle(
                  fontSize: 18,
                  color: widget.subtitleColor ?? Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 60),
              
              // Email input section
              Container(
                constraints: BoxConstraints(maxWidth: widget.maxWidth ?? 500),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Email input field
                        Expanded(
                          child: Container(
                            height: 56,
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: widget.emailPlaceholder ?? 'john.doe@gmail.com',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(
                                    color: _isEmailValid ? Colors.grey[300]! : Colors.red,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(
                                    color: _isEmailValid ? Colors.grey[300]! : Colors.red,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(
                                    color: _isEmailValid ? Colors.blue : Colors.red,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                              ),
                              style: TextStyle(fontSize: 16),
                              onSubmitted: (value) => _validateAndNotify(),
                            ),
                          ),
                        ),
                        
                        SizedBox(width: 16),
                        
                        // Notify Me button
                        ElevatedButton(
                          onPressed: _validateAndNotify,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.buttonColor ?? Colors.black87,
                            foregroundColor: widget.buttonTextColor ?? Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 0,
                            minimumSize: Size(120, 56),
                          ),
                          child: Text(
                            widget.buttonText ?? 'Notify Me',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Message display
                    if (_message.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          _message,
                          style: TextStyle(
                            color: _isEmailValid ? Colors.green[600] : Colors.red[600],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
              
              SizedBox(height: 40),
              
              // Description text
              Container(
                constraints: BoxConstraints(maxWidth: widget.maxWidth ?? 600),
                child: Text(
                  widget.description ?? 'Be the first to know about the latest updates and get exclusive offer on our grand opening',
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.descriptionColor ?? Colors.grey[500],
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
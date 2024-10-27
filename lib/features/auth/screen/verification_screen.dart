import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/constants/colors/app_colors.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  String generatedCode = '';
  bool showCustomSnackbar = false;
  String snackbarMessage = '';

  @override
  void initState() {
    super.initState();
    generatedCode = _generate4DigitCode(); // Generate the code initially

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0]
          .requestFocus(); // Set focus on the first field after the frame is built
      _showGeneratedCodeSnackbar(); // Show the custom Snackbar after the screen is built
    });
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  void _showGeneratedCodeSnackbar() {
    setState(() {
      snackbarMessage = 'Code: $generatedCode';
      showCustomSnackbar = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        showCustomSnackbar = false;
      });
    });
  }

  String _generate4DigitCode() {
    return Random().nextInt(9000 + 1000).toString().padLeft(4, '0');
  }

  void _clearFields() {
    // Clear all input fields
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus(); // Refocus the first field
  }

  void _verifyCode() {
    String enteredCode =
        _controllers.map((controller) => controller.text).join();
    if (enteredCode == generatedCode) {
      _clearFields(); // Clear fields on successful verification
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SuccessScreen()));
    } else {
      setState(() {
        snackbarMessage = 'Incorrect code. Please try again!';
        showCustomSnackbar = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          showCustomSnackbar = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification Code"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please type the verification code sent to your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) => _buildOtpField(index)),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "I didn’t receive a code!",
                      style: TextStyle(color: Colors.black),
                    ),
                    // SizedBox(width: 10,),
                    TextButton(
                      onPressed: () {
                        generatedCode =
                            _generate4DigitCode(); // Regenerate code
                        _showGeneratedCodeSnackbar(); // Show custom Snackbar with new code
                        _clearFields(); // Clear input fields on resend
                      },
                      child: Text(
                        "Please resend",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (showCustomSnackbar) // Custom Snackbar
            Positioned(
              left: 16,
              right: 16,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color:  snackbarMessage == 'Incorrect code. Please try again!'
              ? Colors.red // Red for incorrect code
              : Colors.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    snackbarMessage,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 50,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        cursorColor: AppColors.instance.kPrimary, // Set cursor color
        style: TextStyle(color: AppColors.instance.kPrimary, fontSize: 24),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.instance.kPrimary),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            // Move to the next field if a digit is entered
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus(); // Unfocus the last field
              _verifyCode(); // Verify the code when all fields are filled
            }
          } else if (index > 0) {
            // Move to the previous field if backspace is pressed
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Success! Verification code is correct.',
          style: TextStyle(fontSize: 24, color: Colors.green),
        ),
      ),
    );
  }
}

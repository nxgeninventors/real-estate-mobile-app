import 'package:flutter/material.dart';

import 'dashboardScreen.dart';
import 'apiClient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class LoginRegisterPage extends StatefulWidget {
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation<double> _shakeAnimation;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoginForm = true;
  final _formKey = GlobalKey<FormState>(); // Create a global key for the form

  void _toggleForm() {
    setState(() {
      _isLoginForm = !_isLoginForm;
      _formKey.currentState!.reset();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );
  }
  void _nextScreen() async{
    String path = 'users/login';

    // Prepare the request body
    Map<String, dynamic> requestBody = {
      'email': _usernameController.text,
      'password': _passwordController.text,
    };

    ApiClient apiClient = ApiClient();

    http.Response response  = await apiClient.postRequest(path, requestBody);

    print("response.statusCode");
    Map<String, dynamic> responseData = jsonDecode(response.body);
    print("Response data: $responseData");
    if (response.statusCode == 200) {

      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => DashboardScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
      try {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Response data: $responseData");

        // TODO: Process the responseData as needed

      } catch (e) {
        print('Error decoding response: $e');
        // Handle decoding error
      }
    } else {
      // Request failed
      print('Request failed with status code: ${response.statusCode}');
      // Handle failure
    }    /**/
  }

  void _registerUSer() async {
    String path = 'users/register';

    // Prepare the request body
    Map<String, dynamic> requestBody = {
      'name': _nameController.text,
      'email': _usernameController.text,
      'password': _passwordController.text,
    };

    ApiClient apiClient = ApiClient();

    http.Response response = await apiClient.postRequest(path, requestBody);

    print("response.statusCode");
    Map<String, dynamic> responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _toggleForm();
    }
  }
  void _playShakeAnimation() async {
    for (int i = 0; i < 3; i++) {
      await _animationController!.animateTo(0.1);
      await _animationController!.animateTo(0.9);
    }
    await _animationController!.animateTo(0.5);
  }
  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
  Widget _loginView() {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0.0),
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 350,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey, // Assign the form key to the form
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            else if (value != "user@gmail.com") {
                              return "Please enter a valid username";
                            }
                            return null;
                          },
                          onChanged: (_) {
                            _formKey.currentState!.validate();
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value != "password") {
                              return "Please enter the correct password";
                            }
                            return null;
                          },
                          onChanged: (_) {
                            _formKey.currentState!.validate();
                          },
                        ),
                        SizedBox(height: 32),
                        Container(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Both fields pass validation
                                _nextScreen();
                              } else {
                                // At least one field fails validation
                                _playShakeAnimation();
                              }
                            },
                            child: Text('Login'),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: _toggleForm,
                          child: Text('Create an account'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _registerView(){
    return Center(
      child: AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0.0),
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 460,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey, // Assign the form key to the form
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            _formKey.currentState!.validate();
                          },
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            _formKey.currentState!.validate();
                          },
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value != "password") {
                              return "Please enter the correct password";
                            }
                            return null;
                          },
                          onChanged: (_) {
                            _formKey.currentState!.validate();
                          },
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            _formKey.currentState!.validate();
                          },
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _registerUSer();
                              } else {
                                // At least one field fails validation
                                _playShakeAnimation();
                              }
                            },
                            child: Text('Register'),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextButton(
                          onPressed: _toggleForm,
                          child: Text('Already have an account? Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/welcome.jpg'),
          // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: screenWidth,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.indigo,
            ], // Replace with your gradient colors
          ),
        ),
        child: _isLoginForm ? _loginView() : _registerView(),
      ),
    );
  }
}

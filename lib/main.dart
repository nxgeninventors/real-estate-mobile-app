import 'package:flutter/material.dart';
import 'dashboardScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  bool showRowWidget = true;
  late Animation<double> _shakeAnimation;

  void _getStarted() {
    setState(() {
      showRowWidget = false;
    });
    // _nextScreen();
  }

  void _nextScreen() {
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

  void _playShakeAnimation() async {
    for (int i = 0; i < 3; i++) {
      await _animationController!.animateTo(0.1);
      await _animationController!.animateTo(0.9);
    }
    await _animationController!.animateTo(0.5);
  }

  final _formKey = GlobalKey<FormState>(); // Create a global key for the form

  Widget _loginView() {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    return Center(
      child: AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0.0),
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 300,
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
                            } else if (value != "user@gmail.com") {
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
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Widget _startView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: showRowWidget,
        child: Container(
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Find a home of your dreams",
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.75),
                  // Faded white color (50% opacity)
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none, // Remove underline
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Finding a place to live can be a difficult task, therefore we have done our best to simplify it.",
                textAlign: TextAlign.left, // Align left
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  decoration: TextDecoration.none, // Remove underline
                ),
              ),
                SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _getStarted,
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(double.infinity, 50)), // Set width to match parent and height to 50
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Set the corner radius
                      ),
                    ),
                  ),
                  child: Text(
                    "Get started",
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, .7), fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
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
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          child: showRowWidget ? _startView() : _loginView(),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
    );
  }
  }

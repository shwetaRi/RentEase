import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLandlord = true;
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 15),

              Row(
                children: [

                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {},
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        "RentEase",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 40),

                ],
              ),

              const SizedBox(height: 35),

              const Center(
                child: Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  "Stay connected by signing in with your email\nand password to access your account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              const Center(
                child: Text(
                  "Choose your role",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isLandlord = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: isLandlord
                              ? Colors.grey.shade300
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [

                            Icon(Icons.key),

                            SizedBox(width: 8),

                            Text("Landlord"),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isLandlord = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: !isLandlord
                              ? Colors.grey.shade300
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [

                            Icon(Icons.person_outline),

                            SizedBox(width: 8),

                            Text("Tenant"),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Email Address",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                decoration: InputDecoration(
                  hintText: "Your Email",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Password",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: "Secure Password",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Row(
                children: [

                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                  ),

                  const Text("Remember me"),

                  const Spacer(),

                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password?"),
                  ),

                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text("Don't have an account? "),

                  TextButton(
                    onPressed: () {},
                    child: const Text("Sign Up"),
                  )

                ],
              ),

              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
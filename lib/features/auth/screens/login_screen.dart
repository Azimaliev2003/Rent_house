// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _rememberMe = false;
//   String? _errorMessage;
//   bool _isLoading = false;

//   void _togglePassword() {
//     setState(() {
//       _obscurePassword = !_obscurePassword;
//     });
//   }

//   Future<bool> _login(String email, String password) async {
//     await Future.delayed(const Duration(seconds: 1));
//     return email == "test@test.com" && password == "123456";
//   }

//   void _handleLogin() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     bool success =
//         await _login(_emailController.text, _passwordController.text);

//     setState(() {
//       _isLoading = false;
//     });

//     if (success) {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       setState(() {
//         Text('Неверный email или пароль');
//         _errorMessage = "Неверный email или пароль";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Верхняя часть
//           Container(
//             width: double.infinity,
//             height: 220,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [Color(0xFF4A90E2), Color(0xFF007AFF)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight),
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30)),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Icon(Icons.shield, size: 60, color: Colors.white),
//                 SizedBox(height: 16),
//                 Text('Sign in to your Account',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold)),
//                 SizedBox(height: 8),
//                 Text('Enter your email and password to log in',
//                     style: TextStyle(color: Colors.white70, fontSize: 14)),
//               ],
//             ),
//           ),

//           // Нижняя часть
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(24),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // Google
//                     ElevatedButton.icon(
//                       onPressed: () {},
//                       icon: Image.network(
//                           'https://img.icons8.com/color/24/google-logo.png',
//                           height: 24,
//                           width: 24),
//                       label: const Text(
//                         'Continue with Google',
//                         style: TextStyle(color: Colors.black87),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         minimumSize: const Size(double.infinity, 50),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         elevation: 2,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     const Text('Or login with', style: TextStyle(color: Colors.grey)),
//                     const SizedBox(height: 16),

//                     // Email
//                     TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.email),
//                         hintText: 'Email',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // Password
//                     TextField(
//                       controller: _passwordController,
//                       obscureText: _obscurePassword,
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           icon: Icon(_obscurePassword
//                               ? Icons.visibility
//                               : Icons.visibility_off),
//                           onPressed: _togglePassword,
//                         ),
//                         hintText: 'Password',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                       ),
//                     ),
//                     const SizedBox(height: 8),

//                     // Remember me & forgot password
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Checkbox(
//                                 value: _rememberMe,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _rememberMe = value ?? false;
//                                   });
//                                 }),
//                             const Text('Remember me'),
//                           ],
//                         ),
//                         TextButton(
//                             onPressed: () {}, child: const Text('Forgot Password?')),
//                       ],
//                     ),
//                     const SizedBox(height: 16),

//                     // Log In
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: _isLoading
//                           ? const Center(child: CircularProgressIndicator())
//                           : ElevatedButton(
//                               onPressed: _handleLogin,
//                               style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 padding: const EdgeInsets.all(0),
//                               ),
//                               child: Ink(
//                                 decoration: BoxDecoration(
//                                   gradient: const LinearGradient(
//                                       colors: [Color(0xFF4A90E2), Color(0xFF007AFF)]),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   child: const Text(
//                                     'Log In',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Sign Up
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't have an account? "),
//                         TextButton(onPressed: () {}, child: const Text('Sign Up')),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

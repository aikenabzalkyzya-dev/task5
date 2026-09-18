import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterFormPage(),
    );
  }
}

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  List<String> _countries = [
    'Kyrgyzstan',
    'Kazakhstan',
    'Uzbekistan',
    'Russia',
  ];

  String? _selectedCountry;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();

    super.dispose();
  }
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Country: $_selectedCountry');
      print('Story: ${_storyController.text}');
      print('Password: ${_passwordController.text}');
      print('Confirm Password: ${_confirmController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form submitted successfully!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),

      body: Form(
        key: _formKey,

        child: ListView(
          padding: EdgeInsets.all(16.0),

          children: [
            TextFormField(
              controller: _nameController,

              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'What do people call you?',
                prefixIcon: Icon(Icons.person),

                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }

                return null;
              },
            ),

            SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,

              keyboardType: TextInputType.phone,

              decoration: InputDecoration(
                labelText: 'Phone number *',
                hintText: 'Where can we reach you?',
                helperText: 'Phone Form: (XXX)XXX-XXXX',
                prefixIcon: Icon(Icons.phone),

                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number is required';
                }

                if (value.length < 10) {
                  return 'Enter a valid phone number';
                }

                return null;
              },
            ),

            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,

              keyboardType: TextInputType.emailAddress,

              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter an email address',
                icon: Icon(Icons.mail),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }

                if (!value.contains('@')) {
                  return 'Enter a valid email';
                }

                return null;
              },
            ),

            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCountry,

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
                labelText: 'Country',
              ),

              items: _countries.map((country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a country';
                }

                return null;
              },
            ),

            SizedBox(height: 20),
            TextFormField(
              controller: _storyController,

              decoration: InputDecoration(
                labelText: 'Life Story',
                hintText: 'Tell us about yourself',
                helperText: 'Keep it short, this is just a demo',
                border: OutlineInputBorder(),
              ),

              maxLines: 3,

              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
            ),

            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,

              obscureText: _hidePassword,

              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter a Password',

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },

                  icon: Icon(
                    _hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),

                icon: Icon(Icons.security),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }

                return null;
              },
            ),

            SizedBox(height: 20),

            // ================= CONFIRM PASSWORD =================
            TextFormField(
              controller: _confirmController,

              obscureText: _hideConfirmPassword,

              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm a Password',

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hideConfirmPassword =
                          !_hideConfirmPassword;
                    });
                  },

                  icon: Icon(
                    _hideConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),

                icon: Icon(Icons.border_color),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }

                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }

                return null;
              },
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _submitForm,

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),

              child: Text(
                'Submit Form',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
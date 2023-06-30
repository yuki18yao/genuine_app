import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:genuine_app/widgets/signup/user_image_picker.dart';

final _firebase = FirebaseAuth.instance; // Creating a FirebaseAuth object

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredNickname = '';
  File? _selectedImage;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!
        .validate(); // checks the info on validator for input criteria

    if (!isValid || !_isLogin && _selectedImage == null) {
      return;
    }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          // The Firebase object sends HTTP request to Firebase using this method
          email: _enteredEmail,
          password: _enteredPassword,
        );

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'nickname': _enteredNickname,
          'email': _enteredEmail,
          'image_url': imageUrl
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-a') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              width: 200,
              child: Image.asset('assets/images/DancingDoodle.png'),
            ),
            if (_isLogin)
              Text(
                'Welcome back,',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.left,
              ),
            if (!_isLogin)
              Text(
                'Get on board!',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.left,
              ),
            Text(
              'Unleash your potential',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.left,
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLogin)
                          UserImagePicker(
                            onPickImage: (pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
                        if (!_isLogin)
                          TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                labelText: 'Nickname',
                                hintText: 'Nickname',
                                border: OutlineInputBorder()),
                            enableSuggestions: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter at least 4 characters.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredNickname = value!;
                            },
                          ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                            labelText: 'Email',
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            // Checks if the input email address matches criteria
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // .save() gets called in _submit() method
                            _enteredEmail = value!;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              labelText: 'Password',
                              hintText: 'Password',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: null,
                                icon: Icon(Icons.remove_red_eye_sharp),
                              )),
                          obscureText: true,
                          validator: (value) {
                            // Checks if the input password matches criteria
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be at least 6 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // .save() gets called in _submit() method
                            _enteredPassword = value!;
                          },
                        ),
                        const SizedBox(height: 12),
                        if (_isLogin)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: const Text('Forgot Password?')),
                          ),
                        const SizedBox(height: 12),
                        if (_isAuthenticating)
                          const CircularProgressIndicator(),
                        if (!_isAuthenticating)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  _submit, // call _submit method once pressed
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(_isLogin ? 'Login' : 'Signup'),
                            ),
                          ),
                        const SizedBox(height: 12),
                        const Text('or'),
                        if (!_isAuthenticating)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin =
                                    !_isLogin; // set the state to the opposite of the current state
                              });
                            },
                            child: Text(_isLogin
                                ? 'Don\'t have an account? Signup'
                                : 'Already have an account? Login'),
                          ),
                      ],
                    )),
              )),
            )
          ],
        )),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/routers.dart';
import '../utils/text_form_field_widget.dart';
import '../view_models/auth_provider.dart';
import 'aadhar.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();

  TextEditingController _lastNameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      var authProv = Provider.of<AuthProvider>(context, listen: false);
      _firstNameController.text = authProv.firstName;
      _lastNameController.text = authProv.lastName;
      _emailController.text = authProv.email;
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var _authProvider = Provider.of<AuthProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
            ),
            SizedBox(
              height: height * .7,
              width: width,
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: height * .7,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black38,
                      Colors.black87.withOpacity(1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 1],
                    tileMode: TileMode.clamp),
              ),
            ),
            Positioned(
              bottom: height * .1,
              child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: 'Register'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 56,
                    ),
                    // Image.asset("assets/images/login.png"),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormFieldWidget(
                            hintText: 'Enter your first name',
                            controller: _firstNameController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormFieldWidget(
                            hintText: 'Enter your last name',
                            controller: _lastNameController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormFieldWidget(
                            hintText: 'Enter your email',
                            controller: _emailController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 50,
                          child: FilledButton.tonal(
                            onPressed: () async {
                              _authProvider.setFirstName =
                                  _firstNameController.text;
                              _authProvider.setLastName =
                                  _lastNameController.text;
                              _authProvider.setEmail = _emailController.text;
                              nextPage(context: context, page: const Aadhar());
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Next"),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

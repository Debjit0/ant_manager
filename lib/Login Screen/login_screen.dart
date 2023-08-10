
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../otp/verify.dart';
import '../utils/routers.dart';
import '../view_models/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String verify = '';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String countryCode = '+91';
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                //  height: 300,
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
                        text: 'Welcome back, '.toUpperCase(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        children: [
                          TextSpan(
                            text: 'Bud'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 32,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // Image.asset("assets/images/login.png"),
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        // height: 60,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                                height: 60,
                                width: 90,
                                child: FilledButton.tonal(
                                    onPressed: () {},
                                    child: const Text("+91"))),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 40) -
                                  90 -
                                  16,
                              child: TextFormField(
                                controller: phoneController,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a phone number';
                                  } else if (value.length < 7 ||
                                      value.length > 15) {
                                    return 'PLease enter a valid phone number';
                                  }
                                },
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                    ),
                                  ),
                                  hintText: 'Enter Your mobile number',
                                  hintStyle:
                                      const TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton.tonal(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print("${countryCode + phoneController.text}");
                                try {
                                  Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .setPhoneNumber =
                                      "${countryCode + phoneController.text}";
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber:
                                        "${countryCode + phoneController.text}",
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {},
                                    verificationFailed:
                                        (FirebaseAuthException e) {},
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      LoginScreen.verify = verificationId;
                                      
                                      nextPage(
                                          context: context, page: MyVerify());
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {},
                                  );
                                } catch (e) {
                                  print(e);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(
                                        child: Text(e.toString()),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text("Get OTP")))
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
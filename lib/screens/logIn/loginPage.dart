import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mastercoding/screens/agent/homePage.dart';
import 'package:mastercoding/controller/auth_controller.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  bool _visiblePassword = false;
  String? _error;
  String? _password;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
            height: size.height*0.5,width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/Group 13.png"),
                      fit: BoxFit.cover),
                ),
               // Foreground widget here
            ),
            SizedBox(height: size.height*0.1,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    JDInputText(
                      hintText: 'Enter Email Address',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        _email = val!;
                      },
                      validator: (email) {
                        if (email != null ) {
                          return null;
                        }
                        return "Invalid email address";
                      },
                    ),
                    SizedBox(height: 20),
                    JDInputText(
                      obscureText: _visiblePassword,
                      hintText: 'Enter Password',
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (val) {
                        _password = val!;
                      },
                      validator: (password) {
                        if (password == null || password.length == 0) {
                          return "Empty password";
                        }
                        return null;
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _visiblePassword = !_visiblePassword;
                          });
                        },
                        child: Icon(
                          _visiblePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,

                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _error='';
                            AuthController.instance.SignIn(_email!.trim(), _password?.trim());
                          });
                        } else {
                          /// Add business logic to authenticate user.
                          /// User _email and _password
                          setState(() {
                            _error =
                            'Please provide a valid email/password combination';

                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        width: size.width*0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFAF1116),
                          borderRadius: BorderRadius.circular(150)
                        ),
                        child: Center(
                          child: Text(
                            'Log In',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    ));
  }
}

class JDInputText extends StatelessWidget {
  const JDInputText({
    required this.onChanged,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.textInputAction,
  });
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: textInputAction,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        hintText: hintText,
        fillColor: Colors.transparent,
        filled: true,
        errorStyle: TextStyle(height: 0, color: Colors.transparent),
        hintStyle: TextStyle(
          fontSize: 16,
          color: Color(0xFF969A9D),
          fontWeight: FontWeight.w300,
        ),
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color:Color(0xFFAF1116), width: .5)),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide( width: .5,color:Color(0xFFAF1116) )),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide( width: .5)),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.red, width: .5),
        ),
      ),
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF3C3C43),
      ),
    );
  }

}

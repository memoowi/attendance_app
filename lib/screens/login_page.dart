import 'package:attendance_app/utils/custom_colors.dart';
import 'package:attendance_app/widgets/custom_clip_path.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  String? _passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else {
      return null;
    }
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      print('Login Successful');
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   ),
      // );
    }
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.25),
        child: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: CustomColors.tertiaryColor,
          elevation: 0,
          flexibleSpace: ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://i.pinimg.com/736x/da/59/39/da593983d793705f3fbb3c1fa1e067a4.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
      // extendBodyBehindAppBar: true,
      backgroundColor: CustomColors.tertiaryColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Text(
                  'Welcome, Please ...',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                ),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        CustomColors.primaryColor,
                        CustomColors.secondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    'LOGIN\uFF3F\uFF3F',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailController,
                  validator: _emailValidator,
                  style: TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    hintStyle: TextStyle(
                      color: CustomColors.primaryColor.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                    prefixIconColor: CustomColors.secondaryColor,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.primaryColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  validator: _passwordValidator,
                  style: TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                  obscureText: _obscureText,
                  obscuringCharacter: '●',
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    hintStyle: TextStyle(
                      color: CustomColors.primaryColor.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(Icons.lock_outline),
                    prefixIconColor: CustomColors.secondaryColor,
                    suffixIcon: IconButton(
                      onPressed: _toggleObscureText,
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    suffixIconColor: CustomColors.primaryColor,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.primaryColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        CustomColors.primaryColor,
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/utils/custom_colors.dart';
import 'package:attendance_app/widgets/custom_clip_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      bool loggedIn = await Provider.of<AuthProvider>(context, listen: false)
          .login(_emailController.text, _passwordController.text, context);

      if (loggedIn == true) {
        Navigator.pushReplacementNamed(
          context,
          '/home',
        );
      }
    }
    setState(() {
      _isSubmitting = false;
    });
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
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              decoration: const BoxDecoration(
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
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                const Text(
                  'Track with ease!',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                ),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [
                        CustomColors.primaryColor,
                        CustomColors.secondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: const Text(
                    'LOGIN\uFF3F\uFF3F',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Consumer(
                  builder: (context, AuthProvider authProvider, child) {
                    if (authProvider.validationMessage != null) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        padding: const EdgeInsets.all(12.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red,
                        ),
                        child: Text(
                          authProvider.validationMessage!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                TextFormField(
                  enabled: !_isSubmitting,
                  controller: _emailController,
                  validator: _emailValidator,
                  style: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    hintStyle: TextStyle(
                      color: CustomColors.primaryColor.withOpacity(0.5),
                    ),
                    prefixIcon: const Icon(Icons.email_outlined),
                    prefixIconColor: CustomColors.secondaryColor,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.primaryColor,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  enabled: !_isSubmitting,
                  controller: _passwordController,
                  validator: _passwordValidator,
                  style: const TextStyle(
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
                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: CustomColors.secondaryColor,
                    suffixIcon: IconButton(
                      onPressed: _toggleObscureText,
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    suffixIconColor: CustomColors.primaryColor,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.primaryColor,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _login,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        _isSubmitting ? Colors.grey : CustomColors.primaryColor,
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 10.0),
                      ),
                    ),
                    child: _isSubmitting
                        ? SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
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

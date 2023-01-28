import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../utils/validators/form_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  void onSignIn() {
    if (_form.currentState?.validate() ?? false) {
      BlocProvider.of<AuthBloc>(context).add(TryAuthenticateEvent(
          username: _usernameController.text,
          password: _passwordController.text));
    }
  }

  void onRegister() {
    if (_form.currentState?.validate() ?? false) {
      BlocProvider.of<AuthBloc>(context).add(TryRegisterEvent(
          username: _usernameController.text,
          password: _passwordController.text));
    }
  }

  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation = Tween(begin: 0.0, end: 24.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizer = AppLocalizations.of(context)!;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is NotAuthenticated) {
          /*
          setState(() {
            isLoading = false;
          });
          */
        }
        if (state is Authenticated || state is Registered) {
          /*
          setState(() {
            isLoading = false;
          });
          */
        } else if (state is FailedAuthentication ||
            state is FailedRegistration) {
          String reason = state.reason;
          Fluttertoast.showToast(
              msg: reason,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 222, 133, 127),
              textColor: Colors.white,
              fontSize: 16.0);
          BlocProvider.of<AuthBloc>(context).add(AuthFailedEvent());
          /*
          setState(() {
            isLoading = false;
          });
          */
        } else if (state is AuthLoading) {
          /*
          setState(() {
            isLoading = false;
          });
          */
        }
      },
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: SizedBox(
                      width: 120,
                      height: 120,
                      child: AnimatedContainer(
                          duration: const Duration(seconds: 3),
                          margin: EdgeInsets.only(top: _animation.value),
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("lib/images/0.png"),
                              fit: BoxFit.scaleDown,
                            ),
                          )),
                    )),
                    const SizedBox(height: 48),
                    Text(localizer.appWelcomeTitle,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        )),
                    const SizedBox(height: 24),
                    Flexible(
                      child: TextFormField(
                        controller: _usernameController,
                        validator: cannotBeEmpty(localizer),
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: localizer.username,
                            hintStyle: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: TextFormField(
                          controller: _passwordController,
                          validator: cannotBeEmpty(localizer),
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: localizer.password,
                              hintStyle: const TextStyle(color: Colors.grey))),
                    ),
                    const SizedBox(height: 24),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      GestureDetector(
                          onTap: onSignIn,
                          child: Container(
                              padding: const EdgeInsets.all(18),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  localizer.login,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ))),
                      GestureDetector(
                          onTap: onRegister,
                          child: Container(
                              padding: const EdgeInsets.all(18),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  localizer.register,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              )))
                    ])
                  ],
                ),
              ),
            ),
    );
  }
}

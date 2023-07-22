// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:machine_test/views/product.dart';
import 'package:machine_test/views/widgets/customfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();

  final passwordController = TextEditingController();

  final ValueNotifier<bool> isRemember = ValueNotifier(false);

  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomFormField(
              text: 'Username',
              controller: nameController,
              validator: (val) {
                if (val == null || val.length < 5) {
                  return 'Invalid Username';
                } else {
                  return null;
                }
              },
            ),
            CustomFormField(
              text: 'Password',
              controller: passwordController,
              validator: (val) {
                if (val == null || val.length < 5) {
                  return 'Invalid Password';
                } else {
                  return null;
                }
              },
            ),
            Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: isRemember,
                    builder: (context, value, _) {
                      return Checkbox(
                        value: value,
                        onChanged: (value) {
                          isRemember.value = value!;
                        },
                      );
                    }),
                const Text('Remember Password')
              ],
            ),
            FilledButton(
                onPressed: () async {
                  onSubmit(context);
                },
                child: const Text('Login'))
          ],
        ),
      ),
    );
  }

  onSubmit(BuildContext context) async {
    final val = await authCheck(nameController.text, passwordController.text);

    if (_key.currentState!.validate() && val == 200) {
      if (isRemember.value) {
        saveLogin(nameController.text, passwordController.text);
      }
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(),
          ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login Failed')));
    }
  }

  checkLogin() async {
    final pref = await SharedPreferences.getInstance();
    final name = pref.getString('name');
    final password = pref.getString('password');
    if (name != null && password != null) {
      nameController.text = name;
      passwordController.text = password;
    }
  }

  Future<int> authCheck(String name, String password) async {
    const String url = 'https://fakestoreapi.com/auth/login';
    final body = {'username': "mor_2314", 'password': "83r5^_"};
    final response = await http.post(Uri.parse(url), body: body);

    return response.statusCode;
  }

  saveLogin(String username, String password) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('name', username);
    pref.setString('password', password);
  }
}

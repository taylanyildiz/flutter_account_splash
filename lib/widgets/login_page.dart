import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/auth/account.dart';
import 'package:provider/provider.dart';

/// [PageView.builder] returns pages
class LoginPage extends StatelessWidget {
  LoginPage({
    Key? key,
    required this.formKey,
    required this.onPressed,
    required this.controller,
  }) : super(key: key);
  final formKey;
  final Function onPressed;
  final List controller;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.0),
          Form(
            key: formKey!,
            child: Column(
              children: [
                SizedBox(
                  width: size.width * .8,
                  child: TextFormField(
                    controller: controller[0],
                    validator: (page) {
                      if (page!.isEmpty)
                        return 'Can not be null';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'e-mail',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  width: size.width * .8,
                  child: TextFormField(
                    controller: controller[1],
                    obscureText: Provider.of<Account>(context).visibilityLog,
                    validator: (page) {
                      if (page!.isEmpty)
                        return 'Can not be null';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          color: Colors.red,
                          icon: Icon(Provider.of<Account>(context).visibilityLog
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () =>
                              Provider.of<Account>(context, listen: false)
                                  .visibilityLog = true),
                      labelText: 'password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'or',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: size.width * .7,
            child: MaterialButton(
              onPressed: () => onPressed.call(),
              child: Text('Create Account'),
              color: Colors.red,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          ),
        ],
      ),
    );
  }
}

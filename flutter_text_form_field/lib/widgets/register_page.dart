import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/auth/account.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({
    Key? key,
    this.formKey,
    required this.controller,
  }) : super(key: key);

  final formKey;
  final List controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SizedBox(height: 60.0),
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: size.width * .7,
                  child: TextFormField(
                    controller: controller[0],
                    validator: (page) {
                      if (page!.isEmpty)
                        return 'can not be null';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  width: size.width * .7,
                  child: TextFormField(
                    controller: controller[1],
                    validator: (page) {
                      if (page!.isEmpty)
                        return 'can not be null';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        labelText: 'e-mail',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  width: size.width * .7,
                  child: TextFormField(
                    controller: controller[2],
                    obscureText: Provider.of<Account>(context).visibilityReg,
                    validator: (page) {
                      if (page!.isEmpty)
                        return 'can not be null';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: Colors.red,
                          icon: Icon(Provider.of<Account>(context).visibilityReg
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () =>
                              Provider.of<Account>(context, listen: false)
                                  .visibilityReg = false,
                        ),
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'password',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import '../../../size_config.dart';
import '../../../services/storage.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController(text: '...');
  final TextEditingController _emailController =
      TextEditingController(text: '...');

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  void retrieveData() async {
    String? token = await secureStorage.read(key: 'jwt');
    if (token == null) {
      return;
    }

    final response = await http.get(
      Uri.parse('https://tcc2-api.herokuapp.com/auth/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      },
    );

    final body = jsonDecode(response.body);

    String fetchedName = body['data']['user']['name'];
    String fetchedEmail = body['data']['user']['email'];
    setState(() {
      _emailController.value = _emailController.value.copyWith(
        text: fetchedEmail,
      );
      _nameController.value = _emailController.value.copyWith(
        text: fetchedName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(40)),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      readOnly: true,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      readOnly: true,
      controller: _nameController,
      decoration: InputDecoration(
        labelText: "First Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}

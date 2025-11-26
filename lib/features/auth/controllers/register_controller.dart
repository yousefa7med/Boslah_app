import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  final nameController = TextEditingController();

  final gmailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final see = true.obs;

  final formKey=GlobalKey<FormState>();

}
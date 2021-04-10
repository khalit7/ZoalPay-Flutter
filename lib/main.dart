import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/zoalPayApp.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(Provider<ApiService>(child: MyApp()));
}

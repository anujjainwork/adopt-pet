import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String obfuscate(String input) {
  return String.fromCharCodes(input.runes.map((c) => c + 1));
}

String _deobfuscate(String input) {
  return String.fromCharCodes(input.runes.map((c) => c - 1));
}

String get clientId => _deobfuscate(dotenv.env['PETFINDER_CLIENT_ID']!);
String get clientSecret => _deobfuscate(dotenv.env['PETFINDER_CLIENT_SECRET']!);


Future<String?> fetchPetfinderToken() async {
  final response = await http.post(
    Uri.parse("https://api.petfinder.com/v2/oauth2/token"),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      "grant_type": "client_credentials",
      "client_id": clientId,
      "client_secret": clientSecret,
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['access_token'];
  } else {
    debugPrint('Token fetch failed: ${response.body}');
    return null;
  }
}

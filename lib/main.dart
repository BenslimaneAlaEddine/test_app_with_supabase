import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://tmbkwagwasmokppzvfku.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRtYmt3YWd3YXNtb2twcHp2Zmt1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ0MzUyODMsImV4cCI6MjA3MDAxMTI4M30.X-SYAGw73KK58SgSccWXXGk72e-LdANHDMCpSqWFQFg",
  );
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}

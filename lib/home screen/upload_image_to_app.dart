import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadImageToApp extends StatefulWidget {
  const UploadImageToApp({super.key, required this.set});

  final Function(String image) set;

  @override
  UploadImageToAppState createState() => UploadImageToAppState();
}

class UploadImageToAppState extends State<UploadImageToApp> {
  File? image;
  String? url;
  Future<String>? myFuture;

  Future<String> uploadToSupabase() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      final pathFile = "Images/${user!.id}/avatar.jpg";
      if (image != null) {
        await Supabase.instance.client.storage.from("test").upload(
              pathFile,
              image!,
            );
        await Supabase.instance.client
            .from("Profile")
            .update({"avatar": pathFile}).eq("idUser", user.id);
        widget.set(Supabase.instance.client.storage
            .from("test")
            .getPublicUrl(pathFile));
        setState(() {
          url = Supabase.instance.client.storage
              .from("test")
              .getPublicUrl(pathFile);
        });
        return "uploaded with succes";
      } else {
        return "select an image";
      }
    } on StorageException catch (e) {
      return e.message;
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "Exceptional error";
    }
  }

  Future<void> upload() async {
    final picker = ImagePicker();
    final XFile? pick = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pick != null) {
      setState(() {
        image = File(pick.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image != null
            ? Image.file(
                image!,
                height: 200,
                width: 200,
              )
            : const Text("No image selected"),
        OutlinedButton(onPressed: upload, child: const Text("upload image")),
        OutlinedButton(
            onPressed: () async {
              myFuture = uploadToSupabase();
              setState(() {});
              final status = await myFuture;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(status!),
                duration: const Duration(seconds: 2),
              ));
            },
            child: const Text("upload image to your profile")),
      ],
    );
  }
}

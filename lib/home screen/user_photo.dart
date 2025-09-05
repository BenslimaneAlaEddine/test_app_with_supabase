import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({
    super.key,
    required this.avatar,
  });

  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.transparent,
        //glaena had ?tm mn gae l'affictation li kona ndiroha fkol mara nbadlo l9ima tae $avatar wakhtasarnaha zadna ?tm fblasa wahda wsay
        backgroundImage: avatar != null ? NetworkImage("$avatar?tm=${DateTime.now().millisecond}") : null,
        // key: UniqueKey(),
        child: avatar == null
            ? const Icon(
          Icons.account_circle,
          size: 60,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}
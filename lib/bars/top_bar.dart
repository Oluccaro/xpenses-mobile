import 'package:flutter/material.dart';

class TemplateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TemplateAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
            //Navigator.pop(context )
        },
        icon: const Icon(Icons.attach_money_outlined),
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Xpenses',
          selectionColor: Colors.blueGrey,),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
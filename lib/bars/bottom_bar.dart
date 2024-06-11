import 'package:flutter/material.dart';

class TemplateBarraInferior extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blueGrey,
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // children: _buildBottomBarItems(context),
        ),
      ),
    );
  }

  /*List<Widget> _buildBottomBarItems(BuildContext context) {
        return [
          IconButton(
            icon: const Icon(Icons.assignment),
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) =>));
            },
          ),
          IconButton(
            icon: const Icon(Icons.place_sharp),
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => ));
            },
          ),
        ];

    }*/

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

import 'package:flutter/material.dart';

class CharacterSelect extends StatelessWidget {
  const CharacterSelect({super.key});

  static const characters = [
    "Fred",
    "George",
    "Colin Creevey"
  ];

  @override
  Widget build(BuildContext context)
  {
    var pages = characters.map((character) {
      return Center(child:Column(children: [
        Text(character),
        ElevatedButton(onPressed: () {
          Navigator.pop(context, character);
        }, child: Text("Select Me!"))
      ],));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Character Selection")
      ),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, i) {
        return ElevatedButton(child:Text(characters[i]), onPressed: () {
          Navigator.pop(context, characters[i]);
        },);
      }, itemCount: characters.length,)
      //body: PageView(children: pages)
      /*
      body: ListView.builder(itemBuilder: (context, i) {
        return ListTile(
          title: Text(characters[i]),
          onTap: () {
            Navigator.pop(context, characters[i]);
          },
        );
      }, itemCount: characters.length,)
      */
    );
  }
}

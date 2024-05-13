import 'package:flutter/material.dart';

class CharacterSelectScreen extends StatefulWidget
{
  const CharacterSelectScreen({super.key});

  static const characterNames = [
    "Rick",
    "Saul",
    "Walter",
    "Peter",
    "Hakki",
    "Lindsay",
    "Jonno",
    "Ian",
    "Stroll"
  ];

  @override
  State<CharacterSelectScreen> createState() => _CharacterSelectScreenState();
}

class _CharacterSelectScreenState extends State<CharacterSelectScreen>
{
  //here is the state of the screen
  double health = 100;
  double attack = 100;
  String selectedCharacter = "Saul";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Character Select"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context, "$selectedCharacter\nHealth:$health\nAttack:$attack");
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTable(),
            buildCharacterSelector(context)
          ],
        ),
      )
    );
  }

  Widget buildTable() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FixedColumnWidth(100)
      },
      children: [
        TableRow(
          children: [
            Text("Health"),
            Slider(
              value: health,
              max: 100,
              onChanged: (value) {
                setState(() {
                  health = value;
                });
              }
            )
          ]
        ),
        TableRow(
          children: [
            Text("Attack"),
            Slider(
              value: attack,
              max: 100,
              onChanged: (value) {
                setState(() {
                  attack = value;
                });
              }
            )
          ]
        ),
      ],
    );
  }

  Widget buildCharacterSelector(BuildContext context)
  {
    //filter the list using where then transform the list using map
    List<DropdownMenuItem<String>> dropdownItems = CharacterSelectScreen.characterNames.where((element) => element.startsWith("S")).map(createDropdownItemFromString).toList();

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        label: Text("Character Name"),
        helperText: selectedCharacter == "Stroll" ? "Poor choice" :  "Select it or die"
      ),
      value: selectedCharacter,
      items: dropdownItems,
      onChanged: (selected) {
        setState(() {
          selectedCharacter = selected!;
        });
        //in other event-based frameworks
        //if (selectedCharacter == "stroll") { find the dropdown, set its helptext...}
      }
    );
  }

  DropdownMenuItem<String> createDropdownItemFromString(String input)
  {
    return DropdownMenuItem(child: Row(
      children: [
        Icon(Icons.person),
        Text(input),
      ],
    ), value: input);
  }
}

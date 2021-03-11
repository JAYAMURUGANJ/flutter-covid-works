import 'package:flutter/material.dart';

class SelectionChip extends StatefulWidget {
  final List<String> reportList;
  final Function(String) onSelectionChanged;

  SelectionChip(this.reportList, {this.onSelectionChanged});
  @override
  _SelectionChipState createState() => _SelectionChipState();
}

class _SelectionChipState extends State<SelectionChip> {
  String selectedChoice;
  // this function will build and return the choice list
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          selectedColor: Colors.orange,
          label: Text(item),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;

              widget.onSelectionChanged(selectedChoice);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

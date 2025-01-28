import 'package:flutter/material.dart';
import 'package:xpens/utils/database.dart';
import 'package:xpens/utils/functions.dart';
import 'package:xpens/variables.dart';

class FavouriteCategory extends StatelessWidget {
  FavouriteCategory(
      {super.key,
      required this.icon,
      required this.label,
      required this.addTransaction,
      this.isAddButton = false});

  final IconData icon;
  final String label;
  final bool isAddButton;
  final Function addTransaction;

  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: !isAddButton
                ? BoxDecoration(
                    color: Color.fromARGB(255, 241, 178, 255),
                    shape: BoxShape.circle,
                    boxShadow: [
                        BoxShadow(
                            color:
                                Colors.deepPurpleAccent.withValues(alpha: 0.5),
                            blurRadius: 20,
                            spreadRadius: 0.1,
                            offset: Offset(6.5, 12))
                      ])
                : BoxDecoration(),
            child: IconButton(
              onPressed: () {
                if (isAddButton) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        "Coming Soon...",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  //Show dialog
                  showDialog(
                      context: context,
                      builder: (context) {
                        String mode = "Transferred";

                        return AlertDialog(
                          shadowColor: Colors.blue,
                          backgroundColor:
                              Colors.deepPurpleAccent.withValues(alpha: 0.7),
                          surfaceTintColor:
                              Colors.lightBlueAccent.withValues(alpha: 0.5),
                          title: Text("New Transaction"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _controllerTitle,
                                decoration: InputDecoration(
                                    filled: false,
                                    hintText: "Enter title",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.white70)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.white70))),
                              ),
                              SizedBox(height: 20),
                              TextField(
                                controller: _controllerAmount,
                                decoration: InputDecoration(
                                    filled: false,
                                    hintText: "Enter amount",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.white70)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.white70))),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Category: "),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      label,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Select Mode: "),
                                  StatefulBuilder(builder: (context, setState) {
                                    return DropdownButton(
                                      value: mode,
                                      icon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: Colors.white70,
                                      ),
                                      elevation: 16,
                                      underline: SizedBox.shrink(),
                                      dropdownColor: Colors.deepPurpleAccent
                                          .withValues(alpha: 0.7),
                                      onChanged: (val) {
                                        setState(() {
                                          mode = val!;
                                        });
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          value: "Transferred",
                                          child: Text("Transferred"),
                                        ),
                                        DropdownMenuItem(
                                          value: "Received",
                                          child: Text("Received"),
                                        )
                                      ],
                                    );
                                  })
                                ],
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  if (_controllerTitle.text.isNotEmpty &&
                                      _controllerAmount.text.isNotEmpty) {
                                    addTransaction(
                                        _controllerTitle.text.toString(),
                                        label,
                                        mode,
                                        double.parse(
                                            _controllerAmount.text.toString()));
                                  }
                                  //Pop
                                  Navigator.pop(context);
                                },
                                child: Text("Done"))
                          ],
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                        );
                      });
                }
              },
              icon: Icon(icon),
              iconSize: 35,
              color: !isAddButton
                  ? Color.fromARGB(255, 209, 0, 251)
                  : Colors.white70,
            ),
          ),
          SizedBox(height: 8), // Space between the icon and text
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: !isAddButton ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

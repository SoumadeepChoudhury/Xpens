import 'package:flutter/material.dart';
import 'package:xpens/components/scanner.dart';
import 'package:xpens/utils/functions.dart';

class FavouriteCategory extends StatefulWidget {
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

  @override
  State<FavouriteCategory> createState() => _FavouriteCategoryState();
}

class _FavouriteCategoryState extends State<FavouriteCategory> {
  String qrData = "";
  bool isQRScannerOpened = false;
  bool isPaymentInitiated = false;

  TextEditingController _controllerTitle = TextEditingController();

  TextEditingController _controllerAmount = TextEditingController();

  TextEditingController _controllerUpiID = TextEditingController();

  TextEditingController _controllerPayeeName = TextEditingController();

  onReceive(String val, BuildContext _context) {
    if (val.startsWith("upi://pay")) {
      qrData = val;
    }
    Navigator.pop(_context);
    _showDiaLog();
  }

  void _showDiaLog() {
    showDialog(
        context: context,
        builder: (context) {
          String mode = "Transferred";
          bool isUPISelected = false;

          return AlertDialog(
              shadowColor: Colors.blue,
              backgroundColor: Colors.deepPurpleAccent.withValues(alpha: 0.7),
              surfaceTintColor: Colors.lightBlueAccent.withValues(alpha: 0.5),
              title: Text("New Transaction"),
              content: StatefulBuilder(builder: (context, setState) {
                return SingleChildScrollView(
                  child: Column(children: [
                    !isPaymentInitiated
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //Scan QR Code
                              !isUPISelected && !isQRScannerOpened
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isQRScannerOpened = true;
                                              });
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ScannerPage(
                                                            onReceive:
                                                                onReceive,
                                                          )));
                                            },
                                            child: Text("Scan QR Code")),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isUPISelected = true;
                                              });
                                            },
                                            child: Text("Enter UPI ID")),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              isQRScannerOpened
                                  ? Text("QR Scanned")
                                  : Container(),
                              isUPISelected
                                  ? TextField(
                                      controller: _controllerUpiID,
                                      decoration: InputDecoration(
                                          filled: false,
                                          hintText: "Enter UPI ID",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: Colors.white70)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: Colors.white70))),
                                    )
                                  : SizedBox.shrink(),
                              isUPISelected
                                  ? SizedBox(height: 20)
                                  : SizedBox.shrink(),
                              isUPISelected
                                  ? TextField(
                                      controller: _controllerPayeeName,
                                      decoration: InputDecoration(
                                          filled: false,
                                          hintText: "Enter payee name",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: Colors.white70)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: Colors.white70))),
                                    )
                                  : SizedBox.shrink(),
                              isUPISelected
                                  ? SizedBox(height: 20)
                                  : SizedBox.shrink(),
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
                                      widget.label,
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
                                  DropdownButton(
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
                                  )
                                ],
                              )
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Was the Payment Sucessful?",
                                style: TextStyle(fontSize: 20),
                              ),
                              TextButton(
                                  onPressed: () {
                                    if (isQRScannerOpened &&
                                        qrData.isNotEmpty &&
                                        _controllerTitle.text.isNotEmpty) {
                                      openUPIPayment(
                                          qrData: qrData,
                                          amount: double.parse(
                                              _controllerAmount.text),
                                          title: _controllerTitle.text);
                                    } else if (isUPISelected &&
                                        _controllerUpiID.text.isNotEmpty &&
                                        _controllerTitle.text.isNotEmpty &&
                                        _controllerPayeeName.text.isNotEmpty) {
                                      openUPIPayment(
                                          upiid: _controllerUpiID.text,
                                          amount: double.parse(
                                              _controllerAmount.text),
                                          title: _controllerTitle.text,
                                          payeename: _controllerPayeeName.text);
                                    }
                                  },
                                  child: Text("Re-initiate Payment")),
                            ],
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              isPaymentInitiated = false;
                              _controllerTitle.clear();
                              _controllerAmount.clear();
                              _controllerPayeeName.clear();
                              _controllerUpiID.clear();
                              isQRScannerOpened = false;
                              qrData = "";
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (isPaymentInitiated ||
                                  mode == "Received" ||
                                  (!isQRScannerOpened && !isUPISelected)) {
                                if (_controllerTitle.text.isNotEmpty &&
                                    _controllerAmount.text.isNotEmpty) {
                                  if (!isValidDecimal(_controllerAmount.text)) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        "Invalid Amount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      duration: Duration(seconds: 2),
                                    ));
                                  } else {
                                    widget.addTransaction(
                                        _controllerTitle.text.toString(),
                                        widget.label,
                                        mode,
                                        double.parse(
                                            _controllerAmount.text.toString()));
                                    //Pop
                                    Navigator.pop(context);
                                    isPaymentInitiated = false;
                                    _controllerTitle.clear();
                                    _controllerAmount.clear();
                                    _controllerPayeeName.clear();
                                    _controllerUpiID.clear();
                                    isQRScannerOpened = false;
                                    isUPISelected = false;
                                    qrData = "";
                                  } //Hide AlertDialog
                                }
                              } else if (isQRScannerOpened &&
                                  qrData.isNotEmpty &&
                                  _controllerTitle.text.isNotEmpty &&
                                  _controllerAmount.text.isNotEmpty &&
                                  mode == "Transferred") {
                                if (!isValidDecimal(_controllerAmount.text)) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "Invalid Amount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    duration: Duration(seconds: 2),
                                  ));
                                } else {
                                  setState(() {
                                    isPaymentInitiated = true;
                                  });
                                  openUPIPayment(
                                      qrData: qrData,
                                      amount:
                                          double.parse(_controllerAmount.text),
                                      title: _controllerTitle.text);
                                }
                              } else if (isUPISelected &&
                                  _controllerUpiID.text.isNotEmpty &&
                                  _controllerTitle.text.isNotEmpty &&
                                  _controllerPayeeName.text.isNotEmpty &&
                                  mode == "Transferred") {
                                if (!isValidDecimal(_controllerAmount.text)) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "Invalid Amount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    duration: Duration(seconds: 2),
                                  ));
                                } else {
                                  setState(() {
                                    isPaymentInitiated = true;
                                  });
                                  openUPIPayment(
                                      upiid: _controllerUpiID.text,
                                      amount:
                                          double.parse(_controllerAmount.text),
                                      title: _controllerTitle.text,
                                      payeename: _controllerPayeeName.text);
                                }
                              }
                            },
                            child: Text(isPaymentInitiated || mode == "Received"
                                ? "Done"
                                : "Pay"))
                      ],
                    ),
                  ]),
                );
              }));
        });
  }

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
            decoration: !widget.isAddButton
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
                if (widget.isAddButton) {
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
                  _showDiaLog();
                }
              },
              icon: Icon(widget.icon),
              iconSize: 35,
              color: !widget.isAddButton
                  ? Color.fromARGB(255, 209, 0, 251)
                  : Colors.white70,
            ),
          ),
          SizedBox(height: 8), // Space between the icon and text
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: !widget.isAddButton ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

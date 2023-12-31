import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context, String _title);
  Widget buildSubTitle(BuildContext context, String _subTitle);
  Widget buildTrailingAdult(BuildContext context);
}

class ItemViewModel with ChangeNotifier implements ListItem {
  int _indexAdult = 0;
  int _indexKid = 0;
  int _indexBaby = 0;
  int _indexOld = 0;
  int _indexStudent = 0;
  int _indexYoung = 0;
  fetchPassengerValue() {
    Map<String, int> passengerMap = Map();
    if (_indexAdult != 0) {
      passengerMap["Adult"] = _indexAdult;
    }
    if (_indexBaby != 0) {
      passengerMap["Baby"] = _indexBaby;
    }
    if (_indexKid != 0) {
      passengerMap["Kid"] = _indexKid;
    }
    return passengerMap;
  }

  readPassengerValue() async {
    try {
      Map<String, int> passengerMap = await fetchPassengerValue();
      return passengerMap;
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget buildSubTitle(BuildContext context, String _subTitle) {
    return Container(
      width: 150,
      height: 30,
      child: Text("($_subTitle)",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }

  @override
  Widget buildTitle(BuildContext context, String _title) {
    return Container(
      width: 150,
      height: 30,
      child: Text("$_title",
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget buildTrailingAdult(BuildContext context) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.do_disturb_on_outlined),
          onPressed: () {
            if (_indexAdult > 0) {
              decrementAdult();
            } else {
              Fluttertoast.showToast(
                  msg: "Passenger number cannot below zero",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          iconSize: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "${_indexAdult.toString()}",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          icon: Icon(Icons.add_box_outlined),
          onPressed: incrementAdult,
          iconSize: 30,
        ),
      ],
    ));
  }

  Widget buildTrailingKid(BuildContext context) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.do_disturb_on_outlined),
          onPressed: () {
            if (_indexKid > 0) {
              decrementKid();
            } else {
              Fluttertoast.showToast(
                  msg: "Passenger number cannot below zero",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          iconSize: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "${_indexKid.toString()}",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          icon: Icon(Icons.add_box_outlined),
          onPressed: incrementKid,
          iconSize: 30,
        ),
      ],
    ));
  }

  Widget buildTrailingBaby(BuildContext context) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.do_disturb_on_outlined),
          onPressed: () {
            if (_indexBaby > 0) {
              decrementBaby();
            } else {
              Fluttertoast.showToast(
                  msg: "Passenger number cannot below zero",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          iconSize: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "${_indexBaby.toString()}",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          icon: Icon(Icons.add_box_outlined),
          onPressed: incrementBaby,
          iconSize: 30,
        ),
      ],
    ));
  }


  incrementAdult() {
    _indexAdult++;
    notifyListeners();
  }

  incrementKid() {
    _indexKid++;
    notifyListeners();
  }

  incrementBaby() {
    _indexBaby++;
    notifyListeners();
  }


  decrementAdult() {
    _indexAdult--;
    notifyListeners();
  }

  decrementKid() {
    _indexKid--;
    notifyListeners();
  }

  decrementBaby() {
    _indexBaby--;
    notifyListeners();
  }


  buildTrailing(BuildContext context, String titleList) {
    if (titleList == "Adult") return buildTrailingAdult(context);
    if (titleList == "Kid") return buildTrailingKid(context);
    if (titleList == "Baby") return buildTrailingBaby(context);
  }
}
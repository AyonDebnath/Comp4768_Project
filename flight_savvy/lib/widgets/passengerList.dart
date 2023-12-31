import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flight_savvy/view/passengerView.dart';

class OpenPassengerList extends StatelessWidget {
  @override
  Widget build(
      BuildContext context,
      ) {
    List<String> titleList = [];
    titleList.add("Adult");
    titleList.add("Kid");
    titleList.add("Baby");
    List<String> subTitleList = [];
    subTitleList.add("Over 24 ");
    subTitleList.add("Between 2-11 ");
    subTitleList.add("Between 0-2 ");

    return Scaffold(
        appBar: AppBar(

          centerTitle: true,
          title: Text(
            "Select Passenger",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            Consumer<ItemViewModel>(builder: (context, item, child) {
              return IconButton(
                  icon: Icon(
                    Icons.done_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    Map<String, int> passengermap =
                    await item.fetchPassengerValue();
                    Navigator.pop(context, passengermap);
                  });
            })
          ],
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.pop(context, null);
            },
          ),
        ),
        body: Consumer<ItemViewModel>(builder: (context, item, child) {
          return Container(
            padding: EdgeInsets.only(left: 20, right: 10, top: 20),
            child: ListView.builder(
              itemCount: titleList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                item.buildTitle(context, titleList[index]),
                                item.buildSubTitle(
                                    context, subTitleList[index]),
                              ],
                            ),
                            Container(
                              child:
                              item.buildTrailing(context, titleList[index]),
                            )
                          ]),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }));
  }
}
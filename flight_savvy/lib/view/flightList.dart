import 'package:flight_savvy/view/flightSegmentsDetails.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../controller/controller.dart';
import 'flightCard.dart';
import 'package:animations/animations.dart';

enum FlightSort { best, fastest, cheapest }

class FlightList extends StatefulWidget {
  List<dynamic> vals;
  bool toShow;
  final controller cont = controller();

  FlightList(this.toShow, this.vals);

  @override
  _FlightListState createState() => _FlightListState();
}

class _FlightListState extends State<FlightList> {
  FlightSort selectedSort = FlightSort.best; // Default sorting option

  Future<List<List<List<dynamic>>>> getSortedFlights(
      FlightSort sortOption) async {
    List<List<List<dynamic>>> flights = await widget.cont.getDate(
      widget.vals[0],
      widget.vals[1],
      widget.vals[2],
      widget.vals[3],
      widget.vals[4],
      widget.vals[5],
    );

    switch (sortOption) {
      case FlightSort.best:
        flights
            .sort((a, b) => a[0][4].compareTo(b[0][4])); // Sort by arrivalTime
        break;
      case FlightSort.fastest:
        flights.sort((a, b) => a[0][0].compareTo(b[0][0])); // Sort by duration
        break;
      case FlightSort.cheapest:
        flights.sort((a, b) => a[0][6].compareTo(b[0][6])); // Sort by price
        break;
    }

    return flights;
  }

  Future<void> applyFilter(FlightSort filter) async {
    setState(() {
      selectedSort = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.toShow) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: 10,
          width: 500,
          child: const Text(
            "",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey,
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: FutureBuilder<List<List<List<dynamic>>>>(
          future: getSortedFlights(selectedSort),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text(
                  'Fetching Flights ',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            List<List<List<dynamic>>>? data = snapshot.data;

            if (data == null || data.isEmpty) {
              return Center(
                  child: Text(
                    "No Flights Found ",
                    style: TextStyle(fontFamily: 'OverpassM', fontSize: 25),
                  ));
            }

            return Column(
              children: [
                // Sorting Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        applyFilter(FlightSort.best);
                      },
                      child: Text('Best'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        applyFilter(FlightSort.fastest);
                      },
                      child: Text('Fastest'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        applyFilter(FlightSort.cheapest);
                      },
                      child: Text('Cheapest'),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var flight_instance = data[index][0];
                      List<dynamic> flight_instance2 = [];
                      if (widget.vals[2] == false) {
                        flight_instance2 = data[index][1];
                      }
                      //rint(flight_instance.last);
                      return OpenContainer(
                        closedBuilder: (BuildContext context, VoidCallback _) {
                          return Container(
                            height: widget.vals[2] == false ? 235 : 135,
                            child: Column(children: [
                              Center(
                                child: FlightCard([
                                  flight_instance[0],
                                  flight_instance[6],
                                  'Lufthansa',
                                  flight_instance[4],
                                  '202131',
                                  flight_instance[1].toString(),
                                  flight_instance[3].toString(),
                                  flight_instance[2],
                                ]),
                              ),
                              widget.vals[2] == true
                                  ? const Gap(0)
                                  : Center(
                                child: flightCardRet([
                                  flight_instance2[0],
                                  flight_instance2[6],
                                  'Lufthansa',
                                  flight_instance2[4],
                                  '202131',
                                  flight_instance2[1].toString(),
                                  flight_instance2[3].toString(),
                                  flight_instance2[2],
                                ]),
                              ),
                            ]),
                          );
                        },
                        openBuilder:
                            (BuildContext context, VoidCallback openContainer) {
                          return flightSegmentDetails(
                              flight_instance2.isEmpty == true
                                  ? []
                                  : flight_instance2.last,
                              duration: flight_instance[0],
                              price: flight_instance[6],
                              airline: 'Lufthansa',
                              arrivalTime: flight_instance[4],
                              flightNumber: '202131',
                              departure: flight_instance[1].toString(),
                              destination: flight_instance[3].toString(),
                              departureTime: flight_instance[2],
                              segments: flight_instance.last,
                              isOneway: widget.vals[2]);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
  }
}
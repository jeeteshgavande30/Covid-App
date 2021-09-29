import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:corona_app/globals.dart' as g;
import 'dart:convert';
import 'slotcard.dart';

class CentreList extends StatefulWidget {
  @override
  _CentreListState createState() => _CentreListState();
}

class _CentreListState extends State<CentreList> {
  String districtID = '';
  String url = "";
  List centerList = [];

  Future<void> getData() async {
    if (g.selectedState == 'Select State' &&
        g.selectedDistrict == 'Select District' &&
        g.enteredPin == "") {
      print("nothing");
      return;
    } else if (g.selectedState == 'Select State' &&
        g.selectedDistrict == 'Select District') {
      url =
          'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=${g.enteredPin}&date=${g.selectedDate}';
      g.selectedDistrict = g.enteredPin;
    } else {
      url =
          'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=${g.statedistdata[g.selectedState]![g.selectedDistrict]}&date=${g.selectedDate}';
    }

    Response response = await get(Uri.parse(url));
    var mapTemp = json.decode(response.body)['sessions'] as List<dynamic>;
    centerList = mapTemp;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (centerList.isNotEmpty) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        g.selectedDistrict + ', ' + g.selectedState,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      ExpandChild(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (var i = 0; i < centerList.length; i++)
                              SlotCard(
                                map: centerList[i],
                                showDivider: centerList.length > 1,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            centerList.isEmpty)
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  softWrap: true,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Not available in ',
                    style: TextStyle(fontSize: 24),
                    children: [
                      TextSpan(
                        text: g.selectedDistrict,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        else
          return placeHolderWithText();
      },
    );
  }

  Widget placeHolderWithText() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              child: LoadingIndicator(
                indicatorType: Indicator.ballScale,
                pathBackgroundColor: Colors.white,
              ),
            ),
            SizedBox(width: 5),
            Text(
              'Checking on ' + g.selectedDistrict,
              style: TextStyle(
                fontSize: 16,
                height: 1,
              ),
            ),
          ],
        ),
      );
}

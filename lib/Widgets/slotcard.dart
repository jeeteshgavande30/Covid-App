import 'package:flutter/material.dart';
import 'displaycard.dart';

class SlotCard extends StatelessWidget {
  final Map map;
  final bool showDivider;

  SlotCard({required this.map, Key? key, this.showDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String blockName = map['address'].toString();
    final String pinCode = map['pincode'].toString();
    String address = '${map['address']}, $pinCode';

    if (address.isEmpty) address = blockName + pinCode;
    final String availableDoses = map['available_capacity'].toString();
    final String doses1 = map['available_capacity_dose1'].toString();
    final String doses2 = map['available_capacity_dose2'].toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DisplayCard(
          text: map['name'].toString(),
          header: 'Name: ',
        ),
        DisplayCard(
          text: availableDoses,
          header: 'Available Doses: ',
          color: Colors.grey,
        ),
        Row(
          children: [
            DisplayCard(
              text: doses1,
              header: 'Dose 1: ',
              color: Colors.grey,
            ),
            DisplayCard(
              text: doses2,
              header: 'Dose 2: ',
              color: Colors.grey,
            ),
          ],
        ),
        DisplayCard(
          text: map['vaccine'].toString(),
          header: 'Vaccine: ',
          color: Colors.blue,
        ),
        DisplayCard(
          text: map['min_age_limit'].toString(),
          header: 'Min Age Limit: ',
        ),
        DisplayCard(
          text: address,
          header: 'Address: ',
        ),
        DisplayCard(
          text: map['fee'].toString() == '0'
              ? 'Free'
              : map['fee'].toString() + '₹',
          header: 'Fee Type: ',
        ),
        if (showDivider) Divider(),
      ],
    );
  }
}

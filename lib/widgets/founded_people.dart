import 'package:flutter/material.dart';

class FoundedPeopleContainer extends StatelessWidget {
  final String nameOfFounded;
  final String dateOfReported;
  final String placesOfChild;
  final String ageOfChild;
  final String price;
  final String dateTime;
  final String bookingDate;
  final Color borderColor;
  final Function? onTap;
  var list;
  String docId;
   FoundedPeopleContainer({
    super.key,
    this.onTap,
    required this.borderColor,
    required this.docId,
    required this.list,
    required this.placesOfChild,
    required this.price,
    required this.dateTime,
    required this.bookingDate,
    required this.nameOfFounded,
    required this.dateOfReported, required this.ageOfChild,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  nameOfFounded,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  dateOfReported,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          placesOfChild,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          " عام ",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          " ${ageOfChild} ",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
                width: 50.00,
                height: 50.00,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/images/logo.png'),
                    fit: BoxFit.fitHeight,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}

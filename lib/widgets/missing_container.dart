import 'package:flutter/material.dart';

class MissingContainer extends StatelessWidget {
  final String NameOfMissing;
  final String nameOfLine;
  final String ticketType;
  final String arrivalPoint;
  final String price;
  final String dateTime;
  final String bookingDate;
  final Color borderColor;
  final Function? onTap;
  const MissingContainer({
    super.key,
    this.onTap,
    required this.NameOfMissing,
    required this.borderColor,
    required this.ticketType,
    required this.arrivalPoint,
    required this.price,
    required this.dateTime,
    required this.nameOfLine,
    required this.bookingDate,
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
                  NameOfMissing,
                  style:Theme.of(context).textTheme.displayMedium,
                ),

                Text(
                  "متغيبة بتاريخ 14/1/2023",
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                Row(

                  children: [
                    Row(
                      children: [
                        Text(
                          "المعادي",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(width: 5,),

                        Icon(
                          Icons.location_on_outlined,size: 15,
                        ),

                      ],
                    ),
                    SizedBox(width: 5,),
                    Row(
                      children: [
                        Text(
                          "15 عام",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(width: 5,),

                        Icon(
                          Icons.calendar_today_outlined,size: 15,
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

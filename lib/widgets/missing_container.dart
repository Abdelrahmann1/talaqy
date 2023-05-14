import 'package:flutter/material.dart';

class MissingContainer extends StatelessWidget {
  final String nameOfMissing;
  final String placesOfMissing;
  final String ageOfMissing;
  final Color borderColor;
  final Function? onTap;
  const MissingContainer({
    super.key,
    this.onTap,
    required this.borderColor,
    required this.ageOfMissing,
    required this.nameOfMissing, required this.placesOfMissing,
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
                  nameOfMissing,
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
                          placesOfMissing,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(width: 5,),

                        const Icon(
                          Icons.location_on_outlined,size: 15,
                        ),

                      ],
                    ),
                    const SizedBox(width: 5,),
                    Row(
                      children: [
                        Text("عام",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(width: 3,),

                        Text(ageOfMissing,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(width: 4,),

                        const Icon(
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

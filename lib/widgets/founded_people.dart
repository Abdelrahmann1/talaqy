import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FoundedPeopleContainer extends StatelessWidget {
  final String nameOfFounded;
  final String dateOfReported;
  final String placesOfChild;
  final String ageOfChild;
  final Color borderColor;
  final Function? onTap;
  dynamic list;
  final String imageUrl;

  String docId;
   FoundedPeopleContainer({
    super.key,
    this.onTap,
    required this.borderColor,
    required this.docId,
    required this.list,
    required this.placesOfChild,
    required this.nameOfFounded,
    required this.dateOfReported,
     required this.ageOfChild,
     required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nameOfFounded,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Row(
                  children: [
                    Text(
                      dateOfReported,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(width: 6,),

                    Text(
                      "تاريخ الإبلاغ",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
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

          ],
        ),
        Container(
          width: 140 ,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) =>  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>  const Icon(Icons.error_outline),
              fit: BoxFit.fill,

          ),
        ),
      ],
    );
  }
}

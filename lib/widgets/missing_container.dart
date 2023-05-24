import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MissingContainer extends StatelessWidget {
  var list;
  String docId;
  final String nameOfMissing;
  final String imageUrl;
  final String placesOfMissing;
  final String ageOfMissing;
  final Color borderColor;
  final String dateOfMissing;
  final Function? onTap;
  MissingContainer({
    super.key,
    this.onTap,
    required this.borderColor,
    required this.list,
    required this.docId,
    required this.ageOfMissing,
    required this.nameOfMissing,
    required this.placesOfMissing,
    required this.imageUrl,
    required this.dateOfMissing,
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
                  nameOfMissing,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Row(
                  children: [

                      Text(
                        dateOfMissing,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    const SizedBox(
                      width: 5,
                    ),

                    Text(
                      "متغيبة بتاريخ ",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          placesOfMissing,
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
                          "عام",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          ageOfMissing,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          width: 4,
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
        SizedBox(
          height:double.infinity ,
          width:140 ,
          child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) =>  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>  const Icon(Icons.error_outline),
              fit: BoxFit.fill
          ),
        ),
      ],
    );
  }
}

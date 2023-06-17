import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talaqy/extentions/padding_ext.dart';

class MissingContainer extends StatelessWidget {
  var list;
  String docId;
  final String nameOfMissing;
  final String imageUrl;
  final String placesOfMissing;
  final String ageOfMissing;
  final Color borderColor;
  final String dateOfMissing;
  final String locationOfCity;
  final String locationOfSection;
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
    required this.dateOfMissing, required this.locationOfCity, required this.locationOfSection,
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
                Row(
                  children: [
                    Text(
                      nameOfMissing,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),

                    const Icon(
                      Icons.person,
                      size: 15,
                    ),
                  ],
                ),
                const SizedBox(height: 5,),

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
                    const Icon(
                      Icons.date_range,
                      size: 15,
                    ),
                  ],
                ),
                const SizedBox(height: 5,),

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
                          Icons.bloodtype_outlined,
                          size: 15,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [

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
                        Text(
                          "السن",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          width: 4,
                        ),


                        const Icon(
                          Icons.view_agenda_outlined,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          locationOfSection,
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
                          locationOfCity,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.location_city_outlined,
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
              errorWidget: (context, url, error) =>  Image.asset("assets/images/logo.png"), fit: BoxFit.fill
          ),
        ),
      ],
    );
  }
}

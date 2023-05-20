import 'package:flutter/material.dart';
import 'package:talaqy/utils/app_colors.dart';

class ReportsCards extends StatelessWidget {
  var list;
  String docId;
  String statusOfChild;
  String nameOfMissing;
  String dateOfMissing;
  String placeOfMissing;
  String ageOfMissing;
  String dateOfBirthOfMissing;
  final Function onTapEdit;
  final Function onTapDelete;
   ReportsCards( {Key? key ,required this.dateOfMissing,required this.docId ,required this.nameOfMissing,required this.dateOfBirthOfMissing,required this.ageOfMissing,required this.placeOfMissing, required this.onTapEdit, required this.onTapDelete,required this.list,required this.statusOfChild}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      Container(
      width: 327,
      height: 252,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dateOfMissing,
                    style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40.0,
                  backgroundImage:AssetImage("assets/images/person.jpg",),

                ),
                const SizedBox(
                  height: 5,
                ) ,
                Text(nameOfMissing,
                    style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(
                  height: 8,
                ),

                Text("$statusOfChild$dateOfMissing",
                    style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                         " عام $ageOfMissingِ" ,
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
                    const SizedBox(
                      width: 8,
                    ),

                    Row(
                      children: [
                        Text(
                          placeOfMissing,
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

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      InkWell(
                        onTap:onTapDelete as void Function()? ,
                        child: Container(
                          alignment: Alignment.center,
                          width: 116,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text("إنهاء النشر",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w400
                             ),
                          ) ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap:onTapEdit as void Function()? ,
                        child: Container(
                          alignment: Alignment.center,
                          width: 116,
                          height: 36,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2.0,
                            ),
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text("تعديل البيانات",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingModel{
  String? title;
  String? subtitle;
  String? image;
  OnBoardingModel({
    required this.title,required this.subtitle,required this.image});}
final List <OnBoardingModel>onBoardingList = [
  OnBoardingModel(title: "يمكنك إيجاد احبائك الضائعين عن طريق توافق", subtitle: "Custom trips for you. And for your needs with the captain, their task is to comfort you and deliver you on time",image: "assets/images/onboarding1.png"),
  OnBoardingModel(title: "قم بإدخال كافة البيانات والصور الخاصة بطفلك", subtitle: "Because your time matters to us.Decide that we are doing the best offers for your trips whether for school",image: "assets/images/onboarding2.png",),
  OnBoardingModel(title: "قم بنشر كل المعلومات حتي تصل الي جميع الناس من خلال التطبيق", subtitle: "Our stations are not more than 5 minutes away from you, whether at home, work or anywhere",image: "assets/images/onboading3.jpeg")
];
class OnBoardingModel{
  String? title;
  String? subtitle;
  String? image;
  OnBoardingModel({
    required this.title,required this.subtitle,required this.image});}
final List <OnBoardingModel>onBoardingList = [
  OnBoardingModel(title: "يمكنك إيجاد احبائك الضائعين عن طريق تلاقي", subtitle: "",image: "assets/images/onboarding1.png"),
  OnBoardingModel(title: "قم بإدخال كافة البيانات والصور الخاصة بالمفقود و الموجود", subtitle: "",image: "assets/images/onboarding2.png",),
  OnBoardingModel(title: "قم بنشر كل المعلومات حتي تصل الي جميع الناس من خلال التطبيق", subtitle: "",image: "assets/images/onboading3.jpeg")
];
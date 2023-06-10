import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/extentions/padding_ext.dart';
import 'package:talaqy/models/onboarding_model.dart';
import 'package:talaqy/pages/onboarding_screen/onboarding_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';
import 'package:talaqy/utils/app_router.dart';
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const OnBoardingView(),
      viewModel: OnBoardingViewModel(),
    );
  }}
class OnBoardingView extends HookView<OnBoardingViewModel> {
  const OnBoardingView({super.key, reactive = true});
  @override
  Widget render(context, viewModel) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                      controller: viewModel.pageController,
                      onPageChanged:(val){
                        viewModel.onPageChanged(val);
                      } ,
                      itemCount: onBoardingList.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,left: 8),
                              child: Text(
                                onBoardingList[i].title!,
                                style:const TextStyle(fontSize: 16,color: AppColors.blackColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),

                            Image.asset(
                              onBoardingList[i].image!.toString(),
                              height:250,
                              fit: BoxFit.contain,
                            )

                          ],
                        );
                      }),
                ),
                Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                                onBoardingList.length,
                                    (index) => AnimatedContainer(
                                  margin: const EdgeInsets.only(right: 7),
                                  duration: const Duration(milliseconds: 900),
                                  width: viewModel.currentPage==index?30:13,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                ))
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(35)),
                              margin: const EdgeInsets.only(bottom: 40),
                              height: 50,
                              child: MaterialButton(
                                padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 0),
                                onPressed: () {
                                  viewModel.nextPage();
                                },color: AppColors.primaryColor,textColor: Colors.white,
                                child:  Text( viewModel.currentPage==2?"إبدأ    ":"التالي",style: Theme.of(context).textTheme.bodyMedium,),
                              ),
                            ),
                            TextButton(onPressed: (){
                              Navigator.pushNamed(context, AppRouter.registerScreen);
                            },child: const Text("تخطي",style: TextStyle(color: AppColors.blackColor),))
                          ],
                        ),

                      ],
                    )),
              ],
            ).setPageHorizontalPadding(context)
        )
    );
  }
}

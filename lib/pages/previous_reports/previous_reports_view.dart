import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:talaqy/pages/previous_reports/previous_reports_view_model.dart';
import 'package:talaqy/utils/app_colors.dart';
class PreviousReportsScreen extends StatelessWidget{
  const PreviousReportsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => const PreviousReportsView(),
      viewModel: PreviousReportsViewModel(),
    );
  }
}
class PreviousReportsView extends HookView<PreviousReportsViewModel>{
  const PreviousReportsView({Key? key, reactive = true});
  @override
  Widget render(context, viewModel) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text("PreviousReports"),
    ));
  }}

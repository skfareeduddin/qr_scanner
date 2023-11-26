import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class ResponseScreen extends StatelessWidget {
  final String? codeText;
  final Function? closeScreen;

  const ResponseScreen(
      {super.key, required this.codeText, required this.closeScreen});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        closeScreen?.call();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'The result of your QR is below:-',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText1?.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0.sp,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Gap(10.h),
                Container(
                  width: 80.w,
                  height: 30.h,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Text(
                        codeText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyText1?.fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0.sp,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

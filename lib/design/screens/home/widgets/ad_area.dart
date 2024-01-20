import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/common/constants/const_color.dart';
import 'package:flutter_steps_tracker/lang/l10n.dart';
import 'package:flutter_steps_tracker/common/constants/const_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdArea extends StatelessWidget {
  const AdArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.12,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).areyouready,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              SvgPicture.asset(
                AppAssets.kReadyUser,
                fit: BoxFit.cover,
                height: 60,
                color: AppColors.kBackgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

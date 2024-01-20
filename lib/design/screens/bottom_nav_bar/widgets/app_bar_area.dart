import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/common/constants/const_color.dart';
import 'package:flutter_steps_tracker/lang/l10n.dart';
import 'package:flutter_steps_tracker/common/constants/const_assets.dart';
import 'package:flutter_steps_tracker/common/constants/const_languages.dart';
import 'package:flutter_steps_tracker/design/cubits/utility/utility_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AppBarArea extends StatelessWidget {
  const AppBarArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utilityCubit = Provider.of<UtilityCubit>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async => await utilityCubit.changeLocale(
                utilityCubit.locale == KeyConstants.arabicLocale
                    ? KeyConstants.englishLocale
                    : KeyConstants.arabicLocale,
              ),
              child: Text(
                utilityCubit.locale == KeyConstants.arabicLocale ? 'EN' : 'AR',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.logo,
                  color: AppColors.kTotalStepsColor,
                ),
                Text(
                  S.of(context).pedometer,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
            InkWell(
              onTap: () async =>
                  await Provider.of<UtilityCubit>(context, listen: false)
                      .switchTheme(),
              child: Icon(
                utilityCubit.isDark ? Icons.sunny : CupertinoIcons.moon_fill,
                size: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

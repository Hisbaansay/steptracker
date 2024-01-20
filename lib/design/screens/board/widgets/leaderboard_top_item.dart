import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/common/constants/const_color.dart';
import 'package:flutter_steps_tracker/driven/models/user_model.dart';
import 'package:flutter_steps_tracker/common/constants/const_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderboardTopItem extends StatelessWidget {
  final UserModel item;
  final int sNumber;
  final bool first;

  const LeaderboardTopItem({
    Key? key,
    required this.item,
    required this.sNumber,
    this.first = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          sNumber.toString(),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Theme.of(context).primaryColorDark),
        ),
        const SizedBox(height: 4.0),
        Icon(
          CupertinoIcons.arrowtriangle_up_fill,
          color: Theme.of(context).primaryColorLight,
        ),
        const SizedBox(height: 8.0),
        CircleAvatar(
          radius: first ? 70 : 58,
          backgroundColor: AppColors.kPrimaryColor,
          child: CircleAvatar(
            backgroundColor: AppColors.kBackgroundColor,
            radius: first ? 80 : 60,
            child: SvgPicture.asset(AppAssets.kProfileUser),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          item.name,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          item.totalSteps.toString(),
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

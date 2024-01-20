import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/driven/models/user_model.dart';
import 'package:flutter_steps_tracker/common/constants/const_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderboardItem extends StatelessWidget {
  final UserModel item;
  final int sNumber;

  const LeaderboardItem({
    Key? key,
    required this.item,
    required this.sNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              sNumber.toString(),
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                  ),
            ),
            const SizedBox(width: 4.0),
            Icon(
              CupertinoIcons.arrowtriangle_up_fill,
              color: Theme.of(context).primaryColorLight,
              size: 20,
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: SvgPicture.asset(AppAssets.kProfileUser),
              ),
              const SizedBox(width: 50.0),
              Text(
                item.name,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w100,
                    ),
              ),
              const Spacer(),
              Text(
                item.totalSteps.toString(),
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w100,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

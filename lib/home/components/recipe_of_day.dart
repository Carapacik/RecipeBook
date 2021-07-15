import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipebook/home/block/recipe_info.dart';
import 'package:recipebook/resources/icons.dart';
import 'package:recipebook/resources/palette.dart';

class RecipeOfDayWidget extends StatelessWidget {
  final RecipeInfo recipeInfo;

  const RecipeOfDayWidget({
    Key? key,
    required this.recipeInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: 543,
              height: 543,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(72),
                  bottomRight: Radius.circular(72),
                ),
              ),
              child: Image.asset(
                recipeInfo.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 38),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(5),
                ),
              ),
              child: Text(
                recipeInfo.author,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Palette.orange,
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 62),
          width: 513,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                CookingIcons.recipeOfDay,
                height: 95,
              ),
              const SizedBox(height: 32),
              Text(
                recipeInfo.name,
                style: const TextStyle(
                  color: Palette.main,
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Text(
                recipeInfo.description,
                style: const TextStyle(
                  color: Palette.mainLighten1,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
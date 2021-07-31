import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipebook/resources/icons.dart';
import 'package:recipebook/resources/images.dart';
import 'package:recipebook/resources/palette.dart';
import 'package:recipebook/route.dart';
import 'package:recipebook/screens/recipes/components/recipe_item_widget.dart';
import 'package:recipebook/theme.dart';
import 'package:recipebook/widgets/category_card.dart';
import 'package:recipebook/widgets/components/header_buttons.dart';
import 'package:recipebook/widgets/contained_button.dart';
import 'package:recipebook/widgets/header_widget.dart';
import 'package:recipebook/widgets/search_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SvgPicture.asset(
              CookingImages.wave1,
              color: Palette.wave,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1000),
              child: SvgPicture.asset(
                CookingImages.wave2,
                color: Palette.wave,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const HeaderWidget(currentSelectedPage: HeaderButtons.recipes),
            Padding(
              padding: const EdgeInsets.only(top: 160, left: 120, right: 120),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Рецепты",
                        style: Theme.of(context).textTheme.b42,
                      ),
                      ButtonContainedWidget(
                        text: "Добавить рецепт",
                        width: 278,
                        height: 60,
                        onPressed: () {
                          context.vxNav.push(Uri.parse(RecipeRoutes.addRecipeRoute));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryCardWidget(
                        iconPath: CookingIcons.menu,
                        title: "Простые блюда",
                      ),
                      CategoryCardWidget(
                        iconPath: CookingIcons.cook,
                        title: "Детское",
                      ),
                      CategoryCardWidget(
                        iconPath: CookingIcons.chef,
                        title: "От шеф-поваров",
                      ),
                      CategoryCardWidget(
                        iconPath: CookingIcons.confetti,
                        title: "На праздник",
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Поиск рецепта",
                        style: Theme.of(context).textTheme.b24,
                      ),
                      const SearchWidget(width: 779),
                    ],
                  ),
                  const SizedBox(height: 80),
                  RecipeItemWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
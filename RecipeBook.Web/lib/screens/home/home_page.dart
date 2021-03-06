import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:recipebook/notifier/auth_notifier.dart';
import 'package:recipebook/resources/icons.dart';
import 'package:recipebook/resources/images.dart';
import 'package:recipebook/resources/palette.dart';
import 'package:recipebook/screens/home/components/recipe_of_day.dart';
import 'package:recipebook/theme.dart';
import 'package:recipebook/widgets/category_card.dart';
import 'package:recipebook/widgets/contained_button.dart';
import 'package:recipebook/widgets/header_buttons.dart';
import 'package:recipebook/widgets/header_widget.dart';
import 'package:recipebook/widgets/login_dialog.dart';
import 'package:recipebook/widgets/not_auth_dialog.dart';
import 'package:recipebook/widgets/outlined_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController? textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            SvgPicture.asset(
              CookingImages.wave1,
              color: Palette.wave,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 900),
              child: SvgPicture.asset(
                CookingImages.wave2,
                color: Palette.wave,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              width: 602,
              height: 800,
              child: Image.asset(CookingImages.homeBackground),
            ),
            const HeaderWidget(currentSelectedPage: HeaderButtons.home),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                margin: const EdgeInsets.only(top: 210),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 688,
                      child: Text(
                        "???????????? ?? ???????????? ??????????????????",
                        style: Theme.of(context).textTheme.b72,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 566,
                      child: Text(
                        "?????????????? ???????????????????? ???????? ?? ??????????????????! ?????????? ?????? ?????????????? ?????????????? ?? ?????????? ??????????.",
                        style: Theme.of(context).textTheme.r18,
                      ),
                    ),
                    const SizedBox(height: 42),
                    Row(
                      children: [
                        ButtonContainedWidget(
                          icon: Icons.add,
                          padding: 18,
                          text: "???????????????? ????????????",
                          width: 278,
                          height: 60,
                          onPressed: authNotifier.isAuth
                              ? () {
                                  context.beamToNamed("/recipes/add");
                                }
                              : () {
                                  notAuthDialog(
                                    context,
                                    "?????????????????? ?????????????? ?????????? ???????????? ???????????????????????????????? ????????????????????????.",
                                  );
                                },
                        ),
                        const SizedBox(width: 24),
                        if (!authNotifier.isAuth)
                          ButtonOutlinedWidget(
                            text: "??????????",
                            width: 216,
                            height: 60,
                            onPressed: () {
                              loginDialog(context);
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 352),
                    Text(
                      "?????????? ???????????????????? ???? ??????????",
                      style: Theme.of(context).textTheme.b42,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 700,
                      child: Text(
                        "???????????????? ?????????????? ?? ???????????????? ???????????????? ???????????????????? ????????. ?????? ???????????????? ???????????? ???????????????? ?????????? ??????????????????.",
                        style: Theme.of(context).textTheme.r18,
                      ),
                    ),
                    const SizedBox(height: 42),
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoryCardWidget(
                            iconPath: CookingIcons.menu,
                            title: "?????????????? ??????????",
                            searchQuery: "??????????????",
                            description: "?????????? ???????????????????????? ?????????? ???????? ???? ?????????? 1 ????????",
                          ),
                          CategoryCardWidget(
                            iconPath: CookingIcons.cook,
                            title: "??????????????",
                            searchQuery: "??????????????",
                            description: "?????????? ???????????????? ?????????? ?????????????? ?????????? ?????????? ???????????? ????????????????",
                          ),
                          CategoryCardWidget(
                            iconPath: CookingIcons.chef,
                            title: "???? ??????-??????????????",
                            searchQuery: "??????-??????????",
                            description: "?????????????? ????????????, ?????????????? ?? ????????????????, ???????? ?????? ?? ??????????????????",
                          ),
                          CategoryCardWidget(
                            iconPath: CookingIcons.confetti,
                            title: "???? ????????????????",
                            searchQuery: "????????????????",
                            description: "?????? ?????????????? ????????????, ?????????? ?????? ???????? ???????? ???? ?????????????????????? ????????????",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 157),
                    const RecipeOfDayWidget(),
                    const SizedBox(height: 150),
                    Column(
                      children: [
                        Text(
                          "?????????? ????????????????",
                          style: Theme.of(context).textTheme.b42,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "?????????????? ?????????????????? ???????????????? ??????????, ?? ???? ???? ?????????? ???????????? ??????",
                          style: Theme.of(context).textTheme.r18.copyWith(color: Palette.main),
                        ),
                        const SizedBox(height: 64),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 73,
                                width: 716,
                                padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Palette.shadowColor,
                                      offset: Offset(0, 8),
                                      blurRadius: 42,
                                    )
                                  ],
                                ),
                                child: TextField(
                                  controller: textController,
                                  cursorColor: Palette.orange,
                                  style: Theme.of(context).textTheme.r18.copyWith(color: Palette.main),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "???????????????? ??????????...",
                                    hintStyle: Theme.of(context).textTheme.r16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ButtonContainedWidget(
                                text: "??????????",
                                width: 152,
                                height: 73,
                                onPressed: () {
                                  context.beamToNamed("/recipes?searchQuery=${textController!.text}");
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fish_redux/fish_redux.dart';
import 'package:recipebook/pages/favorite/page.dart';
import 'package:recipebook/pages/home/page.dart';
import 'package:recipebook/pages/profile/page.dart';
import 'package:recipebook/pages/recipe_detail/page.dart';
import 'package:recipebook/pages/recipe_form/page.dart';
import 'package:recipebook/pages/recipes/page.dart';

class Routes {
  static final PageRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      RoutePath.homePage: HomePage(),
      RoutePath.recipesPage: RecipesPage(),
      RoutePath.recipeFormPage: RecipeFormPage(),
      RoutePath.recipeDetailPage: RecipeDetailPage(),
      RoutePath.favoritePage: FavoritePage(),
      RoutePath.profilePage: ProfilePage(),
    },
    // visitor: (String path, Page<Object, dynamic> page) {
    //   if (page.isTypeof<GlobalBaseState>()) {
    //     page.connectExtraStore<GlobalState>(GlobalStore.store,
    //             (Object pagestate, GlobalState appState) {
    //           final GlobalBaseState p = pagestate as GlobalBaseState;
    //           if (p.user != appState.user) {
    //             if (pagestate is Cloneable) {
    //               final GlobalBaseState copy = (pagestate as GlobalState).clone();
    //               final GlobalBaseState newState = copy;
    //               newState.user = appState.user;
    //               return newState;
    //             }
    //           }
    //           return pagestate;
    //         });
    //   }
    // сверху новый
    // visitor: (String path, fish.Page<Object, dynamic> page) {
    //   if (page.isTypeof<GlobalBaseState>()) {
    //     page.connectExtraStore<GlobalState>(GlobalStore.store,
    //             (Object pagestate, GlobalState appState) {
    //           final GlobalBaseState p = pagestate;
    //           if (p.user != appState.user) {
    //             if (pagestate is Cloneable) {
    //               final Object copy = pagestate.clone();
    //               final GlobalBaseState newState = copy;
    //               newState.user = appState.user;
    //               return newState;
    //             }
    //           }
    //           return pagestate;
    //         });
    //   }
    //   page.enhancer.append(
    //     /// View AOP
    //     viewMiddleware: <ViewMiddleware<dynamic>>[
    //       safetyView<dynamic>(),
    //     ],
    //
    //     /// Adapter AOP
    //     adapterMiddleware: <AdapterMiddleware<dynamic>>[
    //       safetyAdapter<dynamic>()
    //     ],
    //
    //     /// Effect AOP
    //     effectMiddleware: [
    //       _pageAnalyticsMiddleware<dynamic>(),
    //     ],
    //
    //     /// Store AOP
    //     middleware: <Middleware<dynamic>>[
    //       logMiddleware<dynamic>(tag: page.runtimeType.toString()),
    //     ],
    //   );
    // },
  );
}

EffectMiddleware<T> _pageAnalyticsMiddleware<T>() {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect.call(action, ctx);
      };
    };
  };
}

class RoutePath {
  static const String homePage = 'home_page';
  static const String recipesPage = 'recipes_page';
  static const String recipeFormPage = 'recipe_form_page';
  static const String recipeDetailPage = 'recipe_detail_page';
  static const String favoritePage = 'favorite_page';
  static const String profilePage = 'profile_page';
}

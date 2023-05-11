import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meals_model.dart';

//to create a dynamic provider whose data can be altered

class FavMealNotifier extends StateNotifier<List<Meal>> {
  FavMealNotifier() : super([]);
  //both data type should match

  bool toggleMealFavStatus(Meal meal) {
    //state holds tha data in super ie list of meals
    //only assingment = will work

    final mealIsPresentInFav = state.contains(meal);
    if (mealIsPresentInFav) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favMealsProvider =
    StateNotifierProvider<FavMealNotifier, List<Meal>>((ref) {
  //initialte this class to favMealsProvider to use this value as a context
  return FavMealNotifier();
});

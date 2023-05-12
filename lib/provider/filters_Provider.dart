import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum Filter {
  //values I want to return wile Popping that sceen
  glutenFree,
  lacoseFree,
  vegeterian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lacoseFree: false,
          Filter.vegan: false,
          Filter.vegeterian: false,
        });

  void setAllFilters(Map<Filter, bool> chosenFilter) {
    state = chosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive not allowed coz weare mutating the value stored in meamory
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filteredMealsprovider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filterProvider);
  return meals.where((meal) {
    // for nesting providers use ref

    if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    } else if (activeFilter[Filter.lacoseFree]! && !meal.isLactoseFree) {
      return false;
    } else if (activeFilter[Filter.vegeterian]! && !meal.isVegetarian) {
      return false;
    } else if (activeFilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  });
});

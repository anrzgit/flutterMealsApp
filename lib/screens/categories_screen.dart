import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    // context is not available globally in stateless so you have to accept it
    //"Navigator.of(context).push" can also be used in here

    final filteredMeals = dummyMeals
        .where((element) => element.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) =>
          MealsScreen(meals: filteredMeals, title: category.title),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Your category"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16),
        itemCount: availableCategories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15),
        itemBuilder: (context, index) => CategoryGridItem(
          category: availableCategories[index],
          onSelectcategory: () =>
              _selectCategory(context, availableCategories[index]),
          //passing the function as a parameter
        ),
      ),
    );
  }
}

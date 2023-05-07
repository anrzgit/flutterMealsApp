import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectcategory});

  final Category category;
  final Function onSelectcategory; //accepting the function to change screen

  @override
  Widget build(BuildContext context) {
    //InkWell to make wiget tappable
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Theme.of(context).primaryColor,
      onTap: () =>
          onSelectcategory(), //error : SB using () actually i think () returned the value itsted of just initialising the function
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.55),
            category.color.withOpacity(0.9),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}

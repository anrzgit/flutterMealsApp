import 'package:flutter/material.dart';
import 'package:meals_app/models/meals_model.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.meals, required this.title});

  final List<Meal> meals;
  final String title;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => Text(
        meals[index].title,
      ),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            "Oh !!! ... nothing In here",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary, fontSize: 34),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "try selecting a different category",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary, fontSize: 14),
          )
        ]),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: content,
    );
  }
}

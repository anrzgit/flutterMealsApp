import 'package:flutter/material.dart';
import 'package:meals_app/models/meals_model.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(
      {super.key, required this.meal, required this.onToggleFav});

  final Meal meal;

  final Function(Meal meal) onToggleFav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () => onToggleFav(meal),
              icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue.withOpacity(0.15),
                      Colors.teal,
                    ],
                  )),
              child: Column(
                children: [
                  Text(
                    "Ingredients",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  for (final ingredient in meal.ingredients)
                    Text(
                      ingredient,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Steps",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            for (final steps in meal.steps)
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    steps,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meals_model.dart';
import 'package:meals_app/provider/favoirtes_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //in stateless "WidgetRef ref" should be added no need in stateful
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              //use .notifier to access the class in provider
              onPressed: () {
                final wasAdded = ref
                    .read(favMealsProvider.notifier)
                    .toggleMealFavStatus(meal);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(wasAdded ? 'Added to fav' : 'removed from fav'),
                  ),
                );
              },
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

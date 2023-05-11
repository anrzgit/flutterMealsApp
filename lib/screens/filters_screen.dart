import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

enum Filter {
  //values I want to return wile Popping that sceen
  glutenFree,
  lacoseFree,
  vegeterian,
  vegan,
}

var _glutenFreeFilterSet = false;
var _lactoseFreeFilterSet = false;
var _vegetarianFilterSet = false;
var _veganFilterSet = false;

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lacoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegeterian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).push(
      //           MaterialPageRoute(builder: (context) => const TabsScreen()));
      //     }
      //   },
      // ),
      //WillPopScope passes data when back button is pressed from where it was called
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lacoseFree: _lactoseFreeFilterSet,
            Filter.vegeterian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
          return false; //idk why retrn false
        },
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                "Gluten Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only  include gluten free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
              value: _glutenFreeFilterSet,
              onChanged: (bool value) {
                setState(() {
                  _glutenFreeFilterSet = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                "Lactose Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only  include lactose free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
              value: _lactoseFreeFilterSet,
              onChanged: (bool value) {
                setState(() {
                  _lactoseFreeFilterSet = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                "Vegeterian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only include Vegeterian meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
              value: _vegetarianFilterSet,
              onChanged: (bool value) {
                setState(() {
                  _vegetarianFilterSet = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only include vegan meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 22),
              value: _veganFilterSet,
              onChanged: (bool value) {
                setState(() {
                  _veganFilterSet = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

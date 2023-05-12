import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/filters_Provider.dart';
import 'package:meals_app/provider/favoirtes_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lacoseFree: false,
  Filter.vegan: false,
  Filter.vegeterian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  //replace stateful with ConsumerStatefulWidget to use provider
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
  //replace state with ConsumerState to use provider
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  void _showInfoMessege(String messege) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messege),
      ),
    );
  }

  int selectedPageIndex = 0;

  late PageController pageController;

  late String activePageTitle = "Categories";

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _selectpage(int page) {
    pageController.jumpToPage(page);
    if (page == 0) {
      setState(() {
        activePageTitle = "Categories";
      });
    }
    if (page == 1) {
      setState(() {
        activePageTitle = "Your Favoirates";
      });
    }
  }

  void onPageChanged(int page) {
    setState(() {
      selectedPageIndex = page;
    });
  }

  void _setScreen(String stringIdentifier) async {
    Navigator.of(context).pop();
    if (stringIdentifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (context) => const FilterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //To use the data
    // final meals = ref.watch(mealsProvider);
    // final activeFilter = ref.watch(filterProvider);
    final availableMeals = ref.watch(filteredMealsprovider);

    final favMealsFromProvider = ref.watch(favMealsProvider);

    return Scaffold(
      //hamberger menu it will show up in the appbar added below always
      drawer: MainDrawer(onSelectScreen: _setScreen),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Theme.of(context).canvasColor),
        title: Text(activePageTitle),
      ),
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: [
            CategoriesScreen(availableMeals: availableMeals.toList()),
            MealsScreen(
              meals: favMealsFromProvider,
            )
          ]),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: selectedPageIndex,
        backgroundColor: Theme.of(context).canvasColor,
        onTap: _selectpage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
              label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star_border_outlined,
              ),
              label: 'Favs'),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meals_model.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _faVMeals = [];

  void _showInfoMessege(String messege) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messege),
      ),
    );
  }

  void _toggleMeaLFavStatus(Meal meal) {
    final isExisting = _faVMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _faVMeals.remove(meal);
        _showInfoMessege("Removed From Fav");
      });
    } else {
      setState(() {
        _faVMeals.add(meal);
        _showInfoMessege("Added To Fav");
      });
    }
  }

  int selectedPageIndex = 0;

  late PageController pageController;

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
  }

  void onPageChanged(int page) {
    setState(() {
      selectedPageIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: [
            CategoriesScreen(onToggleFav: _toggleMeaLFavStatus),
            MealsScreen(
                meals: _faVMeals,
                title: "Favorites",
                onToggleFav: _toggleMeaLFavStatus)
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

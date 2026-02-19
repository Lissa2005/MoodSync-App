import 'package:flutter/material.dart';
import 'allergies_screen.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'recipe_detail_screen.dart';

class FoodScreen extends StatefulWidget {
  final String mood;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  
  const FoodScreen({
    super.key,
    required this.mood,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  Map<String, bool> activeAllergens = {};
  
  final List<Map<String, dynamic>> popularDishes = [
    {
      'name': 'Thai Red Curry Chicken',
      'rating': 4.5,
      'image': '🍛',
      'chef': 'Chef Thai',
      'allergens': ['Peanuts'],
      'isSaved': false,
    },
    {
      'name': 'Sushi Platter',
      'rating': 4.96,
      'image': '🍣',
      'chef': 'Chef Tanaka',
      'allergens': ['Fish', 'Shellfish'],
      'isSaved': false,
    },
    {
      'name': 'Tacos al Pastor',
      'rating': 4.8,
      'image': '🌮',
      'chef': 'Chef Maria',
      'allergens': ['Gluten'],
      'isSaved': false,
    },
  ];

  final List<Map<String, dynamic>> recommendedRecipes = [
    {
      'name': 'Grilled Salmon with Dill Sauce',
      'rating': 5.0,
      'image': '🐟',
      'chef': 'Chef Anton',
      'allergens': ['Fish'],
      'safe': true,
      'isSaved': false,
      'prepTime': '25 min',
      'difficulty': 'Medium',
    },
    {
      'name': 'Vegan Chocolate Cake',
      'rating': 4.9,
      'image': '🍰',
      'chef': 'Baker Ella',
      'allergens': [],
      'safe': true,
      'isSaved': false,
      'prepTime': '45 min',
      'difficulty': 'Easy',
    },
    {
      'name': 'Mushroom Risotto',
      'rating': 4.7,
      'image': '🍄',
      'chef': 'Chef Luigi',
      'allergens': ['Milk'],
      'safe': false,
      'isSaved': false,
      'prepTime': '35 min',
      'difficulty': 'Medium',
    },
  ];

  final List<String> categories = [
    'Breakfast',
    'Lunch', 
    'Dinner',
    'Desserts',
  ];

  void _toggleSave(int index, bool isPopular) {
    setState(() {
      if (isPopular) {
        popularDishes[index]['isSaved'] = !popularDishes[index]['isSaved'];
      } else {
        recommendedRecipes[index]['isSaved'] = !recommendedRecipes[index]['isSaved'];
      }
    });
  }

  void _onNavBarTap(int index) {
    switch (index) {
      case 0:
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      case 1:
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      case 2:
        // in food screen
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Stories screen coming soon!')),
        );
        break;
      case 4:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Activities screen coming soon!')),
        );
        break;
    }
  }

  bool isSafeForUser(Map<String, dynamic> recipe) {
    if (activeAllergens.isEmpty) return true;
    
    final recipeAllergens = recipe['allergens'] as List<String>;
    for (var allergen in recipeAllergens) {
      if (activeAllergens[allergen] == true) {
        return false;
      }
    }
    return true;
  }

  Widget _buildRatingStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    
    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber, size: 16);
        } else if (index == fullStars && hasHalfStar) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 16);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.primaryColor.withOpacity(0.1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Feed',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: widget.secondaryColor,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // allergy section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Allergies',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: widget.secondaryColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllergiesScreen(
                                    mood: widget.mood,
                                    primaryColor: widget.primaryColor,
                                    secondaryColor: widget.secondaryColor,
                                    accentColor: widget.accentColor,
                                  ),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  activeAllergens = result;
                                });
                              }
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: widget.primaryColor,
                            ),
                            child: const Text('Manage'),
                          ),
                        ],
                      ),
                      
                      if (activeAllergens.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text(
                          'Active Allergy Filters',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: activeAllergens.entries
                              .where((e) => e.value)
                              .map((e) => Chip(
                                    label: Text(e.key),
                                    backgroundColor: widget.primaryColor.withOpacity(0.1),
                                    deleteIcon: Icon(
                                      Icons.close,
                                      size: 16,
                                      color: widget.primaryColor,
                                    ),
                                    onDeleted: () {
                                      setState(() {
                                        activeAllergens[e.key] = false;
                                      });
                                    },
                                  ))
                              .toList(),
                        ),
                      ] else ...[
                        const SizedBox(height: 8),
                        Text(
                          'No active filters',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // popular dishes section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Dishes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.secondaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: widget.accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // popular dishes grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: popularDishes.length,
                  itemBuilder: (context, index) {
                    final dish = popularDishes[index];
                    final safe = isSafeForUser(dish);
                    
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(
                              recipe: dish,
                              primaryColor: widget.primaryColor,
                              secondaryColor: widget.secondaryColor,
                              accentColor: widget.accentColor,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: safe ? null : Border.all(
                            color: Colors.red.withOpacity(0.3),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: widget.primaryColor.withOpacity(0.2),
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          dish['image'],
                                          style: const TextStyle(fontSize: 30),
                                        ),
                                      ),
                                    ),
                                    
                                    //save icon
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: () => _toggleSave(index, true),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                blurRadius: 3,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            dish['isSaved'] 
                                                ? Icons.bookmark 
                                                : Icons.bookmark_border,
                                            color: dish['isSaved'] 
                                                ? widget.primaryColor 
                                                : Colors.grey,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dish['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      _buildRatingStars(dish['rating']),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (!safe)
                              const Positioned(
                                top: 4,
                                left: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    '⚠️',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            if (safe && activeAllergens.isNotEmpty)
                              const Positioned(
                                top: 4,
                                left: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    '✓ Safe',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 20),
                
                // categories section
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.secondaryColor,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: widget.accentColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: widget.accentColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: widget.secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // recommended recipes section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended Recipes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.secondaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: widget.accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // recommended recipes list
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recommendedRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recommendedRecipes[index];
                    final safe = isSafeForUser(recipe);
                    
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(
                              recipe: recipe,
                              primaryColor: widget.primaryColor,
                              secondaryColor: widget.secondaryColor,
                              accentColor: widget.accentColor,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: safe ? null : Border.all(
                            color: Colors.red.withOpacity(0.3),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: widget.primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  recipe['image'],
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          recipe['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      

                                      // save icon
                                      GestureDetector(
                                        onTap: () => _toggleSave(index, false),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          child: Icon(
                                            recipe['isSaved'] 
                                                ? Icons.bookmark 
                                                : Icons.bookmark_border,
                                            color: recipe['isSaved'] 
                                                ? widget.primaryColor 
                                                : Colors.grey,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    recipe['chef'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  _buildRatingStars(recipe['rating']),
                                  const SizedBox(height: 4),
                                  if (safe && activeAllergens.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 14,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Safe for you',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (!safe)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.warning,
                                            color: Colors.red,
                                            size: 14,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Contains allergens',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2, 
        selectedColor: widget.primaryColor,
        onTap: _onNavBarTap,
      ),
    );
  }
}
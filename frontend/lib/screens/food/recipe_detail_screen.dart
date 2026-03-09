import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and save
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        recipe['isSaved'] == true 
                            ? Icons.bookmark 
                            : Icons.bookmark_border,
                        color: recipe['isSaved'] == true 
                            ? primaryColor 
                            : Colors.grey,
                      ),
                      onPressed: () {
                       
                      },
                    ),
                  ],
                ),
              ),
              
              // Recipe image
              Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    recipe['image'] ?? '🍽️',
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Recipe details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and chef
                    Text(
                      recipe['name'] ?? 'Recipe Name',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipe['chef'] ?? 'Unknown Chef',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          recipe['rating'].toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Prep time and difficulty 
                    if (recipe['prepTime'] != null || recipe['difficulty'] != null)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (recipe['prepTime'] != null)
                              Column(
                                children: [
                                  Icon(Icons.timer, color: primaryColor),
                                  const SizedBox(height: 4),
                                  Text(
                                    recipe['prepTime'],
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  const Text(
                                    'Prep Time',
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            if (recipe['difficulty'] != null)
                              Column(
                                children: [
                                  Icon(Icons.analytics, color: primaryColor),
                                  const SizedBox(height: 4),
                                  Text(
                                    recipe['difficulty'],
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  const Text(
                                    'Difficulty',
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    
                    const SizedBox(height: 20),
                    
                    // Allergens
                    if (recipe['allergens'] != null && 
                        (recipe['allergens'] as List).isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Allergens',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: (recipe['allergens'] as List).map((allergen) {
                              return Chip(
                                label: Text(allergen),
                                backgroundColor: Colors.red.withOpacity(0.1),
                                labelStyle: const TextStyle(color: Colors.red),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    
                    const SizedBox(height: 20),
                    
                    // Placeholder for ingredients and instructions
                    Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildPlaceholderRow('• Ingredients from Kaggle dataset'),
                          _buildPlaceholderRow('• Will be loaded from backend'),
                          _buildPlaceholderRow('• Coming soon...'),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Text(
                      'Instructions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildPlaceholderRow('1. Step-by-step instructions'),
                          _buildPlaceholderRow('2. Will be loaded from Kaggle'),
                          _buildPlaceholderRow('3. When backend is integrated'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
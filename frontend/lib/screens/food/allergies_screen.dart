import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';

class AllergiesScreen extends StatefulWidget {
  final String mood;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  
  const AllergiesScreen({
    super.key,
    required this.mood,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  final Map<String, bool> selectedAllergens = {
    'Peanuts': false,
    'Milk': false,
    'Gluten': false,
    'Shellfish': false,
    'Celery': false,
    'Soy': false,
    'Eggs': false,
    'Fish': false,
    'Tree Nuts': false,
    'Sesame': false,
  };

  final Map<String, String> allergenRisk = {
    'Peanuts': 'high',
    'Milk': 'medium',
    'Gluten': 'medium',
    'Shellfish': 'high',
    'Celery': 'medium',
    'Soy': 'medium',
    'Eggs': 'medium',
    'Fish': 'high',
    'Tree Nuts': 'high',
    'Sesame': 'medium',
  };

  int get selectedCount => selectedAllergens.values.where((e) => e).length;

  void _onNavBarTap(int index) {
    switch (index) {
      case 0:
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      case 1:
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      case 2:
        Navigator.pop(context);
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

  Color _getRiskColor(String risk) {
    switch (risk) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.primaryColor.withOpacity(0.1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Allergies',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: widget.secondaryColor,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 10),
                
                Text(
                  'Manage Your Allergies',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: widget.secondaryColor.withOpacity(0.8),
                  ),
                ),
                
                const SizedBox(height: 4),
                
                Text(
                  'Select your dietary restrictions to get safe food recommendations',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Active Filters section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.accentColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: widget.accentColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Filters',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$selectedCount Selected',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      if (selectedCount > 0)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedAllergens.updateAll((key, value) => false);
                            });
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: widget.primaryColor,
                          ),
                          child: const Text('Clear All'),
                        ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                Text(
                  'Common Allergens',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.secondaryColor,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Allergens list
                ...selectedAllergens.keys.map((allergen) {
                  bool isSelected = selectedAllergens[allergen]!;
                  String risk = allergenRisk[allergen]!;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? widget.primaryColor.withOpacity(0.1) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? widget.primaryColor : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: CheckboxListTile(
                      title: Text(
                        allergen,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? widget.primaryColor : Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        risk,
                        style: TextStyle(
                          color: _getRiskColor(risk),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: isSelected,
                      activeColor: widget.primaryColor,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedAllergens[allergen] = value ?? false;
                        });
                      },
                      secondary: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getRiskColor(risk).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          risk,
                          style: TextStyle(
                            color: _getRiskColor(risk),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                
                const SizedBox(height: 20),
                
                // How it works section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: widget.secondaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'How it works',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Recipes containing your selected allergens will be marked with warnings. Safe recipes will show a green badge when you have filters active.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Apply Filters button
                Center(
                  child: ElevatedButton(
                    onPressed: selectedCount > 0 ? () {
                      Navigator.pop(context, selectedAllergens);
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Apply Filters & View Food',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2, // Food tab selected
        selectedColor: widget.primaryColor,
        onTap: _onNavBarTap,
      ),
    );
  }
}
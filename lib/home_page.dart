import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeChanged;

  const HomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> features = [
    {
      'title': 'My Profile',
      'subtitle': 'View your personal information',
      'icon': Icons.person_rounded,
      'color': Colors.blue,
    },
    {
      'title': 'My Courses',
      'subtitle': 'Explore your learning activities',
      'icon': Icons.menu_book_rounded,
      'color': Colors.green,
    },
    {
      'title': 'Assignments',
      'subtitle': 'Manage your daily tasks',
      'icon': Icons.assignment_rounded,
      'color': Colors.orange,
    },
    {
      'title': 'Notifications',
      'subtitle': 'Stay updated with announcements',
      'icon': Icons.notifications_active_rounded,
      'color': Colors.purple,
    },
  ];

  String searchText = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void showFeatureDetails(String title, String subtitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.info_outline_rounded,
          size: 40,
          color: Color(0xFF657458),
        ),
        title: Text(title),
        content: Text(
          '$subtitle\n\nThis section is ready for '
          'you to develop further.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void showSettings() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 18),
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Change the application appearance'),
                secondary: const Icon(Icons.dark_mode),
                value: widget.isDarkMode,
                onChanged: (value) {
                  Navigator.pop(context);
                  widget.onThemeChanged();
                },
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About this app'),
                subtitle: Text('Flutter Project by Jabin - 64E 185'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredFeatures = features.where((feature) {
      return feature['title'].toString().toLowerCase().contains(
        searchText.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jabin Space',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              showFeatureDetails('Notifications', 'You are all caught up!');
            },
          ),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: showSettings,
          ),
          const SizedBox(width: 6),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            // Welcome banner
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF657458), Color(0xFF344C3A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.waving_hand_rounded,
                    color: Colors.amber,
                    size: 35,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Hello, Jabin!',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Welcome to your new Flutter project. '
                    'Learn, explore, and achieve more!',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.tonal(
                    onPressed: () {
                      showFeatureDetails(
                        'Welcome',
                        'Your personalized dashboard '
                            'is ready to explore.',
                      );
                    },
                    child: const Text('Explore Now'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Section heading
            Text(
              'Explore Features',
              style: GoogleFonts.poppins(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            // Search field
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search features...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchText = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Feature cards
            if (filteredFeatures.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('No matching features found.')),
              )
            else
              ...filteredFeatures.map((feature) {
                final color = feature['color'] as Color;

                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundColor: color.withValues(alpha: 0.15),
                      child: Icon(feature['icon'] as IconData, color: color),
                    ),
                    title: Text(
                      feature['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(feature['subtitle'] as String),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                    onTap: () {
                      showFeatureDetails(
                        feature['title'] as String,
                        feature['subtitle'] as String,
                      );
                    },
                  ),
                );
              }),

            const SizedBox(height: 18),

            // Footer
            Center(
              child: Text(
                'Made with Flutter ❤️ by Jabin',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'icon_provider.dart';

final List<String> categories = [
  "Animals",
  "Beauty products",
  "Border",
  "Celebration",
  "Certification",
  "Communication",
  "Daily",
  "Direction",
  "Education",
  "Entertainment",
  "Foods and Drinks",
  "Home Appliance",
  "Human face",
  "Music",
  "Nature",
  "Rank",
  "Sports",
  "Transport",
  "Wash",
  "Weather",
  "Wedding",
];
const bool selected = false;

/*class IconScreen extends StatefulWidget {
  const IconScreen({super.key});

  @override
  State<IconScreen> createState() => _IconScreenState();
}

class _IconScreenState extends State<IconScreen> {
  @override
  void initState() {
    super.initState();
    final iconProvider = Provider.of<IconProvider>(context, listen: false);
    iconProvider.fetchIcons();
    Future.delayed(Duration.zero, () {
      iconProvider.setSelectedCategory("Animals");
    });
    iconProvider.checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icon App')),
      body: Consumer<IconProvider>(builder: (context, provider, _) {
        final icons = provider.icons;
        final selectedCategory = provider.selectedCategory;

        final filteredIcons = selectedCategory.isEmpty
            ? icons
            : icons
                .where((icon) => icon.categoryName == selectedCategory)
                .toList();

        Widget content;
        if (!provider.hasInternetConnection) {
          content = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No internet connection."),
              ElevatedButton(
                onPressed: provider.checkInternetConnection,
                child: const Text("Reload"),
              ),
            ],
          );
        } else if (provider.isLoading) {
          content = const CircularProgressIndicator();
        } else if (filteredIcons.isEmpty) {
          content = const Text("No icons available.");
        } else {
          content = SizedBox(
            height: 300,
            width: double.infinity,
            child: GridView.builder(
              itemCount: filteredIcons.length,
              itemBuilder: (context, index) {
                final iconUrl = filteredIcons[index].icon ?? '';
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Image.network(iconUrl),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
            ),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      provider.setSelectedCategory(categories[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Text(
                        categories[index],
                        style: selectedCategory == categories[index]
                            ? const TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)
                            : const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            content, // Display appropriate content
          ],
        );
      }),
    );
  }
}*/


class IconScreen extends StatefulWidget {
  const IconScreen({super.key});

  @override
  State<IconScreen> createState() => _IconScreenState();
}

class _IconScreenState extends State<IconScreen> {
  @override
  void initState() {
    super.initState();
    final iconProvider = Provider.of<IconProvider>(context, listen: false);
    iconProvider.fetchIcons();
    Future.delayed(Duration.zero, () {
      iconProvider.setSelectedCategory("Animals");
    });
    iconProvider.checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icon App')),
      body: Consumer<IconProvider>(builder: (context, provider, _) {
        final icons = provider.icons;
        final selectedCategory = provider.selectedCategory;

        final filteredIcons = selectedCategory.isEmpty
            ? icons
            : icons.where((icon) => icon.categoryName == selectedCategory).toList();

        Widget content;
        if (!provider.hasInternetConnection) {
          content = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No internet connection."),
              ElevatedButton(
                onPressed: provider.checkInternetConnection,
                child: const Text("Reload"),
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: GridView.builder(
                  itemCount: filteredIcons.length,
                  itemBuilder: (context, index) {
                    final iconUrl = filteredIcons[index].icon ?? '';
                    return Container(
                      margin: const EdgeInsets.all(10),
                      height: 100,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Image.network(iconUrl), // Change this to display the local image
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                ),
              ),
            ],
          );
        } else if (provider.isLoading) {
          content = const CircularProgressIndicator();
        } else if (provider.icons.isEmpty) {
          content = const Text("No icons available.");
        } else {
          content = SizedBox(
            height: 300,
            width: double.infinity,
            child: GridView.builder(
              itemCount: filteredIcons.length,
              itemBuilder: (context, index) {
                final iconUrl = filteredIcons[index].icon ?? '';
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Image.asset(iconUrl),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
            ),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      provider.setSelectedCategory(categories[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text(
                        categories[index],
                        style: selectedCategory == categories[index]
                            ? const TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold)
                            : const TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            content, // Display appropriate content
          ],
        );
      }
      ),
    );
  }
}
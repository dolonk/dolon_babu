import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'api_integration.dart';
import 'database_helper.dart';
import 'model_class.dart';

/*class _ShowBackgroundImageScreenState
    extends State<ShowBackgroundImageScreenState> {
  bool isLoadingImages = false;
  bool isConnected = true;
  bool isLoadingDataCheck = false;

  String? selectedBackgroundCategory;
  List<Map<String, dynamic>> fetchedImages = [];
  List<CategoryModelClass> fetchedCategories = [];
  List<dynamic> images = [];

  Future<void> loadInitialData() async {
    List<Map<String, dynamic>> localCategories =
    await BackgroundImageDatabaseHelper.retrieveCategories();

      if(localCategories.isNotEmpty){
        print('Save Categories list from local database');
        setState(() {
          selectedBackgroundCategory = localCategories[0]['name'] as String?;
          loadImages(selectedBackgroundCategory!);
        });
      } else{
        try {
          fetchedCategories = await ApiIntegration().fetchCategories();
          for (var category in fetchedCategories) {
            await BackgroundImageDatabaseHelper.insertCategory(category.allBackgroundCategories);
          }
          // First initial categories index
          if (fetchedCategories.isNotEmpty) {
            setState(() {
              selectedBackgroundCategory = fetchedCategories[3].allBackgroundCategories;
              loadImages(selectedBackgroundCategory!);
            });
          }
        } catch (e) {
          print('Error fetching categories: $e');
        }
      }

  }

  Future<void> loadImages(String categoryName) async {
    List<Map<String, dynamic>> localImages =
    await BackgroundImageDatabaseHelper.retrieveImages(categoryName);

    if (localImages.isNotEmpty) {
      setState(() {
        images = localImages.map((imgMap) {
          Uint8List imageData = imgMap['data'];
          int height = imgMap['height'];
          int width = imgMap['width'];
          print('Image Height: $height, Width: $width');
          return imageData;
        }).toList();
      });
    } else {
      try {
        fetchedImages = await ApiIntegration().fetchImages(categoryName);
        for (var image in fetchedImages) {
          Uint8List imageData =
          await ApiIntegration().downloadImageAsUint8List(image['image']);
          int height = image['height'];
          int width = image['width'];
          // Insert image data along with height and width into the local database
          await BackgroundImageDatabaseHelper.insertImage(
              categoryName, imageData, height, width);
          print('Image data for category $categoryName has been saved.');
        }
        setState(() {});
      } catch (e) {
        print('Error fetching images: $e');
      }
    }
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    } else {
      setState(() {
        isConnected = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isConnected
            ? Container(
          height: 310,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2)),
          child: isLoadingDataCheck
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [
              // Categories list
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fetchedCategories.length,
                  itemBuilder: (context, index) {
                    var categorisList = fetchedCategories[index]
                        .allBackgroundCategories;
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedBackgroundCategory =
                              categorisList;
                          isLoadingImages = true;
                        });
                        await loadImages(
                            selectedBackgroundCategory!);
                        setState(() {
                          isLoadingImages = false;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                (selectedBackgroundCategory ==
                                    categorisList)
                                    ? Colors.blue
                                    : Colors.black,
                                width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(categorisList),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Image SizeBox
              SizedBox(
                height: 250,
                width: double.infinity,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 100,
                  ),
                  itemCount: fetchedImages.length,
                  itemBuilder: (context, index) {
                    if (isLoadingImages) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                    var height = fetchedImages[index]['height'];
                    var width = fetchedImages[index]['width'];
                    var imageUrl = fetchedImages[index]['image'];
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              // Use transparent image as a placeholder
                              image: imageUrl,
                              height: 70,
                              width: double.infinity,
                              fadeInDuration: const Duration(
                                  milliseconds:
                                  300), // Fade-in duration
                            ),
                            Text('Size: $height * $width'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
            : Container(
          height: 310,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2)),
          child: isLoadingDataCheck
              ? const Center(child: CircularProgressIndicator())
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("No Internet Connection"),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoadingDataCheck = true;
                    });

                    await _checkConnectivity();

                    if (isConnected) {
                      await loadInitialData();
                    }

                    await Future.delayed(
                        const Duration(seconds: 3));

                    setState(() {
                      isLoadingDataCheck = false;
                    });
                  },
                  child: const Text("Reload"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/

class ShowBackgroundImageScreenState extends StatefulWidget {
  const ShowBackgroundImageScreenState({super.key});

  @override
  _ShowBackgroundImageScreenState createState() =>
      _ShowBackgroundImageScreenState();
}


class _ShowBackgroundImageScreenState
    extends State<ShowBackgroundImageScreenState> {
  bool isLoadingImages = false;
  bool isConnected = true;
  bool isLoadingDataCheck = false;
  String? selectedBackgroundCategory;
  List<CategoryModelClass> fetchedCategories = [];
  List<Map<String, dynamic>> fetchedImages = [];

  Future<void> loadInitialData() async {
    try {
      fetchedCategories = await ApiIntegration().fetchCategories();
      // First initial categories index
      if (fetchedCategories.isNotEmpty) {
        setState(() {
          selectedBackgroundCategory = fetchedCategories[3].allBackgroundCategories;
          loadImages(selectedBackgroundCategory!);
        });
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> loadImages(String categoryName) async {
    try {
      fetchedImages = await ApiIntegration().fetchImages(categoryName);
      setState(() {});
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    } else {
      setState(() {
        isConnected = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isConnected
            ? Container(
                height: 310,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2)),
                child: isLoadingDataCheck
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          // Categories list
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: fetchedCategories.length,
                              itemBuilder: (context, index) {
                                var categorisList = fetchedCategories[index]
                                    .allBackgroundCategories;
                                return GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      selectedBackgroundCategory =
                                          categorisList;
                                      isLoadingImages = true;
                                    });
                                    await loadImages(
                                        selectedBackgroundCategory!);
                                    setState(() {
                                      isLoadingImages = false;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                (selectedBackgroundCategory ==
                                                        categorisList)
                                                    ? Colors.blue
                                                    : Colors.black,
                                            width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(categorisList),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Image SizeBox
                          SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: GridView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 100,
                              ),
                              itemCount: fetchedImages.length,
                              itemBuilder: (context, index) {
                                if (isLoadingImages) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                var height = fetchedImages[index]['height'];
                                var width = fetchedImages[index]['width'];
                                var imageUrl = fetchedImages[index]['image'];
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          // Use transparent image as a placeholder
                                          image: imageUrl,
                                          height: 70,
                                          width: double.infinity,
                                          fadeInDuration: const Duration(
                                              milliseconds:
                                                  300), // Fade-in duration
                                        ),
                                        Text('Size: $height * $width'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              )
            : Container(
                height: 310,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2)),
                child: isLoadingDataCheck
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("No Internet Connection"),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isLoadingDataCheck = true;
                                });
                                await _checkConnectivity();
                                if (isConnected) {
                                  await loadInitialData();
                                }
                                await Future.delayed(
                                    const Duration(seconds: 3));

                                setState(() {
                                  isLoadingDataCheck = false;
                                });
                              },
                              child: const Text("Reload"),
                            ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}

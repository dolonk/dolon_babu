

import 'dart:async';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:printer_ex/created_label_widgets/variable.dart';

import 'main/created_lavel_main.dart';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
String onethree="";
String myselectwithimage="";
String mydetctor="";
String selectedIconUrl = "";
String myclickeddata='';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
List<Map<String, dynamic>> dataList = [];

class EmojiContainer extends StatefulWidget {
 Widget emojiData;
  int emojiIndex;
  EmojiContainer({super.key, required this.emojiIndex, required this.emojiData});

  @override
  EmojiContainerState createState() => EmojiContainerState();
}
final List<String> categories = [
  "Animals", "Beauty products", "Border", "Celebration", "Certification", "Communication", "Daily", "Direction", "Education", "Entertainment", "Foods and Drinks",
  "Home Appliance", "Human face",
  "Music", "Nature", "Rank", "Sports", "Transport", "Wash",
  "Weather", "Wedding", "sfasdfs", "dsafdsf", "Try", "new one icon",
  "Try for it", "Windows", "New one to try", "Mir Sult", "Rasel", "Bangladesh", "China", "Target", "try", "last one"
];
final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
List<String> emails = [];
List<String> imageUrls = [];
String selectedCategory = "Animals";


class EmojiContainerState extends State<EmojiContainer> {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  double emojiWidth = 50.0;
  // Minimum height & width for the barcode
  double minEmojiWidth = 30.0;


  Future<void> fetchEmails() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categories = jsonResponse as List<dynamic>;

      //  print('Number of emails: ${categories.length}');

        setState(() {
          // Extract email addresses and image URLs and add them to the respective lists
          emails = categories.map((category) => category['categoryName'] as String).toList();
          imageUrls = categories
              .map((category) => category['icon'] as String?)
              .where((icon) => icon != null)
              .map((icon) => 'https://grozziie.zjweiting.com:8033/tht/images/$icon')
              .toList();
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
  Timer? _timer;
  int _counter = 0;

  String documentName = "abc@gmail.com";
  String collectionName = "Detectorrr";
  @override
  void initState() {
    super.initState();
    fetchEmails();
    initializeFirebase();
  //  selectedCategory = "Animals";



    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the state variable
      setState(() {
        _counter++;
        checkDocumentExists();

      });
    });

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchEmails();
    initializeFirebase();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter++;
        checkDocumentExists();
      });
    });
  }

  bool documentExists = false;
  void checkDocumentExists() {
    firebaseFirestore
        .collection(collectionName)
        .doc(documentName)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        setState(() {
          documentExists = true;
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          // Access the individual fields from the retrieved data
          onethree = data['data'];
        });
      } else {
        setState(() {
          documentExists = false;
        });
      }
    }).catchError((error) {
      print("Error occurred while checking document: $error");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
          height: updateEmojiWidth[widget.emojiIndex],
          width: updateEmojiWidth[widget.emojiIndex],
          decoration: BoxDecoration(
            border: emojiIconBorderWidget
                ? Border.all(
                    color: selectedEmojiCodeIndex == widget.emojiIndex
                        ? Colors.blue
                        : Colors.transparent,
                    width: 2)
                : null,
          ),
          child:widget.emojiData,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onPanUpdate: (details) {
              _handleResizeGesture(details, widget.emojiIndex);
            },
            // onPanUpdate: _handleResizeGesture,
            child: Visibility(
              visible: selectedEmojiCodeIndex == widget.emojiIndex ? emojiIconBorderWidget:false,
              child: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset('assets/icons/zoom_icon.png'),
              ),
            ),
          ),
        ),
      ] ,
    );
  }

  ListView getCategories() {
    return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return ListViewItem(
                  email: categories[index],
                  selected: selectedCategory == categories[index],
                  onPressed: () {
                    setState(() {
                      selectedCategory = categories[index];
                      print(selectedCategory);
                      print("Clicked");
                    });
                  },
                );
              },
            );
  }

  // void _handleResizeGesture(DragUpdateDetails details) {
  //   setState(() {
  //     final newWidth = emojiWidth + details.delta.dx;
  //     final newHeight = emojiWidth + details.delta.dy;
  //     emojiWidth = newWidth >= minEmojiWidth ? newWidth : minEmojiWidth;
  //     emojiWidth = newHeight >= minEmojiWidth ? newHeight : minEmojiWidth;
  //   });
  // }


  void _handleResizeGesture(DragUpdateDetails details, int? emojiIndex) {
    if (selectedEmojiCodeIndex == emojiIndex) {
      setState(() {
        final newEmojiSize =
            updateEmojiWidth[selectedEmojiCodeIndex] + details.delta.dx;

        updateEmojiWidth[selectedEmojiCodeIndex] =
        newEmojiSize >= minEmojiWidth ? newEmojiSize : minEmojiWidth;
      });
    }
  }

}

class ListViewItem extends StatelessWidget {
  final String email;
  final VoidCallback? onPressed;
  final bool selected;

  ListViewItem({required this.email, this.onPressed, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Center(
          child: Text(
            email,
            style: selected? const TextStyle(fontSize: 16.0,color: Colors.blue,fontWeight: FontWeight.bold):const TextStyle(fontSize: 16.0,color: Colors.black),
          ),
        ),
      ),
    );
  }
}



class FirebaseListView extends StatefulWidget {
  final String data2;
  final List<String> emails;
  final List<String> imageUrls;

  const FirebaseListView({Key? key, required this.data2, required this.emails, required this.imageUrls})
      : super(key: key);

  @override
  FirebaseListViewState createState() => FirebaseListViewState();
}

class FirebaseListViewState extends State<FirebaseListView> {



  Timer? _timer;
  int _counter = 0;
  Future<void> fetchEmails() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categories = jsonResponse as List<dynamic>;

        //print('Number of emails: ${categories.length}');

        setState(() {
          // Extract email addresses and image URLs and add them to the respective lists
          emails = categories.map((category) => category['categoryName'] as String).toList();
          imageUrls = categories
              .map((category) => category['icon'] as String?)
              .where((icon) => icon != null)
              .map((icon) => 'https://grozziie.zjweiting.com:8033/tht/images/$icon')
              .toList();
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
  Future<void> addData(String dataaddtobe) async{
    try{
      FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
      firebaseFirestore.collection(mydetctor)
          .add({
        "data": ""+dataaddtobe
      });

    }catch(e)
    {
      print("Error : "+e.toString());
    }
  }
  String mydetctor="";
  Future<bool> checkDocumentExists(String email) async {
    final collectionRef = FirebaseFirestore.instance.collection(mydetctor);
    final querySnapshot = await collectionRef.where('data', isEqualTo: email).get();

    return querySnapshot.size > 0;
  }
  final dbHelper = DatabaseHelper();
  bool _nameExists = false; // State variable to store the result of the check

  Future<void> checkNameExistence(String tablename,String name) async {
    bool exists = await dbHelper.isNameExists(tablename,name);
    setState(() {
      _nameExists = exists;
    });
  }
  List<String> namesList = [];
 // List<String> names = [];
  void fetchAndPrintNames(String databasename) async {
    selectedCategoryImageUrls = await dbHelper.getNames(databasename);


   // print("AAAA$databasename");
   // print(selectedCategoryImageUrls);
  }

  @override
  void initState() {
    super.initState();


    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the state variable
      setState(() {
        _counter++;
        fetchEmails();
        initializeFirebase();

      //print(_counter.toString());
        //

        mydetctor=widget.data2.toString();
        if(mydetctor=="Beauty products")
          {
            mydetctor = "Beauty";
            fetchAndPrintNames(mydetctor);
          }
        else if(mydetctor =="Foods and Drinks")
          {
            mydetctor = "Foods";
            fetchAndPrintNames(mydetctor);
          }
        else if(mydetctor =="Home Appliance")
        {
          mydetctor = "Home";
          fetchAndPrintNames(mydetctor);
        }
        //1
        else if(mydetctor =="Human face")
        {
          mydetctor = "Human";
          fetchAndPrintNames(mydetctor);
        }
        //2
        else if(mydetctor =="new one icon")
        {
          mydetctor = "new";
          fetchAndPrintNames(mydetctor);
        }
        //3
        else if(mydetctor =="Try for it")
        {
          mydetctor = "Try";
          fetchAndPrintNames(mydetctor);
        }
        //4
        else if(mydetctor =="New one to try")
        {
          mydetctor = "New";
          fetchAndPrintNames(mydetctor);
        }
        //5
        else if(mydetctor =="Mir Sult")
        {
          mydetctor = "Mir";
          fetchAndPrintNames(mydetctor);
        }
        //6
        else if(mydetctor =="last one")
        {
          mydetctor = "last";
          fetchAndPrintNames(mydetctor);
        }
        else
          {
            mydetctor=widget.data2.toString();
            fetchAndPrintNames(mydetctor);
          }
        widget.data2;
       // fetchData(mydetctor);
        //  print("gettt");

        //print(widget.data2);
      });
    });

  }
  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer?.cancel();
    super.dispose();
  }
  Future<void> fetchData(String colletiondata) async {
    List<Map<String, dynamic>> data = await getFirestoreData(colletiondata);
    setState(() {
      dataList = data;
    });
  }
  Future<String> downloadAndSaveImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = imageUrl
          .split('/')
          .last;
      final filePath = '${appDir.path}/$fileName';

      final File imageFile = File(filePath);
      await imageFile.writeAsBytes(response.bodyBytes);

      return filePath;
    } else {
      throw Exception('Failed to download image');
    }
  }
  Future<List<Map<String, dynamic>>> getFirestoreData(String mycollection) async {
    List<Map<String, dynamic>> dataList = [];

    try {
      QuerySnapshot snapshot = await _firestore.collection(mycollection).get();

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }
    //print(dataList);

    return dataList;
  }
  List<String> selectedCategoryEmails = [];
  List<String> selectedCategoryImageUrls = [];
  @override
  Widget build(BuildContext context) {
    // Fetch emojis that match the selected category


    for (int i = 0; i < widget.emails.length; i++) {
      if (widget.emails[i] == widget.data2) {
       // print(""+widget.emails[i]);
        bool isDataFound = false;

        String link =  widget.imageUrls[i];

        checkDocumentExists(link).then((value) {
          isDataFound = value;
          if (isDataFound) {
            //print('Document with email "ariful@gmail.com" exists.');

          } else {
           // print('Document with email "ariful@gmail.com" does not exist.');
            addData(link);
            checkvalue(mydetctor,link);
            // dbHelper.insertName(dataget);
            //print("Data Added");
            // elementsMatchingCondition.add(element);
          }
        }).catchError((error) {
          print('An error occurred: $error');
        });
       /*
        checkNameExistence(mydetctor,link);
        if(_nameExists)
        {
          print("Get");
        }
        else
        {
          print("Not");
          String tableName = ''+mydetctor; // Use a meaningful name here
          dbHelper.insertName(tableName, ''+link);
        }
        */

        //selectedCategoryEmails.add(widget.emails[i]);
       // selectedCategoryImageUrls.add(widget.imageUrls[i]);
      }
    }

    return Container(
      height: 200,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: selectedCategoryImageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          String email = selectedCategoryImageUrls[index];
          String imageUrl = selectedCategoryImageUrls[index];
          return GestureDetector(
            onTap: () async{
              setState(() async{
                selectedIconUrl = imageUrl;
                print('Selected Icon URL: $selectedIconUrl');
                myui = 5;
                await DatabaseHelper__UUID222.instance.insertData("010181060331", ""+selectedIconUrl);
                print("Call");
                getDataImage=selectedIconUrl;
                 print("Call"+getDataImage);
                //addData1(selectedIconUrl);

              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.file(
                File(selectedCategoryImageUrls[index]),
              ),
            ),
          );
        },
      ),
    );
  }
  void checkvalue(String tablename1, String dataname1)  async{
    final imageUrl = ''+dataname1;  // Your image URL
    String tableName = ''+tablename1;
    final imagePath =  await downloadAndSaveImage(imageUrl);
    dbHelper.insertName(mydetctor, ''+imagePath.toString());
  //  print("ioo");
    //print(""+widget.data2);


    await checkNameExistence(tablename1,imagePath);
    if(_nameExists)
    {
      //print("Get");
    }
    else
    {
    //  print("Not");
      String tableName = ''+widget.data2; // Use a meaningful name here



     // print(imagePath.toString());
    }



  }
}

class ListItem{
  late final String title ;
  late final String link ;

  ListItem(this.title,this.link);


}
class ListProvider  extends ChangeNotifier{
  List<ListItem> _items = [];
  List<ListItem> get item => _items;
  void addItem(ListItem item){}

}
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  Database? _db;

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'emojidatabase.db'); // Updated database name
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {},
    );
  }

  Future<void> createNameTable(String tableName) async {
    final db = await database;
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $tableName(name TEXT PRIMARY KEY)',
    );
  }

  Future<void> insertName(String tableName, String name) async {
    await createNameTable(tableName);

    final db = await database;
    await db.insert(
      tableName,
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getNames(String tableName) async {
    await createNameTable(tableName);

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return maps[i]['name'];
    });
  }

  Future<bool> isNameExists(String tableName, String name) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'name = ?',
      whereArgs: [name],
    );
    return maps.isNotEmpty;
  }
}
//emoji database


class DatabaseHelper__UUID222 {
  static final DatabaseHelper__UUID222 instance = DatabaseHelper__UUID222._();
  static Database? _database;

  DatabaseHelper__UUID222._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'Current_Select.db'); // Updated database name
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE UUID_TABLE (
            id TEXT PRIMARY KEY,
            name TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertData(String uuid, String name) async {
    final db = await database;
    await db.insert(
      'UUID_TABLE',
      {'id': uuid, 'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Added" + name);
  }

  Future<List<UUID_Model_22>> getAllData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("UUID_TABLE");
    return List.generate(maps.length, (i) {
      return UUID_Model_22.fromMap(maps[i]);
    });
  }

  Future<Map<String, dynamic>?> getData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('UUID_TABLE');
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
}
//emoji
class UUID_Model_22 {

  final String id;
  final String name;

  UUID_Model_22({
    required this.id,
    required this.name,
  });


  factory UUID_Model_22.fromMap(Map<String, dynamic> map) {
    return UUID_Model_22(
        id: map['id'],

        name: map['name']

    );
  }

  @override
  String toString() {

    return 'UUID_Model_22 {id: $id, name:'
        ' $name}';
  }

}
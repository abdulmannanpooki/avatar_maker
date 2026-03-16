import "dart:math";

import "package:flutter/material.dart";
import "package:avatar_maker/avatar_maker.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avatar Maker Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Avatar Maker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AvatarMakerController _avatarMakerController =
      NonPersistentAvatarMakerController(customizedPropertyCategories: [
    // Only show HairStyle, SkinColor, and HairColor
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.Accessory, toDisplay: false),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.Background, toDisplay: false),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.EyebrowType, toDisplay: false),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.EyeType, toDisplay: false),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.FacialHairColor, toDisplay: false),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.FacialHairType, toDisplay: false),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.HairColor, toDisplay: true),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.HairStyle, toDisplay: true),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.MouthType, toDisplay: false),
    CustomizedPropertyCategory(id: PropertyCategoryIds.Nose, toDisplay: false),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.OutfitColor, toDisplay: false),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.OutfitType, toDisplay: false),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.SkinColor, toDisplay: true),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Use your Avatar Maker anywhere\nwith the below widget",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          AvatarMakerAvatar(
            backgroundColor: Colors.grey[200],
            radius: 100,
            controller: _avatarMakerController,
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "and create your own page to customize them using our widgets",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Spacer(flex: 2),
              Expanded(
                flex: 3,
                child: Container(
                  height: 35,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text("Customize"),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPage(
                                  controller: _avatarMakerController,
                                ))),
                  ),
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

class NewPage extends StatefulWidget {
  final AvatarMakerController controller;

  const NewPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  double _userLevel = 0;

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: AvatarMakerAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[200],
                  controller: widget.controller,
                ),
              ),
              // Level Slider
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "User Level: ${_userLevel.toInt()}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Reach Level 5 to unlock Glasses!"),
                    Slider(
                      value: _userLevel,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      label: _userLevel.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _userLevel = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: min(600, _width * 0.85),
                child: Row(
                  children: [
                    Text(
                      "Customize:",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Spacer(),
                    AvatarMakerSaveWidget(controller: widget.controller),
                    AvatarMakerRandomWidget(controller: widget.controller),
                    AvatarMakerResetWidget(controller: widget.controller),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: AvatarMakerCustomizer(
                  scaffoldWidth: min(600, _width * 0.85),
                  autosave: false,
                  controller: widget.controller,
                  theme: AvatarMakerThemeData(
                      secondaryBgColor: const Color.fromARGB(218, 238, 57, 57),
                      selectedIconColor: const Color.fromARGB(255, 54, 244, 82),
                      boxDecoration: BoxDecoration(boxShadow: [BoxShadow()])),
                  isItemLocked: (category, item) {
                    // Example Logic: Lock "Glasses" if level < 5
                    // Note: In a real app, you'd check item IDs more robustly
                    if (category == PropertyCategoryIds.Accessory &&
                        item.contains("Glasses")) {
                      return _userLevel < 5;
                    }
                    return false;
                  },
                  lockWidget: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  onTapLockedItem: (category, item) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Item Locked"),
                        content: Text(
                            "You need to reach Level 5 to unlock this item!"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Simulate unlocking or buying
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Unlock logic goes here...")),
                              );
                            },
                            child: Text("Unlock Now (50 Gold)"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<ItemModel> items = List.generate(5, (index) => ItemModel("Item ${index + 1}", false));

  int selectedItemCount = 0;

  void toggleItemSelection(int index) {
    setState(() {
      items[index].isSelected = !items[index].isSelected;
      if (items[index].isSelected) {
        selectedItemCount++;
      } else {
        selectedItemCount--;
      }
    });
  }

  void showSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selected Items'),
          content: Text('Number of selected items: $selectedItemCount'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection Screen'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            tileColor: items[index].isSelected ? Colors.blue : null,
            onTap: () {
              toggleItemSelection(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSelectionDialog();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class ItemModel {
  String name;
  bool isSelected;

  ItemModel(this.name, this.isSelected);
}

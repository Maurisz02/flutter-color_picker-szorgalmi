import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.purple,
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Picker'),
      ),
      body: HomePageItem(),
    );
  }
}

class HomePageItem extends StatefulWidget {
  @override
  State<HomePageItem> createState() => HomePageItemState();
}

class HomePageItemState extends State<HomePageItem> {
  Color pickerColor = Colors.black;
  Color currentColor = Colors.black;
  String rgbText = "";
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: _size.height * 0.04),
            alignment: Alignment.center,
            child: const Text(
              'Üdvözöllek a Color Pickerben!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: _size.width * 0.6,
            height: _size.height * 0.06,
            margin: EdgeInsets.only(
              top: _size.height * 0.2,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                elevation: MaterialStateProperty.all<double>(10),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Válassz színt!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Megvan!'),
                        onPressed: () {
                          setState(() {
                            currentColor = pickerColor;
                            rgbText =
                                "(${pickerColor.red}, ${pickerColor.green}, ${pickerColor.blue})";
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                "Válassz színt!",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: _size.height * 0.08),
          Container(
            height: _size.height * 0.2,
            width: _size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: currentColor,
            ),
          ),
          SizedBox(height: _size.height * 0.04),
          Container(
            alignment: Alignment.center,
            child: Text("Az rgb szín kódja: " + rgbText),
          ),
        ],
      ),
    );
  }
}

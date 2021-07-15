import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodfacts/services/foodish_provider.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  final ValueChanged<int> callback;

  HeaderWidget(this.callback);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> foodCategories =
        Provider.of<FoodishProvider>(context, listen: false).getCategories();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SafeArea(
        child: Column(
          children: [
            Image.asset(
              "assets/foodfactslogo.png",
              width: 170,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    foodCategories.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  selectedButtonIndex == index
                                      ? Colors.white.withOpacity(0.8)
                                      : Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            onPressed: () {
                              widget.callback(index);
                              setState(() {
                                selectedButtonIndex = index;
                              });
                            },
                            child: Text(
                              foodCategories[index],
                            ),
                          ),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key, required this.sizes});

  final List<int> sizes;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedidx = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: widget.sizes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          int size = widget.sizes[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedidx = index;
              });
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, right: 12, bottom: 13, left: 4),
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      selectedidx == index ? Color(0xFF3F51F3) : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '$size',
                  style: TextStyle(
                    color: selectedidx == index ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

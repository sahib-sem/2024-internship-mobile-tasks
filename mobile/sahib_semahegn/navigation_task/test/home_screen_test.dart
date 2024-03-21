
import 'package:ecommerce_ui_task/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

group('home page tests', () { 

  testWidgets('home page displays profile and message for the user', (tester) async {

    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    final helloMessage = find.text('Hello, Sahib');

    expect(helloMessage, findsOneWidget);
    

  });

  testWidgets('profile pic is displayed', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.byType(ClipRRect), findsOneWidget);


  });
});
  

  
  }


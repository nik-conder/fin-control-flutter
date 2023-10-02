import 'package:fin_control/presentation/bloc/home_bloc.dart';
import 'package:fin_control/presentation/ui/home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHomeBloc<HomeEvent, HomeState> extends HomeBloc {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    await tester.pumpWidget(const HomePage());

    // Create the Finders.
    final titleFinder =
        find.byIcon(Icons.dark_mode_outlined).evaluate().single.widget;

    expect(titleFinder, findsOneWidget);
  });
}

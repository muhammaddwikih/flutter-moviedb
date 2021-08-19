import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/services/movie_service.dart';
import 'package:moviedb/movie/movie_screen.dart';
import 'package:moviedb/movie/widgets/detail/detail_movies_view_model.dart';
import 'package:moviedb/movie/widgets/popular/popular_movies.dart';
import 'package:moviedb/movie/widgets/popular/popular_movies_view_model.dart';
import 'package:moviedb/movie/widgets/summary/summary_detail.dart';

import '../mock/mock_data.dart';


class MockPopularViewModel extends Mock implements DetailMoviesViewModel {}
class MockHomeService extends Mock implements MovieService {}

void main() {
  final mockHomeService = MockHomeService();
  when(mockHomeService.getDetailMovie(436969)).thenAnswer((realInvocation) =>
      Future.delayed(
          Duration(milliseconds: 100), () => Future.value(dummyList)));

  final mockPopularMoviesViewModelProvider = MockPopularViewModel();
  when(mockPopularMoviesViewModelProvider.getMovieById(436969)).thenReturn(null);

  //used for some test
  Widget createAppWithCenteredButton(Widget child) {
    return MaterialApp(
      home: Material(
        child: Center(
          child: ElevatedButton(
            onPressed: null,
            child: child,
          ),
        ),
      ),
    );
  }

  testWidgets('Popular Screen test', (WidgetTester tester) async {
    final screen = SummaryDetail();

    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(overrides: [
      detailMoviesViewModelProvider.overrideWithValue(mockPopularMoviesViewModelProvider)
    ], child: MaterialApp(home: screen)));

    //test home render correctly
    await tester.pumpAndSettle();
    expect(find.byWidget(screen), findsOneWidget);

  });

  // testWidgets('Home Screen test with data', (WidgetTester tester) async {
  //   final screen = HomeScreen();
  //
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(ProviderScope(overrides: [
  //     homeViewModelProvider.overrideWithProvider(
  //         StateNotifierProvider((ref) => HomeViewModel(mockHomeService)))
  //   ], child: MaterialApp(home: screen)));
  //
  //   //test home render correctly
  //   await tester.pumpAndSettle(Duration(milliseconds: 200));
  //   expect(find.byKey(TODO_LIST), findsOneWidget);
  // });
  //
  // testWidgets('Add Item Dialog Test', (WidgetTester tester) async {
  //   final widget = AddItem();
  //
  //   await tester.pumpWidget(ProviderScope(overrides: [
  //     homeViewModelProvider.overrideWithValue(mockHomeViewModelProvider)
  //   ], child: createAppWithCenteredButton(const Text('Go'))));
  //   final BuildContext context = tester.element(find.text('Go'));
  //
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return widget;
  //       });
  //
  //   await tester.pumpAndSettle();
  //   expect(find.byType(AlertDialog), findsOneWidget);
  //
  //   await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
  //   await tester.pumpAndSettle();
  //   expect(find.byType(AlertDialog), findsNothing);
  // });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/services/movie_service.dart';
import 'package:moviedb/movie/movie_screen.dart';
import 'package:moviedb/movie/widgets/detail/detail_movies_view_model.dart';
import 'package:moviedb/movie/widgets/popular/popular_movies.dart';
import 'package:moviedb/movie/widgets/popular/popular_movies_view_model.dart';
import 'package:moviedb/movie/widgets/summary/summary_detail.dart';
import 'package:moviedb/movie/widgets/upcoming/upcoming_movies.dart';
import 'package:moviedb/movie/widgets/upcoming/upcoming_movies_view_model.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../mock/mock_data.dart';
import 'home_screen_test.mocks.dart';

// class MockPopularMoviesViewModel extends Mock
//     implements PopularMoviesViewModel {}
//
// class MockUpcomingMoviesViewModel extends Mock
//     implements UpcomingMoviesViewModel {}
//
// class MockHomeService extends Mock implements MovieService {}

@GenerateMocks([UpcomingMoviesViewModel, PopularMoviesViewModel, MovieService])
void main() {
  final mockHomeService = MockMovieService();
  when(mockHomeService.getUpcoming(1, 5)).thenAnswer((realInvocation) async =>
      Future.delayed(
          Duration(milliseconds: 3000), () => Future.value(dummyUpcomingList)));

  when(mockHomeService.getPopularMovie(1)).thenAnswer((realInvocation) async =>
      Future.delayed(
          Duration(milliseconds: 3000), () => Future.value(dummyUpcomingList)));


  final mockPopularMoviesViewModel = MockPopularMoviesViewModel();
  final mockUpcomingMoviesViewModel = MockUpcomingMoviesViewModel();
  when(mockPopularMoviesViewModel.loadData())
      .thenAnswer((realInvocation) => null);
  when(mockUpcomingMoviesViewModel.loadData())
      .thenAnswer((realInvocation) => null);

  testWidgets('Movie: Popular screen widget', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      final screen = PopularMovies();
      // Build our app and trigger a frame.
      await tester.pumpWidget(ProviderScope(
          overrides: [
            popularMoviesViewModelProvider.overrideWithProvider(
                StateNotifierProvider(
                    (ref) => PopularMoviesViewModel(mockHomeService)))
          ],
          child: MaterialApp(
              home: Scaffold(
                body: SingleChildScrollView(
                  child: screen,
                ),
              ))));

      //test home render correctly
      await tester.pumpAndSettle(Duration(milliseconds: 3000));
      expect(find.byWidget(screen), findsOneWidget);
    });
  });

  testWidgets('Movie: Upcoming screen widget', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      final screen = UpcomingMovies();
      // Build our app and trigger a frame.
      await tester.pumpWidget(ProviderScope(
          overrides: [
            upcomingMoviesViewModelProvider.overrideWithProvider(
                StateNotifierProvider(
                        (ref) => UpcomingMoviesViewModel(mockHomeService)))
          ],
          child: MaterialApp(
              home: SingleChildScrollView(
                child: screen,
              ))));

      //test home render correctly
      await tester.pumpAndSettle(Duration(milliseconds: 3000));
      expect(find.byWidget(screen), findsOneWidget);
    });
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

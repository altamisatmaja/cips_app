part of '../bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenDataLoaded(selectedIndex: 0)) {
    on<SetHomeScreenState>((event, emit) {
      final currentState = state;
      if (currentState is HomeScreenDataLoaded) {
        emit(event.state ??
            HomeScreenDataLoaded(selectedIndex: currentState.selectedIndex));
      } else {
        emit(event.state ?? HomeScreenDataLoaded(selectedIndex: 0));
      }
    });

    on<SetHomeScreenSelectedIndex>((event, emit) {
      emit(HomeScreenDataLoaded(selectedIndex: event.index));
    });
  }
}

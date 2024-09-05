part of '../bloc.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenDataLoaded extends HomeScreenState {
  HomeScreenDataLoaded({required this.selectedIndex});

  final int selectedIndex;
}

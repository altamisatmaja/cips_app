part of '../bloc.dart';

@immutable
abstract class HomeScreenEvent {}

class SetHomeScreenState extends HomeScreenEvent {
  SetHomeScreenState([this.state]);

  final HomeScreenState? state;
}

class SetHomeScreenSelectedIndex extends HomeScreenEvent {
  SetHomeScreenSelectedIndex({required this.index});

  final int index;
}

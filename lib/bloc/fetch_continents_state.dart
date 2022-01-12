part of 'fetch_continents_cubit.dart';

@immutable
abstract class FetchContinentsState {}

class FetchContinentsInitial extends FetchContinentsState {}

class FetchContinentsLoading extends FetchContinentsState {}

class FetchContinentsLoaded extends FetchContinentsState {
  final List<String> continents;
  final List<String> codes;
  FetchContinentsLoaded({required this.continents, required this.codes});
  @override
  String toString() =>
      'FetchContinentsLoaded { continents: $continents, codes: $codes }';
}

class FetchContinentsError extends FetchContinentsState {
  final String message;
  FetchContinentsError({required this.message});
  @override
  String toString() => 'FetchContinentsError { message: $message }';
}

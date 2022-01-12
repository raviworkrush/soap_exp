import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soapexp/data/services/api_service.dart';
part 'fetch_continents_state.dart';

class FetchContinentsCubit extends Cubit<FetchContinentsState> {
  FetchContinentsCubit() : super(FetchContinentsInitial());

  void fetchContinents() async {
    emit(FetchContinentsLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      Map<String, dynamic> _apiResponse =
          await APIService.listOfContinentsByName();
      if (_apiResponse['code'] == 200) {
        emit(FetchContinentsLoaded(
            continents: _apiResponse['names'] ?? [],
            codes: _apiResponse['codes'] ?? []));
      } else {
        emit(FetchContinentsError(
            message: _apiResponse['message'] ?? 'Something went wrong'));
      }
    } catch (e) {
      emit(FetchContinentsError(message: e.toString()));
    }
  }
}

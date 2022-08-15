import 'package:ex6/repository/search_repo.dart';
import 'package:ex6/screen/home_screen/search_cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRequest) : super(const SearchInitial());
  final SearchRequest searchRequest;

  fetchSearchMulti(String query) async {
    if (query.isNotEmpty){
      searchRequest.fetchSearchMulti(query).then((listSearch) {
        emit(SearchLoaded(listSearch));
        if(listSearch.isEmpty){
          emit(SearchError('Không tìm thấy'));
        }
      });
    } else {
      emit(SearchError('Chưa nhập thông tin cần tìm!'));
      await Future.delayed(const Duration(seconds: 2));
      emit(const SearchInitial());
    }
  }

}
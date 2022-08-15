
import 'package:ex6/model/search/multi_search.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState{
  final List<SearchResult> listSearch;
  SearchLoaded(this.listSearch);
}

class SearchError extends SearchState {
  final String alert;
  SearchError(this.alert);
}

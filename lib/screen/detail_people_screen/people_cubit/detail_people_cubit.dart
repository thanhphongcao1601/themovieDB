import 'package:ex6/repository/people_repo.dart';
import 'package:ex6/screen/detail_people_screen/people_cubit/detail_people_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPeopleCubit extends Cubit<DetailPeopleState> {
  DetailPeopleCubit(this.peopleRequest) : super(const DetailPeopleInitial());
  final PeopleRequest peopleRequest;

  init(int id) {
    emit(const DetailPeopleLoading());

    peopleRequest.fetchPeopleDetail(id).then((people) {
      emit(DetailPeopleLoaded(people));
    });

    peopleRequest.fetchPeopleCombineCredit(id).then((listKnowFor) {
      emit(CreditPeopleLoaded(listKnowFor));
    });
  }
}
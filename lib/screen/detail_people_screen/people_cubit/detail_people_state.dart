import 'package:ex6/model/people/people_combine_credit.dart';
import 'package:ex6/model/people/people_detail.dart';

abstract class DetailPeopleState {
  const DetailPeopleState();
}

class DetailPeopleInitial extends DetailPeopleState {
  const DetailPeopleInitial();
}

class DetailPeopleLoading extends DetailPeopleState {
  const DetailPeopleLoading();
}

class DetailPeopleLoaded extends DetailPeopleState {
  final PeopleDetail peopleDetail;
  DetailPeopleLoaded(this.peopleDetail);
}

class DetailPeopleCreditLoading extends DetailPeopleState {
  const DetailPeopleCreditLoading();
}

class CreditPeopleLoaded extends DetailPeopleState {
  final PeopleCombineCredit knowFor;
  CreditPeopleLoaded(this.knowFor);
}

class DetailPeopleError extends DetailPeopleState {
  const DetailPeopleError();
}

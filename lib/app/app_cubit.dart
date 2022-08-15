import 'package:ex6/api/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit {
  AppCubit(this.apiClient) : super(0);
  final APIClient apiClient;
}

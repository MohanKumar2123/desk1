import'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:desk1/bloc/user_list_state.dart';
import 'user_model.dart';
import './bloc.dart';
import 'package:http/http.dart'as https;


class UserListBloc extends Bloc<LoginEvent, LoginState>{

  @override
  LoginState get initialState => IntialState();
  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event
      ) async*{
    if(event is ShowList) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var response = await https.get(
          Uri.parse("https://reqres.in/api/users?page=2"),
        );
        final responseData = json.decode(response.body);
         final newList = responseData['data'];
        List<UserModel> dataList = [];
        for (var c in newList) {
          dataList.add(UserModel.fromJson(c));
        }
        yield OnSuccess(userListData: dataList);

      }
      else{
        yield OnFailure(errorMessage:"Please conect your network connection ");
      }
    }
  }
}

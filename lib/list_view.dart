import 'package:desk1/bloc/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_list_bloc.dart';
import 'bloc/user_list_event.dart';
import 'bloc/user_list_state.dart';

class ShowUserList extends StatefulWidget {
  @override
  _ShowUserListState createState() => _ShowUserListState();
}

class _ShowUserListState extends State<ShowUserList> {
  UserListBloc listBloc;

  @override
  void dispose() {
    listBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    listBloc = UserListBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: BlocProvider<UserListBloc>(
        create: (_) => listBloc,
        child:
            BlocConsumer<UserListBloc, LoginState>(builder: (context, state) {
          if (state is OnSuccess) {
            return ListView.builder(
              itemCount:
                  state.userListData == null ? 0 : state.userListData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(state.userListData[index].firstName +
                              " " +
                              state.userListData[index].lastName),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('User ID : ' +
                                    state.userListData[index].id.toString()),
                                Text('User Mail Id : ' +
                                    state.userListData[index].email),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Okay'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              color: Colors.grey[300],
                              blurRadius: 10)
                        ]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width / 5),
                          height: (MediaQuery.of(context).size.height) * 0.18,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(state
                                      .userListData[index].avatar
                                      .toString()),
                                  fit: BoxFit.cover)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Name : " +
                                state.userListData[index].firstName +
                                " " +
                                state.userListData[index].lastName),
                            Text("Email : " + state.userListData[index].email),
                            Text("User ID : " +
                                state.userListData[index].id.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is OnFailure) {
            return Center(
                child: Text(
              state.errorMessage,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ));
          } else {
            listBloc.add(ShowList());
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }, listener: (context, loginState) {
          if (loginState is OnFailure) {
            print("Failure");
          }
        }),
      ),
    );
  }

  void showUserDetailsDialog(UserModel userListData) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.only(top: 200, bottom: 300, left: 50, right: 50),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Card(
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        new Text(
                          'Email :',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        new Text(userListData.email ?? ''),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        new Text(
                          'First Name :',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        new Text(userListData.firstName ?? ''),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        new Text(
                          'Last Name :',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        new Text(userListData.lastName ?? ''),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        new Text(
                          'Id :',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        new Text(userListData.id.toString() ?? ''),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

import 'package:api_app/cubits/user_data_cubit.dart';
import 'package:api_app/pages/enter_page.dart';
import 'package:api_app/utils/user_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();

  @override
  void initState() {
    UserUtils()
        .getUser()
        .then((value) => context.read<UserDataCubit>().onLoad(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            if (state is UserData) {
              userNameController.text = (state as UserData).user.userName;
              emailController.text = (state as UserData).user.email;
            }
            return Form(
                child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: TextFormField(
                    controller: userNameController,
                    decoration: new InputDecoration(
                        hintText: "Логин", border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: TextFormField(
                    controller: emailController,
                    decoration: new InputDecoration(
                        hintText: "Почта", border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: TextFormField(
                    controller: oldPasswordController,
                    decoration: new InputDecoration(
                        hintText: "Старый пароль",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: TextFormField(
                    controller: newPasswordController,
                    decoration: new InputDecoration(
                        hintText: "Новый пароль", border: OutlineInputBorder()),
                  ),
                ),
              ],
            ));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  String userName = userNameController.text;
                  String email = emailController.text;
                  String oldPassword = oldPasswordController.text;
                  String newPassword = newPasswordController.text;

                  UserUtils()
                      .updateProfile(userName, email, oldPassword, newPassword)
                      .then((success) {
                    if (!success) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                        "Логин уже занят или неправильный старый пароль",
                        textAlign: TextAlign.justify,
                      )));
                    } else {
                      UserUtils().getUser().then((value) =>
                          context.read<UserDataCubit>().onLoad(value));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                        "Изменения сохранены",
                        textAlign: TextAlign.justify,
                      )));
                    }
                  });
                },
                child: Text("Сохранить")),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EnterPage()));
              },
              child: Text("Выход"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            )
          ],
        )
      ],
    ));
  }
}

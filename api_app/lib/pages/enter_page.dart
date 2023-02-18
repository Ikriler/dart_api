import 'package:api_app/pages/main_page.dart';
import 'package:api_app/utils/api_utils.dart';
import 'package:flutter/material.dart';

class EnterPage extends StatelessWidget {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    userNameController.text = "userVirtual";
    passwordController.text = "test";
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: userNameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      String userName = userNameController.text;
                      String password = passwordController.text;
                      ApiUtils.S!.login(userName, password).then((success) {
                        if (!success) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            "Неправильный логин или пароль",
                            textAlign: TextAlign.justify,
                          )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()));
                        }
                      });
                    },
                    child: const Text("Войти")),
              ],
            ),
          )
        ],
      ),
    );
  }
}

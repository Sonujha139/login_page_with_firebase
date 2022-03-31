import 'package:flutter/material.dart';

class SButton extends StatelessWidget {
  String? title;
  bool? isLoginButton;
  VoidCallback? onPress;
  bool? isLoading;
  SButton({Key? key, this.title, this.isLoginButton = false,this.isLoading=false, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: isLoginButton == false ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isLoginButton == false ? Colors.black : Colors.black)),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading!? false:true,
              child: Center(
                  child: Text(
                title ?? "button",
                style: TextStyle(
                    color: isLoginButton == false ? Colors.black : Colors.white,
                    fontSize: 16),
              )),
            ),
            Visibility(
              visible: isLoading!,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

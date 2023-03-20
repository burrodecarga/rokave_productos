import 'package:flutter/material.dart';


class AuthBackground extends StatelessWidget {

  final Widget child;

  const AuthBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        _PurpleBox(),
        _HeaderIcon(),
        child, //this.child
      ]),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50),
        child: const Icon(Icons.person_pin, color: Colors.white, size: 100),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecotarionCustom(),
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(children: [
        Positioned(top: -20, left: 30, child: _Bubble()),
        Positioned(top: 190, left: 180, child: _Bubble()),
        Positioned(top:50, left: 270, child: _Bubble()),
        Positioned(top: 130, left: 60, child: _Bubble()),
        Positioned(top: 220, left: -10, child: _Bubble()),
        Positioned(top:75, left: -30, child: _Bubble()),
      ]),
    );
  }

  BoxDecoration BoxDecotarionCustom() => const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178, 1)
        ]),
      );
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.19),
        ));
  }
}

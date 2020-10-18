import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      child: const Center(
        child:   SpinKitHourGlass(color: Colors.blue,duration: Duration(seconds: 4),),
        ),
      );
  }
}

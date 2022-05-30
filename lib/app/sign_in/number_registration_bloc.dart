import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muraita_apps/services/auth.dart';

class NumberRegistrationBloc {
  NumberRegistrationBloc();


  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose(){
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);


  Future<void> callCircularProgressIndicator() async {
    _setIsLoading(true);
    await Future.delayed(const Duration(milliseconds: 500));
    _setIsLoading(false);

  }


}
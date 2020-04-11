//import 'dart:async';
//
//import 'package:mygeneralshope/contract/contract.dart';
//
//class DotsStream implements Disposable {
//  int currentDot;
//  StreamController<int> _dotsStreamController = StreamController<int>.broadcast();
//
//  Stream<int> get dots => _dotsStreamController.stream;
//
//  StreamSink<int> get dotsSink => _dotsStreamController.sink;
//
//  DotsStream() {
//    _dotsStreamController.add(currentDot);
//    _dotsStreamController.stream.listen(_indexChange);
//  }
//
// void _indexChange(int newIndex) {
//    currentDot = newIndex;
//    _dotsStreamController.add(currentDot);
//  }
//
//
//
//  @override
//  void dispose() {
//    _dotsStreamController.close();
//  }
//}

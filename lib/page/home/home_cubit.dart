import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/main.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> initData() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    //CollectionReference users = FirebaseFirestore.instance.collection('users');
    await firestore.collection("users").get().then((event) {
      for (var doc in event.docs) {
        appLogger.i("${doc.id} => ${doc.data()}");
      }
    });
    //appLogger.i(await users.doc().get());
    emit(state.copyWith(loadStatus: LoadStatus.success));
  }
}

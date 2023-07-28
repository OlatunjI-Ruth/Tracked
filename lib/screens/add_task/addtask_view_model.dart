
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:tracked/constants/route_names_asigning.dart';
import 'package:tracked/model/task_model.dart';
import 'package:tracked/model/user_model.dart';
import 'package:tracked/services/auth_service.dart';
import 'package:tracked/services/firestore_service.dart';
import 'package:tracked/services/navigation_service.dart';
import 'package:tracked/utils/locator_setup.dart';
import 'package:tracked/utils/validation.dart';
import 'package:tracked/services/dialog_service.dart';

class AddTaskViewModel extends BaseViewModel{
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  static const menuDelete = "Delete"; /// menu option to delete
  final List<String> menuOptions = const <String> [
    menuDelete
  ];

  late UserModel? currentUser = _authenticationService.currentUser;
  Tasks? tasks;

  bool _isSwitched = false;
  bool get isSwitched => _isSwitched;

  ///TODO add the CRUD dart file here

  // void initControllers (String? titleController, var deadlineController, var yearController, var halfYearController, var quarterController, var monthController){
  //   titleController = tasks!.title != null ? tasks?.title : "";
  //   deadlineController = tasks!.deadline != null ? tasks?.deadline : "";
  //   yearController = tasks!.year != null ? Val.IntToBool(tasks!.year):false;
  //   halfYearController = tasks!.halfYear != null ? Val.IntToBool(tasks!.halfYear):false;
  //   quarterController = tasks!.quarter != null ? Val.IntToBool(tasks!.quarter):false;
  //   monthController = tasks!.month != null ? Val.IntToBool(tasks?.month!):false;
  //
  // }

  Future addTask({required String? title, required String? deadline}) async {

    setBusy(true);
    var result =  await _firestoreService.addPost(Tasks(title: title, id:currentUser!.id, deadline: deadline
    ));
    setBusy(false);

    if (result is String){
      await _dialogService.showDialog(
        title: "Could not add Post",
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully added',
        description: 'Your post has been created'
      );
    }
    _navigationService.goBack();
  }


  void switched(bool value){
    _isSwitched = value;
    notifyListeners();
  }

  Future selectDate (context, dateContrl) async{
    await showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2021), lastDate: DateTime(2026)).then((value) {
      if (value != null){
        dateContrl = DateFormat("yyyy-MM-dd").format(value);
      }
    });
  }

  // Future _chooseDate(context, String? initialDateString) async {
  //   DateTime now = DateTime.now();
  //   var initialDate = DateUtility.convertToDate(initialDateString!) ?? now;
  //
  //   initialDate = (initialDate.year >= now.year && initialDate.isAfter(now)
  //       ? initialDate
  //       : now);
  //
  //   DatePicker.showDatePicker(context, onConfirm: (date, _) {
  //     DateTime dt = date;
  //     String? r = DateUtility.ftDateAsString(dt);
  //     initialDateString = r;
  //     notifyListeners();
  //   }
  //     // currentTime:initialDate
  //   );
  // }
}
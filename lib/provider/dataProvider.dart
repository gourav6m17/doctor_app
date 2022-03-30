// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:my_doctor_app/pages/home/home.dart';

// class data extends ChangeNotifier {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   var dataType;
//   var selectedType;

//   Future<void> getData(selectedType) {
//     db.collection("doctors").where('doctorTypeList',
//         arrayContains: {'type': selectedType}).snapshots();
//   }

//   Future<void> drListData(BuildContext context, String selectedType) {
//     try {
//       db
//           .collection("doctors")
//           .where('doctorTypeList', arrayContains: {'type': selectedType})
//           .get()
//           .then((QuerySnapshot querySnapshot) {
//             querySnapshot.docs.forEach((element) {
//               var data = element.data();
//               dataType = data;
//               print("==========$data");
//             });
//           });
//       // db.collection("doctors").get().then((QuerySnapshot querySnapshot) {
//       //   querySnapshot.docs.forEach((doc) {
//       //     drObj = DrModel.fromJson(doc.data());
//       //     drList.add(drObj);
//       //   });
//       // });

//       // setState(() {
//       //   _isDataLoading = false;
//       // });
//     } catch (e) {
//       print("error:$e");
//     }
//   }
// }

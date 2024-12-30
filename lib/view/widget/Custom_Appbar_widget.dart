// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../constants/app_images.dart';
// import '../../constants/app_styling.dart';
// import '../screens/chat/chat_view.dart';
// import 'Custom_text_widget.dart';
// import 'common_image_view_widget.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String name;

//   const CustomAppBar({
//     required this.name,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: const Color(0xffF5F5F5),
//       title: Row(
//         children: [
//           CommonImageView(
//             imagePath: Assets.imagesMenuicon,
//             fit: BoxFit.contain,
//             width: 25,
//             height: 19,
//           ),
//           SizedBox(
//             width: w(context, 14),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomText(
//                 text: "Welcome Back!",
//                 size: 14,
//                 weight: FontWeight.w300,
//               ),
//               CustomText(
//                 text: name,
//                 size: 14,
//                 weight: FontWeight.w500,
//               ),
//             ],
//           ),
//           const Spacer(),
//           CommonImageView(
//             imagePath: Assets.imagesKing,
//             fit: BoxFit.contain,
//             width: 36,
//             height: 136,
//           ),
//           SizedBox(
//             width: w(context, 6),
//           ),
//           CommonImageView(
//             imagePath: Assets.imagesBell,
//             fit: BoxFit.contain,
//             width: 36,
//             height: 136,
//           ),
//           SizedBox(
//             width: w(context, 6),
//           ),
//           GestureDetector(
//             onTap: () {
//               Get.to(() => const ChatView());
//             },
//             child: CommonImageView(
//               imagePath: Assets.imagesMsg,
//               fit: BoxFit.contain,
//               width: 36,
//               height: 136,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

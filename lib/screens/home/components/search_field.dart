import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../store/days.dart';

class SearchField extends StatefulWidget {
  @override
  _SearcFieldState createState() => _SearcFieldState();
}

class _SearcFieldState extends State<SearchField> {
  DateTime today = DateTime.now();
  final TextEditingController _searchController =
      TextEditingController(text: '');

  final DaysState controller = Get.put(DaysState());

  void _inputValue() async {
    DateTime start_date =
        today.subtract(Duration(days: controller.rx_days.value));
    DateTime? new_date = await showDatePicker(
        context: context,
        initialDate: start_date,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (new_date == null) {
      return;
    }

    final new_days = DateTime.now().difference(new_date).inDays;
    controller.rx_days.value = new_days;
    setState(() {
      _searchController.value = _searchController.value.copyWith(
        text: Jiffy(new_date).format('dd/MM/yyy'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        readOnly: true,
        onTap: () => _inputValue(),
        controller: _searchController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Buscar streams a partir de...",
            prefixIcon: Icon(Icons.calendar_month)),
      ),
    );
  }
}

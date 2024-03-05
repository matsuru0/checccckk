import 'package:flutter/material.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_prototype/theme/pallete.dart';

class Search_bar extends StatelessWidget {
  Search_bar(this.sortType);
  final String sortType;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      return Container(
          width: 300,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Pallete.fieldFillColor,
            border: Constants.border,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 5, bottom: 5),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(Icons.search, color: Color(0xff7C7C7C)),
              SizedBox(
                width: 8,
              ),
              Container(
                width: 240,
                child: TextField(
                  onChanged: (value) {
                    ref
                        .read(clientNotifierProvider(sort: sortType).notifier)
                        .clientLookUp(value);
                  },
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 107, 107, 107), // Text color
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none, // Remove the border
                    hintText: 'Search...', // Optional hint text
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xff6C6C6C),
                    ),
                  ),
                  // Remove any other unnecessary properties or callbacks for your use case
                ),
              ),
            ]),
          ));
    });
  }
}

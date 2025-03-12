import 'package:flutter/material.dart';

class DiaryContent extends StatefulWidget {
  const DiaryContent({super.key});

  @override
  State<DiaryContent> createState() => _DiaryContentState();
}

class _DiaryContentState extends State<DiaryContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [Text('Открытые позиции')],
          ),
          Row(
            children: [Text('Трейды')],
          ),
          Row(
            children: [Text('Сделки')],
          ),
          Row(
            children: [Text('Транзакции')],
          ),
        ],
      ),
    );
  }
}

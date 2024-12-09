import 'package:flutter/material.dart';

class TotalMoney extends StatelessWidget {
  const TotalMoney({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("수입"),
              Text("지출"),
              Text("합계"),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "0",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              Text(
                "0",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              Text("0"),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

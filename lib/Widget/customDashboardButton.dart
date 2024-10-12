import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:flutter/material.dart';

class CustomDashboardButton extends StatefulWidget {
  final colors;
  final btnName;
  final String customIcon;
  final VoidCallback ontap;
  const CustomDashboardButton({
    super.key,
    required this.colors,
    required this.btnName,
    required this.customIcon,
    required this.ontap,
  });

  @override
  State<CustomDashboardButton> createState() => _CustomDashboardButtonState();
}

class _CustomDashboardButtonState extends State<CustomDashboardButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: widget.colors == Colors.orange
                    ? [Colors.orange, Colors.redAccent]
                    : widget.colors == Colors.green
                        ? [
                            const Color.fromARGB(255, 13, 124, 102),
                            Colors.green
                          ]
                        : widget.colors == Colors.pink
                            ? [
                                const Color.fromARGB(255, 146, 26, 64),
                                const Color.fromARGB(255, 199, 91, 122)
                              ]
                            : widget.colors == Colors.cyan
                                ? [
                                    const Color.fromARGB(255, 8, 125, 221),
                                    const Color.fromARGB(255, 102, 155, 247)
                                  ]
                                : []),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(3, 3),
                  color: Colors.grey.shade500.withOpacity(0.7),
                  spreadRadius: 1,
                  blurRadius: 5)
            ]),
        child: Padding(
          padding: EdgeInsets.only(
            top: paragraph,
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image(
                image: AssetImage(widget.customIcon),
                width: screenWidth / 10,
              ),
              Text(
                widget.btnName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: paragraph,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:acme/ui/app_color.dart';
import 'package:flutter/material.dart';

class TrackerTemplate extends StatefulWidget {
  final String title;
  final IconData iconData;
  final Widget centerWidget;
  final String data;
  final Function() onPressed;
  final Color? color;
  final Color? iconColor;
  const TrackerTemplate({
    Key? key,
    required this.title,
    required this.iconData,
    required this.centerWidget,
    required this.data,
    required this.onPressed,
    this.color = AppColors.primaryLight,
    this.iconColor = AppColors.white,
  }) : super(key: key);

  @override
  State<TrackerTemplate> createState() => _TrackerTemplateState();
}

class _TrackerTemplateState extends State<TrackerTemplate> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: widget.color,
      child: InkWell(
          onTap: () {
            widget.onPressed();
          },
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        widget.iconData,
                        size: 16,
                        color: widget.iconColor,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(widget.title)
                    ],
                  ),
                  Align(
                      alignment: Alignment.center, child: widget.centerWidget),
                  Text(
                    widget.data,
                    style: textTheme.bodyText2
                        ?.copyWith(fontSize: 16, color: widget.iconColor),
                  )
                ],
              ))),
    );
  }
}

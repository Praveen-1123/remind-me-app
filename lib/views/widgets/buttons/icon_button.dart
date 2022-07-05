import 'package:flutter/material.dart';
import 'package:remind_me/helpers/text_fade.dart';
import 'package:remind_me/views/widgets/loaders/spinning_lines.dart';

class ButtonWithIcon extends StatefulWidget {
  final bool isLoading;
  final String text;
  final EdgeInsetsGeometry margin;
  final double width;
  final Function onPressed;
  final IconData icon;

  const ButtonWithIcon({
    Key key,
    @required this.isLoading,
    @required this.onPressed,
    @required this.text,
    @required this.icon,
    this.margin,
    this.width,
  }) : super(key: key);

  @override
  _ButtonWithIconState createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<ButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      height: 50,
      margin: widget.margin != null ? widget.margin : null,
      width: widget.width != null ? widget.width : null,
      decoration: BoxDecoration(
        color: theme.focusColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.isLoading
              ? SpinningLines(
                  size: 25,
                  color: theme.scaffoldBackgroundColor,
                )
              : Icon(
                  widget.icon,
                  size: 27,
                  color: theme.scaffoldBackgroundColor,
                ),
          TextButton(
            onPressed: widget.isLoading ? null : widget.onPressed,
            child: CrossFade<String>(
              initialData: '',
              data: widget.text,
              builder: (value) => Text(
                value,
                style: TextStyle(
                  color: theme.scaffoldBackgroundColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

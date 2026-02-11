import 'package:flutter/material.dart';

class ExpandableCaption extends StatefulWidget {
  final String username;
  final String caption;

  const ExpandableCaption({super.key, required this.username, required this.caption});

  @override
  State<ExpandableCaption> createState() => _ExpandableCaptionState();
}

class _ExpandableCaptionState extends State<ExpandableCaption> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: RichText(
        softWrap: true,
        text: TextSpan(
          children: [
            TextSpan(
              text: '${widget.username} ',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
            ),
            TextSpan(
              text: widget.caption.length > 50
                  ? isExpanded
                        ? widget.caption
                        : widget.caption.substring(0, 50)
                  : widget.caption,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            if (!isExpanded && widget.caption.length > 50)
              TextSpan(
                text: ' ... more',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}

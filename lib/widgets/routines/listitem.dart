import 'package:flutter/material.dart';
import 'package:routines/models/routines.dart';

typedef  void CallbackRoutineItem(Routine routine);

// 1. Statefull or Stateless
class RoutineListItem extends StatelessWidget {
  final Routine routine;
  final CallbackRoutineItem onEditAction; // Callback typedef를 바꾸는 게 좋을 듯..
  final CallbackRoutineItem onDismissedAction;

  RoutineListItem(
      {Key key, this.routine, this.onDismissedAction, this.onEditAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(routine.id.toString()),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: <Widget>[
            Icon(Icons.delete_outline,
                color: Colors.white, semanticLabel: "Delete"),
            Text('Delete', style: TextStyle(color: Colors.white)),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
        ),
      ),
      // https://medium.com/flutter-community/an-in-depth-dive-into-implementing-swipe-to-dismiss-in-flutter-41b9007f1e0
      secondaryBackground: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerEnd,
        child: Row(
          children: <Widget>[
            Text('Delete', style: TextStyle(color: Colors.white)),
            Icon(Icons.delete_outline,
                color: Colors.white, semanticLabel: "Delete"),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
        ),
      ),
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.2,
        DismissDirection.endToStart: 0.2,
      },
      onDismissed: (direction) =>
          onDismissedAction(routine), // only one type dismissed support
      child: ListTile(
        title: Text('${routine.title}'),
        subtitle: Text('${routine.subtitle}'),
        // leading: Container(
        //   width: 20.0,
        //   color: routine.color,
        // ),
        leading: CircleAvatar(backgroundColor: routine.color,),
        onTap: () => onEditAction(routine),
      ),
    );
  }
}

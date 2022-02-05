import 'widget_base_event.dart';

class BottomNavChangedEvent extends WidgetBaseEvent {
  int index = 0;
  BottomNavChangedEvent(this.index);
  
}

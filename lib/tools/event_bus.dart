import 'package:event_bus/event_bus.dart';
import 'package:curv/models/figure.dart';

/// 创建EventBus
EventBus eventBus = EventBus();

/// Event 修改主题色
class RefreshQuanziEvent {
  Map msg;
  RefreshQuanziEvent(this.msg);
}

/// Event 修改主题色
class SocketEvent {
  Map msg;
  SocketEvent(this.msg);
}

/// Event 修改主题色
class SelectFigureEvent {
  Figure figure;
  SelectFigureEvent(this.figure);
}

class InputEvent {
  Map msg;
  InputEvent(this.msg);
}

class HideKeyboard {
  Map msg;
  HideKeyboard(this.msg);
}

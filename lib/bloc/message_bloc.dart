import 'package:local_chat/events/message_bloc.dart';

import '../events/router_events.dart';

import 'package:bloc/bloc.dart';

class MsgBloc extends Bloc<MsgEvent, String> {
  MsgBloc() : super("") {
    on<InMsgEvent>((event, emit) {
      String tmp = event.msg + event.from.deviceName.toString();
      emit(tmp);
    });
  }
}

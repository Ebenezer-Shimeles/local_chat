import 'package:bloc/bloc.dart';

import '../events/main_menu_events.dart';

class MainMenuBlocNavBarBloc extends Bloc<BottomNavChangedEvent, int> {
  MainMenuBlocNavBarBloc() : super(0) {
    on<BottomNavChangedEvent>((event, emit) => emit(event.index));
  }
}

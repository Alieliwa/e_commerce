
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/shared/cubit/app_states.dart';
import 'package:medica_zone_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppState());
    } else {
      isDark = !isDark;
      CacheHelper.putBooleanData(key: "isDark", value: isDark).then((value) {
        emit(ChangeAppState());
      });
    }
  }
}

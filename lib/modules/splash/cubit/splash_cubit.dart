import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone_app/modules/splash/cubit/splash_states.dart';

class SplashCubit extends Cubit<SplashSates> {
  SplashCubit() : super(SplashInitialState());

  static SplashCubit get(context) => BlocProvider.of(context);

  bool isLast = false;

  void changeState() {
    isLast = !isLast;
    emit(SplashChangeValueState());
  }
}

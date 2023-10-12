import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';
part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<RegisterEvent>(mapEventToState);
  }

  String _name = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String _nationality = '';
  bool _privacyChecked = false;

  void mapEventToState(RegisterEvent event, Emitter<RegisterState> emit) 
    async {

  if (event is RegisterEventName) {
    _name = event.name;
  }

  if (event is RegisterEventLastname) {
    _lastName = event.lastName;
  }

  if (event is RegisterEventEmail) {
    _email = event.email;
  }

  if (event is RegisterEventPassword) {
    _password = event.password;
  }

  if (event is RegisterEventNationality) {
    _nationality = event.nationality;
  }

  if (event is RegisterEventAgreement) {
    _privacyChecked = event.privacyChecked;
  }

  if (event is RegisterEventSend) {
    // do some action for example try to create an 
    // account in the database based on input
  }
    emit(getBlocState());
  }

  RegisterState getBlocState() {
    return RegisterState(
      name: _name,
      lastName: _lastName,
      email: _email,
      password: _password,
      nationality: _nationality,
      privacyChecked: _privacyChecked,
    );
  }
}
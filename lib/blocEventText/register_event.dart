part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterEventName extends RegisterEvent {
  RegisterEventName(this.name);
  final String name;
} 

class RegisterEventLastname extends RegisterEvent {
  RegisterEventLastname(this.lastName);
  final String lastName;
}

class RegisterEventEmail extends RegisterEvent {
  RegisterEventEmail(this.email);
  final String email;
}

class RegisterEventPassword extends RegisterEvent {
  RegisterEventPassword(this.password);
  final String password;
}

class RegisterEventNationality extends RegisterEvent {
  RegisterEventNationality(this.nationality);
  final String nationality;
}

class RegisterEventAgreement extends RegisterEvent {
  RegisterEventAgreement(this.privacyChecked);
  final bool privacyChecked;
}

class RegisterEventSend extends RegisterEvent {
  RegisterEventSend();
}
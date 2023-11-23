part of 'register_bloc.dart';

class RegisterState {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String nationality;
  final bool privacyChecked;

  RegisterState({
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.nationality = '',
    this.privacyChecked = false,
  });

  List<Object> get properties => [
    name,
    lastName,
    email,
    password,
    nationality,
    privacyChecked,
  ];
}
abstract class State{}

class UserLoadingState extends State{}

class UserEmptyState extends State{}

class UserLoadedState extends State {}

class UserErrorState extends State{}

class RegisterState extends State{
  final String name;
  final int tempBox;
  final int tempProd;
  final int time;
  final bool flap;
  final bool smoke;
  final bool parog;
  
  RegisterState({
    this.name = '',
    this.tempBox = 0,
    this.tempProd = 0,
    this.time = 0,
    this.flap = false,
    this.smoke = false,
    this.parog = false,
  });
}

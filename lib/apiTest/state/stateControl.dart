import 'package:get/get.dart';
import '../api/api_client_bron.dart';
import '../api/api_client_data.dart';
import '../api/api_client_room.dart';
import '../api/bron__json/bron.dart';
import '../api/data_json/data.dart';
import '../api/room_json/rooms.dart';
import '../main.dart';

class StateData extends GetxController {
  final apiClient = ApiClientData();
  final _data = Data().obs;
  Data get data => _data.value;

  RxInt page = 0.obs;
  int get p => page.value;

  RxBool isConnect = false.obs;
  bool get connect => isConnect.value;

  @override
  void onInit() {
    reloadPosts();
    super.onInit();
  }

  Future<void> reloadPosts() async {
    final posts = await apiClient.getPosts();
    _data.value = posts;
    if (_data.value.id == null) {
      isConnect.value = false;
    } else {
      isConnect.value = true;
    }
    update();
  }

  void nextPage(int index) {
    page.value = index;
    update();
  }
}

class StateRoom extends GetxController {
  final _rooms = Rooms().obs;
  Rooms get room => _rooms.value;
  final apiClient = ApiClientRoom();
  RxInt page = 0.obs;
  int get p => page.value;
  RxBool isConnect = false.obs;
  bool get connect => isConnect.value;

  @override
  void onInit() {
    reloadPosts();
    super.onInit();
  }

  Future<void> reloadPosts() async {
    final api = await apiClient.getPosts();
    _rooms.value = api;
    if (_rooms.value.rooms == null) {
      isConnect.value = false;
    } else {
      isConnect.value = true;
    }
    update();
  }

  void nextPage(int index) {
    page.value = index;
    update();
  }
}

class StateBron extends GetxController {
  final _bron = Bron().obs;
  Bron get bron => _bron.value;
  final apiClient = ApiClientBron();
  RxBool isConnect = false.obs;
  bool get connect => isConnect.value;

  @override
  void onInit() {
    reloadPosts();
    super.onInit();
  }

  Future<void> reloadPosts() async {
    final api = await apiClient.getPosts();
    _bron.value = api;
    if (_bron.value.id == null) {
      isConnect.value = false;
    } else {
      isConnect.value = true;
    }
    update();
  }

  int getSum() {
    return _bron.value.tourPrice! + _bron.value.fuelCharge! + _bron.value.serviceCharge!;
  }
}

class UserCard extends GetxController{
  RxList<CardInputUser> cardUsers = <CardInputUser>[const CardInputUser('Первый')].obs;
  int i = 0;
  List<String> enumNum = ['Второй', 'Третий', 'Четвертый', 'Пятый', 'Шестой', 'Седьмой', 'Восьмой', 'Девятый'];

  void addCard(){
    if (i < 9) {
      cardUsers.add(CardInputUser(enumNum[i]));
      i++;
    }
  }
}